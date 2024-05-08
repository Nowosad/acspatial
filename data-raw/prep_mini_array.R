library(imager)
library(httr)
image_url = 'https://github.com/andandandand/ImageAnalysisWithAlgorithmicInformation/blob/master/images/t2BrainSlice.png?raw=true'
image_file = tempfile(fileext = ".png")
GET(image_url, write_disk(image_file, overwrite = TRUE))
imag_array = load.image(image_file)

# Get a subset of the image
mini_array = imag_array[129:(128+8), 129:(128+8)]
mini_array = t(mini_array * 255)
dput(mini_array)

usethis::use_data(mini_array)
