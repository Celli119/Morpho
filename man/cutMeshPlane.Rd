% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/cutSpace.r
\name{cutMeshPlane}
\alias{cutMeshPlane}
\title{cut a mesh by a hyperplane and remove parts above/below that plane}
\usage{
cutMeshPlane(mesh, v1, v2 = NULL, v3 = NULL, normal = NULL,
  keep.upper = TRUE)
}
\arguments{
\item{mesh}{triangular mesh of class "mesh3d"}

\item{v1}{numeric vector of length=3 specifying a point on the separating plane}

\item{v2}{numeric vector of length=3 specifying a point on the separating plane}

\item{v3}{numeric vector of length=3 specifying a point on the separating plane}

\item{normal}{plane normal (overrides specification by v2 and v3)}

\item{keep.upper}{logical specify whether the points above or below the plane are should be kept}
}
\value{
mesh with part above/below hyperplane removed
}
\description{
cut a mesh by a hyperplane and remove parts above/below that plane
}
\details{
see \code{\link{cutSpace}} for more details.
}

