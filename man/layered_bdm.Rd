% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layered_bdm.R
\name{layered_bdm}
\alias{layered_bdm}
\title{A layered version of the Block Decomposition Method}
\usage{
layered_bdm(x, prep_data = TRUE)
}
\arguments{
\item{x}{A matrix or SpatRaster}

\item{prep_data}{A logical value indicating whether the input data should be preprocessed. See Details to learn more. Default is TRUE}
}
\value{
A numeric vector
}
\description{
A layered version of the Block Decomposition Method for calculation of algorithmic complexity
}
\details{
If \code{prep_data} is TRUE, the input data will be preprocessed before the algorithm is applied.
If the input data is a SpatRaster, the data will be normalized to the range from 1 to 255 with NA values set to 0, and converted to an integer matrix.
If the input data is a matrix, the data will be normalized to the range from 1 to 255 with NA values set to 0. If \code{prep_data} is FALSE, the input data will be used as is.
}
\examples{
data(mini_array)
layered_bdm(mini_array)
}
\references{
Rueda-Toicen, Antonio, Image Analysis with Estimations of Kolmogorov Complexity, (2018), GitHub repository, https://github.com/andandandand/ImageAnalysisWithAlgorithmicInformation, DOI: /10.5281/zenodo.1291510

Hector Zenil, Santiago Hernández-Orozco, Narsis A.Kiani, Fernando Soler-Toscano, Antonio Rueda-Toicen, and Jesper Tegner "A Decomposition Method for Global Evaluation of Shannon Entropy and Local Estimations of Algorithmic Complexity", https://arxiv.org/abs/1609.00110
}
