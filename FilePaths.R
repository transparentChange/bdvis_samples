'
new_FilePaths
This constructor provides a way of creating an object with class attribute "FilePath" whose base attribute is a character vector of file paths.
@param paths, a character vector of the names of the files
@param lastPathElement, a character describing the lowest level subdirectory the file is placed in
'
new_FilePaths <- function(paths = character(), lastPathElement) {
  stopifnot(is.character(paths))
  stopifnot(is.character(lastPathElement))
  
  for (i in (1:length(paths))) {
    paths[i] <- paste0(lastPathElement, paths[i])
  }
  
  structure(paths, class = "FilePath")
}