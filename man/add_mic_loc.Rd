% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_mic_loc.R
\name{add_mic_loc}
\alias{add_mic_loc}
\title{Calculating coordinates in pixels}
\usage{
add_mic_loc(Spots_df, xres = 0.1625, yres = 0.1625, zres = 0.25, x,
  y, z)
}
\arguments{
\item{Spots_df}{a dataframe with spots information and coordinates in microns}

\item{xres}{resolution in microns for the x dimension}

\item{yres}{resolution in microns for the y dimension}

\item{zres}{resolution in microns for the z dimension}

\item{x}{x coordinates in microns}

\item{y}{y coordinates in microns}

\item{z}{z coordinates in microns}
}
\value{
dataframe with three new columns
}
\description{
Calculating coordinates in pixels
}
