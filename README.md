
<!-- README.md is generated from README.Rmd. Please edit that file -->

# acspatial

<!-- badges: start -->

[![R-CMD-check](https://github.com/Nowosad/spatcomplexity/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Nowosad/spatcomplexity/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of **acspatial** is to provide a function to calculate the
layered block decomposition method (layered BDM) for spatial data. The
layered BDM is a method to estimate the algorithmic complexity of
spatial data, a measure of the amount of information in a data set. The
algorithmic complexity is calculated using the Kolmogorov complexity,
which is the length of the shortest computer program that can generate
the provided data set.

## Installation

You can install the development version of **acspatial** from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Nowosad/acspatial")
```

## Examples

``` r
library(acspatial)
# 1
data(mini_array)
mini_array
#>      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
#> [1,]   77   46   58   58   74   54   78   69
#> [2,]   93   53   66   71   56   56   62   64
#> [3,]   91   67   68   55   57   67   75   62
#> [4,]  136   71   64   64   66   63   65   80
#> [5,]  146   82   63   61   57   79   48   61
#> [6,]  140  102   67   57   65   52   56   43
#> [7,]  160  103   54   50   64   70   65   50
#> [8,]  166   81   56   56   54   63   62   49
```

``` r
layered_bdm(mini_array)
#> [1] 1817.884
```

``` r

# 2
mini_array2 = matrix(1, nrow = 8, ncol = 8)
mini_array2
#>      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
#> [1,]    1    1    1    1    1    1    1    1
#> [2,]    1    1    1    1    1    1    1    1
#> [3,]    1    1    1    1    1    1    1    1
#> [4,]    1    1    1    1    1    1    1    1
#> [5,]    1    1    1    1    1    1    1    1
#> [6,]    1    1    1    1    1    1    1    1
#> [7,]    1    1    1    1    1    1    1    1
#> [8,]    1    1    1    1    1    1    1    1
```

``` r
layered_bdm(mini_array2)
#> [1] 61.29548
```

## References

- Rueda-Toicen, Antonio, Image Analysis with Estimations of Kolmogorov
  Complexity, (2018), GitHub repository,
  <https://github.com/andandandand/ImageAnalysisWithAlgorithmicInformation>,
  DOI: /10.5281/zenodo.1291510
- Hector Zenil, Santiago Hernández-Orozco, Narsis A.Kiani, Fernando
  Soler-Toscano, Antonio Rueda-Toicen, and Jesper Tegner “A
  Decomposition Method for Global Evaluation of Shannon Entropy and
  Local Estimations of Algorithmic Complexity”,
  <https://arxiv.org/abs/1609.00110>
- <https://www.complexity-calculator.com/>
