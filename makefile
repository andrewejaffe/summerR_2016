all: render.R \
    Basic_R/lecture/Basic_R.Rmd \
    Intro/lecture/Intro.Rmd \
    Data_IO/lecture/Data_IO.Rmd \
    Knitr/lecture/Knitr.Rmd \
    Manipulating_Data_in_R/lecture/Manipulating_Data_in_R.Rmd
    R CMD batch render.R
