#' Plotting tracks
#' Plotting MaMuT tracks with custom color code
#'
#' @param track track name
#' @param Tracks_df Tracks_df
#' @param Spots_Tracks Spots_df with Track name
#' @param colNode color of the nodes, use colNode_discrete to specify if discrete or continuous
#' @param colYaxis display or not y axis
#' @param colNode_discrete discrete or continuous, default to FALSE e.g. continuous
#' @importFrom dplyr enquo
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 element_line
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 facet_wrap
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 scale_y_continuous
#' @importFrom ggplot2 theme
#' @importFrom ggraph create_layout
#' @importFrom ggraph geom_edge_link
#' @importFrom ggraph geom_node_point
#' @importFrom igraph graph_from_data_frame
#' @importFrom purrr map_chr
#' @importFrom viridis scale_color_viridis
#'
#' @return
#' @export
#'
#' @examples

track2plot <- function(track, Tracks_df, Spots_Tracks, colNode, colYaxis, colNode_discrete) {

  colNode <- enquo(colNode)
  Track_graph <- graph_from_data_frame(
    filter(Tracks_df, TRACK_ID == track),
    directed = TRUE,
    vertices = filter(Spots_Tracks, TRACK_ID == track))

  track_layout <- create_layout(Track_graph, "dendrogram") # should be turned back to dendrogram when everything works - auto for tests

  attr_track_layout <- attributes(track_layout)

  track_layout <- track_layout %>% # correcting the position of nodes according to POSITION_T
    mutate(y = -POSITION_T + max(POSITION_T))

  timeLab <- rev(map_chr(
    .x = as.numeric(as.character(unique(track_layout[,"FRAME"])))/2, .f = int2hours))

  attributes(track_layout) <- attr_track_layout

  g <- ggplot(track_layout) +
    geom_edge_link(aes(x,y))+
    # geom_edge_link(aes(x, y), arrow = arrow(angle = 30, length = unit(0.15, "inches"),
    #   ends = "last", type = "open")) + #arrow used to check the orientation of the graph
    geom_node_point(aes(x, y, colour=FRAME))+   #!!colNode) ))  +
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
    ) +
    scale_color_viridis(discrete = colNode_discrete)
  return(g)
}

