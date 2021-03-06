## ----cor1, comment="",prompt=TRUE----------------------------------------
circ = read.csv("http://www.aejaffe.com/summerR_2016/data/Charm_City_Circulator_Ridership.csv", 
           header=TRUE,as.is=TRUE)
cor(circ$orangeAverage, circ$purpleAverage)
cor(circ$orangeAverage, circ$purpleAverage, use="complete.obs")

## ----cor2, comment="",prompt=TRUE----------------------------------------
signif(cor(circ[,grep("Average",names(circ))], 
            use="complete.obs"),3)
signif(cor(circ[,grep("Average",names(circ))], 
           use="pair"),3)

## ----cor3, comment="",prompt=TRUE----------------------------------------
signif(cor(circ[,3:4],circ[,5:6], use="complete.obs"),3)

## ----cor4, comment="",prompt=TRUE----------------------------------------
ct= cor.test(circ$orangeAverage,
    circ$purpleAverage, use="complete.obs")
ct

## ----cor4a, comment="",prompt=TRUE, fig.height=4,fig.width=4-------------
plot(circ$orangeAverage, circ$purpleAverage,
     xlab="Orange Line", ylab="Purple Line",
     main="Average Ridership",cex.axis=1.5,
     cex.lab=1.5,cex.main=2)
legend("topleft", paste0("r=", signif(ct$estimate,3)), 
       bty="n",cex=1.5)

## ----cor5, comment="",prompt=TRUE----------------------------------------
# str(ct)
names(ct)
ct$statistic
ct$p.value

## ----tt1, comment="",prompt=TRUE-----------------------------------------
tt = t.test(circ$orangeAverage, circ$purpleAverage)
tt

## ----tt1_1, comment="", prompt=TRUE--------------------------------------
names(tt)

## ----tt2, comment="",prompt=TRUE,cache=TRUE------------------------------
http_data_dir = "http://www.aejaffe.com/summerR_2016/data/"
cars = read.csv(paste0(http_data_dir, "kaggleCarAuction.csv"),
                as.is=TRUE)
tt2 = t.test(VehBCost~IsBadBuy, data=cars)
tt2$estimate

## ----tt3, comment="",prompt=TRUE, fig.height=4,fig.width=4,cache=TRUE----
boxplot(VehBCost~IsBadBuy, data=cars, 
        xlab="Bad Buy",ylab="Value",
        names = c("Good","Bad"))
leg = paste("t=", signif(tt2$statistic,3), 
    " (p=",signif(tt2$p.value,3),")",sep="")
legend("topleft", leg, cex=1.2, bty="n")

## ----regress1, comment="",prompt=TRUE------------------------------------
fit = lm(VehBCost~IsBadBuy, data=cars)
fit

## ----regress2, comment="",prompt=TRUE------------------------------------
sfit = summary(fit)
print(sfit)

## ----regress3, comment="",prompt=TRUE------------------------------------
names(sfit)
sfit$coef

## ------------------------------------------------------------------------
fit = lm(VehOdo~VehicleAge, data=cars)
print(fit)

## ----regress4, comment="",prompt=TRUE, fig.height=4,fig.width=8,cache=TRUE----
library(scales) # we need this for the alpha command - make points transparent
par(mfrow=c(1,2))
plot(VehOdo ~ jitter(VehicleAge,amount=0.2), data=cars, pch = 19,
     col = alpha("black",0.05), xlab="Vehicle Age (Yrs)")
abline(fit, col="red",lwd=2)
legend("topleft", paste("p =",summary(fit)$coef[2,4]))
boxplot(VehOdo ~ VehicleAge, data=cars, varwidth=TRUE)
abline(fit, col="red",lwd=2)

## ----regress5, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
fit2 = lm(VehOdo ~ IsBadBuy + VehicleAge, data=cars)
summary(fit2)  

## ----avplot, comment="",prompt=TRUE, fig.height=4,fig.width=8------------
library(car)
avPlots(fit2)

## ----plot_lm, comment="",prompt=TRUE, fig.height=4,fig.width=8-----------
par(mfrow=c(2,2))
plot(fit2, ask= FALSE)

## ----regress6, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
cars$TopThreeAmericanName[cars$TopThreeAmericanName == "NULL"] = NA
cars$TopThreeAmericanName = factor(cars$TopThreeAmericanName)
cars$TopThreeAmericanName = relevel(cars$TopThreeAmericanName, "OTHER")
fit3 = lm(VehOdo ~ TopThreeAmerican, data=cars)
summary(fit3)  

## ----regress7, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
glmfit = glm(IsBadBuy ~ VehOdo + VehicleAge, data=cars, family=binomial())
summary(glmfit)  

## ----regress8, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
exp(coef(glmfit))

## ----prop1, comment="",prompt=TRUE---------------------------------------
prop.test(x=15, n =32)

## ----chisq1, comment="",prompt=TRUE--------------------------------------
tab = table(cars$IsBadBuy, cars$IsOnlineSale)
tab

## ----chisq2, comment="",prompt=TRUE--------------------------------------
cq=chisq.test(tab)
cq
names(cq)
cq$p.value

## ----chisq3, comment="",prompt=TRUE--------------------------------------
chisq.test(tab)
prop.test(tab)

## ----fish.test, comment="",prompt=TRUE-----------------------------------
fisher.test(tab)

## ----rnorm, comment="",prompt=TRUE---------------------------------------
rnorm(5)

## ----sample, comment="",prompt=TRUE--------------------------------------
sample(1:10, 5, replace=FALSE)

## ----samp_plot, comment="",prompt=TRUE, fig.height=4,fig.width=4---------
samp.cars <- cars[ sample(nrow(cars), 10000), ]
plot(VehOdo ~ jitter(VehBCost,amount=0.3), data= samp.cars)  

