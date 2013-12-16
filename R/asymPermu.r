#' Assess differences in amount and direction of asymmetric variation
#'
#' Assess differences in amount and direction of asymmetric variation
#'
#' @param x object of class symproc result from calling \code{\link{procSym}} with \code{pairedLM} specified
#' @param groups factors determining grouping.
#' @param rounds number of permutations
#' @param which in case the factor levels are >2 this determins which
#' factorlevels to use
#' @param mc.cores integer: determines how many cores to use for the
#' computation. The default is autodetect. But in case, it doesn't work as
#' expected cores can be set manually. Parallel processing is disabled on
#' Windows due to occasional errors.
#' @return
#' \item{dist }{difference between vector lengths of group means}
#' \item{angle }{angle between vectors of group specific asymmetric deviation}
#' \item{means }{actual group averages}
#' \item{p.dist }{p-value obtained by comparing the actual distance to randomly acquired distances}
#' \item{p.angle }{p-value obtained by comparing the actual angle to randomly acquired angles}
#'  \item{permudist }{vector containing differences between random group means' vector lenghts}
#'  \item{permuangle }{vector containing angles between random group means' vectors}
#'
#'
#' @export 
asymPermute <- function(x,groups,rounds=1000,which=1:2) {

    if (!inherits(x,"symproc"))
        stop("please provide object of class 'symproc'")
        
    if (is.list(x))
        asym <- vecx(x$Asym)
    else
        asym <- x
    groups <- factor(groups)
    class(asym) <- "symproc"
    lev <- levels(groups)
    if (length(lev) > 2) {
        use <- which(groups %in% lev[which])
        groups <- factor(groups[use])
        lev <- levels(groups)
        asym <- asym[use,]
    }
    mean1 <- meanMat(asym[groups == lev[1],])
    mean2 <- meanMat(asym[groups == lev[2],])

    shaker <- .Call("asymPerm",asym,as.integer(groups),as.integer(rounds))
    l.diff <- shaker$diff[1]
    a.diff <- shaker$angle[1]
    out <- list()
    out$dist <- l.diff
    out$angle <- a.diff
    if (rounds > 0) {
        sample.dists <- shaker$diff[-1]
        sample.angle <- shaker$angle[-1]
        ## calculate p-values
        p.angle <- length(which(sample.angle >= a.diff))
        if (!!p.angle) {
            p.angle <- p.angle/rounds
            names(p.angle) <- "p-value"
        } else {
            p.angle <- 1/rounds
            names(p.angle) <- "p-value <"
        }
        p.dist <- length(which(sample.dists >= l.diff))
        if (!!p.dist) {
            p.dist <- p.dist/rounds
            names(p.dist) <- "p-value"
        } else {
            p.dist <- 1/rounds
            names(p.dist) <- "p-value <"
        }
        out$p.dist <- p.dist
        out$p.angle <- p.angle
        out$permudist <- sample.dists
        out$permuangle <- sample.angle
    }
        
    return(out)
}
