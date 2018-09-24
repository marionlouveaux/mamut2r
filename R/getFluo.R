# Retrieving fluorescence

#' Extracting fluorescence values
#' Extracting fluorescence values in an .h5 file in the BigDataViewer format around given coordinates
#'
#' @param x_px name of the column with x coordinates in pixels
#' @param y_px name of the column with y coordinates in pixels
#' @param z_px name of the column with z coordinates in pixels
#' @param Spots_df dataframe containing on each rows spots locations at which to retrieve fluorescent values
#' @param timepoint name of the column where the timepoints or frames are stored
#' @param cubeSize half the length of the cube side length. By default the cube is 10x10x10 pixels.
#'
#' @importFrom rhdf5 h5read
#' @importFrom rhdf5 h5closeAll
#' @importFrom dplyr enquo
#' @importFrom dplyr select
#' @importFrom dplyr filter
#'
#' @return a list of length equal to the number of timepoints. For each timepoint, values of fluorescence around each spot location
#' @export
#'
#' @examples

getFluo <- function(x_px = x_px, y_px = y_px, z_px = z_px, Spots_df, timepoint = FRAME, cubeSize = 5) {

  x_px <- enquo(x_px)
  y_px <- enquo(y_px)
  z_px <- enquo(z_px)
  timepoint <- enquo(timepoint)

  all_timepoints <- Spots_df %>% select(!!timepoint) %>%
    unique()

  all_cells <- sapply(unique(as.numeric(Spots_df$FRAME)), function(t){

    t <- formatC(t, width=3, flag="0")

    ## filter frame, select coord cols and transform to list
    S <- filter(Spots_df, FRAME == as.numeric(t)) %>%
      select(name, (!!x_px), (!!y_px), (!!z_px)) %>% ## NB: x,y,z: coords in pixels whereas POSITION_...: coords in microns
      split(1:nrow(.))

    ## extract the cube of pixels for each cell
    cells <- lapply(S, function(coords, H5_path) {
      nameSpot <- coords$name
      coords <- as.integer(coords[2:4])
      pixels <- h5read(file = H5_path, name = glue("/t00{t}/s00/0/cells"), #for small example, green channel in s01; check how are channels in bioutifoul
                       index = list((coords[1]-cubeSize):(coords[1]+cubeSize),
                                    (coords[2]-cubeSize):(coords[2]+cubeSize),
                                    (coords[3]-cubeSize):(coords[3]+cubeSize)))
      h5closeAll()
      return(list(t, nameSpot, pixels))
    },
    H5_path)
    ## cells is a list with one entry per cell consisting of a cube of (2xcubeSize)^3 pixels
    cells
  })
  return(all_cells)
}




