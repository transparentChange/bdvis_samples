"
[VisualizationsCompilation.R]
This script is a generic program for combining several png files into one image
such that they are placed in a grid-like manner
Matthew Sekirin
December 22nd, 2019
"

library(png)

imagesList <- list.files(pattern = ".png")
rl <- lapply(imagesList, png::readPNG)
gl <- lapply(rl, grid::rasterGrob)
do.call(gridExtra::grid.arrange, gl)