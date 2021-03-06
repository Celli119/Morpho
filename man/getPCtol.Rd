% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/PCmeaning.r
\name{getPCtol}
\alias{getPCtol}
\title{determine the minimum ratio for two subsequent eigenvalues to be considered different}
\usage{
getPCtol(n, expect = 2)
}
\arguments{
\item{n}{sample size}

\item{expect}{expectation value for chi-square distribution of df=2}
}
\value{
returns the minimum ratio between two subsequent subsequent eigenvalues to be considered different.
}
\description{
determine the minimum ratio for two subsequent eigenvalues to be considered different
}
\examples{
## reproduce the graph from Bookstein (2014, p. 324)
## and then compare it to ratios for values to be considered
## statistically significant
myseq <- seq(from=10,to = 50, by = 2)
myseq <- c(myseq,seq(from=50,to=1000, by =20))
ratios <- getPCtol(myseq)
plot(log(myseq),ratios,cex=0,xaxt = "n",ylim=c(1,5.2))
ticks <- c(10,20,50,100,200,300,400,500,600,700,800,900,1000)
axis(1,at=log(ticks),labels=ticks)
lines(log(myseq),ratios)
abline(v=log(ticks), col="lightgray", lty="dotted")
abline(h=seq(from=1.2,to=5, by = 0.2), col="lightgray", lty="dotted")

## now we raise the bar and compute the ratios for values
## to be beyond the 95th percentile of
## the corresponding chi-square distribution:
ratiosSig <- getPCtol(myseq,expect=qchisq(0.95,df=2))
lines(log(myseq),ratiosSig,col=2)
}
\references{
Bookstein, F. L. Measuring and reasoning: numerical inference in the sciences. Cambridge University Press, 2014
}
\seealso{
\code{\link{getMeaningfulPCs}}
}

