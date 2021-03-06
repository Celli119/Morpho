% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/tps3d.r
\name{tps3d}
\alias{tps3d}
\title{thin plate spline mapping (2D and 3D) for coordinates and triangular meshes}
\usage{
tps3d(x, refmat, tarmat, lambda = 1e-08, ...)
}
\arguments{
\item{x}{matrix - e.g. the matrix information of vertices of a given
surface or a triangular mesh of class "mesh3d"}

\item{refmat}{reference matrix - e.g. landmark configuration on a surface}

\item{tarmat}{target matrix - e.g. landmark configuration on a target
surface}

\item{lambda}{numeric: regularisation parameter of the TPS.}

\item{...}{additional arguments, currently not used.}
}
\value{
returns the deformed input
}
\description{
maps landmarks or a triangular mesh via thin plate spline based on a reference and
a target configuration in 2D and 3D
}
\examples{
data(nose)
## define some landmarks
refind <- c(1:3,4,19:20)
## use a subset of shortnose.lm as anchor points for a TPS-deformation
reflm <- shortnose.lm[refind,]
tarlm <- reflm
##replace the landmark at the tip of the nose with that of longnose.lm
tarlm[4,] <- longnose.lm[4,]
##  deform a set of semilandmarks by applying a TPS-deformation
##  based on 5 reference points
deformed <- tps3d(shortnose.lm, reflm, tarlm)
\dontrun{
##visualize results by applying a deformation grid
deformGrid3d(shortnose.lm,deformed,ngrid = 5)


data(nose)##load data
##warp a mesh onto another landmark configuration:
warpnose.long <- tps3d(shortnose.mesh,shortnose.lm,longnose.lm)


require(rgl)
shade3d(warpnose.long,col=skin1)
}

data(boneData)
## deform mesh belonging to the first specimen
## onto the landmark configuration of the 10th specimen

\dontrun{
warpskull <- tps3d(skull_0144_ch_fe.mesh,boneLM[,,1],
                     boneLM[,,10])
## render deformed mesh and landmarks
shade3d(warpskull, col=2, specular=1)
spheres3d(boneLM[,,1])
## render original mesh
shade3d(skull_0144_ch_fe.mesh, col=3, specular=1)
spheres3d(boneLM[,,10])

}
}
\author{
Stefan Schlager
}
\references{
Bookstein FL. 1989. Principal Warps: Thin-plate splines and the
decomposition of deformations. IEEE Transactions on pattern analysis and
machine intelligence 11(6).
}
\seealso{
\code{\link{computeTransform}, \link{applyTransform}}
}

