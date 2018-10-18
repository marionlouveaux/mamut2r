#' Plotting tracks
#' Plotting MaMuT tracks with custom color code
#'
#' @param track track name
#' @param Tracks_df Tracks_df
#' @param Spots_Tracks Spots_df with Track name
#' @param colNode color of the nodes, use colNode_discrete to specify if discrete or continuous
#' @param colYaxis display or not y axis
#' @param colNode_discrete Logical. discrete scale if TRUE, continuous otherwise. Default to FALSE e.g. continuous.
#' @param breaks vector of levels used to plot discrete color legend with regards to colNode unique values. Only if colNode_discrete is TRUE
#'
#' @importFrom cellviz3d int2hours
#' @importFrom dplyr enquo filter mutate pull select
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 element_line
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 facet_wrap
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 scale_y_continuous scale_color_viridis_d scale_color_viridis_c
#' @importFrom ggplot2 theme
#' @importFrom ggraph create_layout
#' @importFrom ggraph geom_edge_link
#' @importFrom ggraph geom_node_point
#' @importFrom igraph graph_from_data_frame
#' @importFrom purrr map_chr
#'
#' @return a plot
#' @export
#'
#' @examples
#' \dontrun{
#' track2plot(track, Tracks_df, Spots_Tracks, colNode, colYaxis, colNode_discrete, breaks)
#' }

track2plot <- function(track, Tracks_df, Spots_Tracks, colNode, colYaxis, colNode_discrete, breaks) {
# browser()
stopifnot(length(track)==1)
  colNode <- enquo(colNode)

  colNode_vector <- Spots_Tracks %>%
    filter(TRACK_ID == track) %>%
    select(!!colNode) %>% pull()

  if ((isTRUE(colNode_discrete) & !missing(breaks))) {
    colNode_vector <- colNode_vector %>%
      factor(levels = breaks)
  }

  Track_graph <- graph_from_data_frame(
    filter(Tracks_df, TRACK_ID == track),
    directed = TRUE,
    vertices = filter(Spots_Tracks, TRACK_ID == track))

  track_layout_tmp <- create_layout(Track_graph, "dendrogram") # should be turned back to dendrogram when everything works - auto for tests

  attr_track_layout <- attributes(track_layout_tmp)

  track_layout <- track_layout_tmp %>% # correcting the position of nodes according to POSITION_T
    mutate(y = -POSITION_T + max(POSITION_T))

  timeLab <- rev(map_chr(
    .x = as.numeric(as.character(unique(track_layout[,"FRAME"])))/2, .f = int2hours))

  attributes(track_layout) <- attr_track_layout

  g <- ggplot(track_layout) +
    geom_edge_link(aes(x,y))+
    # geom_edge_link(aes(x, y), arrow = arrow(angle = 30, length = unit(0.15, "inches"),
    #   ends = "last", type = "open")) + #arrow used to check the orientation of the graph
    geom_node_point(aes(x, y, colour=colNode_vector) )  +
    facet_wrap(~TRACK_ID) +
    ylab("Time (in hours)") +
    theme(
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.x=element_blank(),
      axis.line.x=element_blank(),
      axis.line.y=element_line(colour = colYaxis),
      axis.ticks.y=element_line(colour = "black"),
      axis.text.y=element_text(colour="black"),
      axis.title.y=element_text(colour=colYaxis)
    )+
    theme(legend.position = "none")  +
    scale_y_continuous(breaks = seq(1, length(timeLab), 2)-1, # displays only a few ticks - only valid for continuous vars
                       labels = timeLab[seq(1, length(timeLab), 2)]
    )

  if (isTRUE(colNode_discrete) & missing(breaks)) {
    g <- g + scale_color_viridis_d()
  }else if (isTRUE(colNode_discrete) & !missing(breaks)) {
    g <- g + scale_color_viridis_d(name = as.character(colNode)[2], breaks = breaks, labels = breaks, drop = FALSE)
  }else{
    g <- g + scale_color_viridis_c()
  }

  return(g)
}

