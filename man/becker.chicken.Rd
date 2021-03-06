\name{becker.chicken}
\alias{becker.chicken}
\docType{data}
\title{
  Mating crosses of chickens
}
\description{
  Mating crosses of chickens
}
\usage{data("becker.chicken")}
\format{
  A data frame with 45 observations on the following 3 variables.
  \describe{
    \item{\code{male}}{male parent}
    \item{\code{female}}{female parent}
    \item{\code{weight}}{weight (g) at 8 weeks}
  }
}
\details{
  
  From a large flock White Rock chickens, five male sires were chosen
  and mated to each of three female dams, producing 3 female progeny.
  The data are body weights at eight weeks of age.

  Becker (1984) used these data to demonstrate the calculation of
  heritability.
  
}

\source{  
  Walter A. Becker (1984).
  \emph{Manual of Quantitative Genetics}, 4th ed. Page 83.
}

\references{
  None
}

\examples{

data(becker.chicken)
dat <- becker.chicken

if(require(lattice)){
  dotplot(weight ~ female, data=dat, group=male,
          main="becker.chicken - progeny weight by M*F",
          xlab="female parent",ylab="progeny weight",
          auto.key=list(columns=5))
}

\dontrun{
  # Sums match Becker
  sum(dat$weight)
  aggregate(weight ~  male + female, dat, FUN=sum)

  # Variance components
  require(lme4)
  require(lucid)
  m1 <- lmer(weight ~  (1|male) + (1|female), data=dat)
  as.data.frame(lme4::VarCorr(m1))
  ## grp        var1 var2      vcov    sdcor
  ## 1   female (Intercept) <NA> 1095.6296 33.10030
  ## 2     male (Intercept) <NA>  776.7543 27.87031
  ## 3 Residual        <NA> <NA> 5524.4000 74.32631

  # Calculate heritabilities
  s2m <- 776  # variability for males
  s2f <- 1095 # variability for females
  s2w <- 5524 # variability within crosses
  vp <- s2m + s2f + s2w # 7395
  4*s2m/vp # .42 male heritability
  4*s2f/vp # .59 female heritability

}

}

\keyword{datasets}
