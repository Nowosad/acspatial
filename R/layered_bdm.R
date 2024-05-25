#' A layered version of the Block Decomposition Method
#'
#' A layered version of the Block Decomposition Method for calculation of algorithmic complexity
#'
#' @param x A matrix or SpatRaster
#' @param prep_data A logical value indicating whether the input data should be preprocessed. See Details to learn more. Default is TRUE
#'
#' @return A numeric vector
#' @export
#'
#' @details If `prep_data` is TRUE, the input data will be preprocessed before the algorithm is applied.
#' If the input data is a SpatRaster, the data will be normalized to the range from 1 to 255 with NA values set to 0, and converted to an integer matrix.
#' If the input data is a matrix, the data will be normalized to the range from 1 to 255 with NA values set to 0. If `prep_data` is FALSE, the input data will be used as is.
#'
#' @references Rueda-Toicen, Antonio, Image Analysis with Estimations of Kolmogorov Complexity, (2018), GitHub repository, https://github.com/andandandand/ImageAnalysisWithAlgorithmicInformation, DOI: /10.5281/zenodo.1291510
#' @references Hector Zenil, Santiago Hernández-Orozco, Narsis A.Kiani, Fernando Soler-Toscano, Antonio Rueda-Toicen, and Jesper Tegner "A Decomposition Method for Global Evaluation of Shannon Entropy and Local Estimations of Algorithmic Complexity", https://arxiv.org/abs/1609.00110
#'
#' @examples
#' data(mini_array)
#' layered_bdm(mini_array)
layered_bdm = function(x, prep_data = TRUE) {
  if (inherits(x, "SpatRaster")){
    if (prep_data){
      x = prep_raster(x)
    } else {
      x = terra::as.matrix(terra::as.int(x), wide = TRUE)
    }
  } else if (inherits(x, "matrix") && prep_data){
    x = prep_matrix(x)
  }
  # Get the dimensions of the image
  dim_x = dim(x)[1]
  dim_y = dim(x)[2]

  binary_blocks = vector(mode = "list", length = (dim_x - 3) * (dim_y - 3) * 256)
  i = 1
  for(a in 1:(dim_x - 3)) {
    for(b in 1:(dim_y - 3)) {
      block = x[a:(a + 3), b:(b + 3)]
      for(thresh in 0:255) {
        bin_array = as.integer(block == thresh)
        binary_blocks[[i + thresh]] = paste(bin_array, collapse = "")
      }
      i = i + 256
    }
  }

  unique_blocks = unique(binary_blocks)
  block_counts = table(unlist(binary_blocks))

  return(sum(sapply(unique_blocks, function(x) ctms_dict[[x]])) + sum(log2(block_counts)))
}

prep_raster = function(r){
  max_r = terra::global(r, "max", na.rm = TRUE)[, 1]
  min_r = terra::global(r, "min", na.rm = TRUE)[, 1]
  r = ((r - min_r) / (max_r - min_r)) * 254 + 1
  r[is.na(r)] = 0
  r = terra::as.int(r)
  m = terra::as.matrix(r, wide = TRUE)
  return(m)
}

prep_matrix = function(m){
  max_m = max(m, na.rm = TRUE)
  min_m = min(m, na.rm = TRUE)
  m = ((m - min_m) / (max_m - min_m)) * 254 + 1
  m[is.na(m)] = 0
  storage.mode(m) = "integer"
  return(m)
}


