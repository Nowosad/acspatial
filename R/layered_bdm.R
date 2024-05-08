#' Title
#'
#' @param A matrix or SpatRaster
#'
#' @return A numeric vector
#' @export
#'
#' @examples
#' data(mini_array)
#' layered_bdm(mini_array)
layered_bdm = function(x) {
  if (inherits(x, "SpatRaster")){
    x = prep_raster(x)
  } else if (inherits(x, "matrix")){
    x = prep_matrix(x)
  }
  # Get the dimensions of the image
  dim_x = dim(x)[1]
  dim_y = dim(x)[2]

  binary_blocks = vector(mode = "list", length = (dim_x - 3) * (dim_y - 3) * 256)
  i = 1
  for(a in 1:(dim_x-3)) {
    for(b in 1:(dim_y-3)) {
      # Create a block
      block = x[a:(a+3), b:(b+3)]
      # thresh_vector <- 0:255
      # bin_arrays <- lapply(thresh_vector, function(thresh) as.integer(block == thresh))
      # binary_blocks[i:(i+255)] = lapply(bin_arrays, function(bin_array) paste(bin_array, collapse = ""))
      for(thresh in 0:255) {
        bin_array = as.integer(block == thresh)
        # str(block == thresh)
        binary_blocks[[i + thresh]] = paste(bin_array, collapse = "")
      }
      i = i + 256
    }
  }

  # binary_blocks = vector(mode = "character", length = (dim_x - 3) * (dim_y - 3) * 256)
  # i = 1
  # for(a in 1:(dim_x-3)) {
  #   for(b in 1:(dim_y-3)) {
  #     # Create a block
  #     block = x[a:(a+3), b:(b+3)]
  #     thresh_vector <- 0:255
  #     bin_arrays <- lapply(thresh_vector, function(thresh) as.integer(block == thresh))
  #     binary_blocks[i:(i+255)] = vapply(bin_arrays, function(bin_array) paste(bin_array, collapse = ""), character(1))
  #     # for(thresh in 0:255) {
  #     #   bin_array = as.integer(block == thresh)
  #     #   str(block == thresh)
  #     #   binary_blocks[[i + thresh]] = paste(bin_array, collapse = "")
  #     # }
  #     i = i + 256
  #   }
  # }
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


