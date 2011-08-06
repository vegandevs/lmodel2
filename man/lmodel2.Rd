\encoding{UTF-8}
\name{lmodel2}
\alias{lmodel2}
\alias{plot.lmodel2}
\alias{lines.lmodel2}
\alias{permutest.lmodel2}

\title{Model II regression}

\description{ This function computes model II simple linear
regression using the following methods: ordinary least squares (OLS),
major axis (MA), standard major axis (SMA), and ranged major axis
(RMA). The model only accepts one response and one explanatory
variable. }

\usage{
lmodel2(formula, data = NULL, range.y=NULL, range.x=NULL, nperm=0)
}

\arguments{
  \item{formula }{ A formula specifying the bivariate model, as in
  \code{\link{lm}} and \code{\link{aov}}. }
  \item{data}{ A data frame containing the two variables specified in the formula. }
  \item{range.y, range.x}{ Parametres for ranged major axis regression
  (RMA). If \code{range.y = NULL} and \code{range.x = NULL}, RMA will
  not be computed. If only one of them is \code{NULL}, the program will stop.  
  If \code{range.y = "relative"}: variable \code{y} has a true zero
  (relative-scale variable). If \code{range.y = "interval"}: variable
  \code{y} possibly includes negative values (interval-scale
  variable). If \code{range.x = "relative"}: variable \code{x} has a
  true zero (relative-scale variable). If \code{range.x = "interval"}:
  variable \code{x} possibly includes negative values (interval-scale
  variable)  }
  \item{nperm}{ Number of permutations for the tests. If \code{nperm =
   0}, tests will not be computed. } 
} 

\details{
  Model II regression should be used when the two variables in the
  regression equation are random, i.e. not controlled by the
  researcher. Model I regression using least squares underestimates
  the slope of the linear relationship between the variables when they
  both contain error. Ordinary least squares (OLS) is, however, appropriate 
  in some cases as a model II regression model; see the \dQuote{Model
  II User's guide, R edition} which you can read using command
  \code{vignette("mod2user")}. 

  The model II regression methods of ordinary least squares (OLS),
  major axis (MA), standard major axis (SMA), and ranged major axis
  (RMA) are described in Legendre and Legendre (1998, Section
  10.3.2). OLS, MA, and SMA are also described in Sokal and Rohlf
  (1995). The PDF document \dQuote{Model II User's guide, R edition}
  provided with this function contains a tutorial for model II
  regression, and can be read with command
  \code{vignette("mod2user")}. 
  
  The \code{plot} function plots the data points together with one of the
  regression lines, specified by \code{method="OLS"}, \code{method="MA"} (default),
  \code{method="SMA"}, or \code{method="RMA"}, and its 95 percent confidence interval.
}

\value{
  The default output provides the regression output. It draws
  information from a list, produced by function \code{lmodel2}, which
  contains the following elements: 
  \item{ y }{ The response variable.  }
  \item{ x }{ The explanatory variable. }
  \item{ regression.results }{ A table with rows corresponding to the
  four regression methods. Column 1 gives the method name, followed by
  the intercept and slope estimates, the angle between the regression
  line and the abscissa, and the permutational probability
  (one-tailed, for the tail corresponding to the sign of the slope
  estimate). } 
  \item{ confidence.intervals }{ A table with rows corresponding to
  the four regression methods. The method name is followed by the
  parametric 95% confidence intervals (2.5 and 97.5 percentiles) for
  the intercept and slope estimates. } 
 \item{ eigenvalues  }{ Eigenvalues of the bivariate dispersion,
  computed during major axis regression. } 
  \item{ H }{ The H statistic used for computing the confidence
  interval of the major axis slope. Notation following Sokal and Rohlf
  (1995). } 
  \item{ n }{ Number of objects. }
  \item{ r }{ Correlation coefficient. }
  \item{ rsquare }{ Coefficient of determination (R-square) of the OLS regression. }
  \item{ P.param }{ 2-tailed parametric P-value for the test of r and the OLS slope. }
  \item{ theta }{ Angle between the two OLS regression lines,
  \code{lm(y ~ x)} and \code{lm(x ~ y)}.  }
  \item{ nperm }{ Number of permutations for the permutation tests. }
  \item{ epsilon }{ Any value smaller than epsilon is considered to be zero. }
  \item{ info.slope }{ Information about the slope notation when \eqn{r = 0}. }
  \item{ info.CI }{ Information about the confidence limits notation
  when the slope is infinite. } 
  \item{ call }{ Call of the function. }
} 

\references{ 
Legendre, P. and L. Legendre. 1998. Numerical ecology, 2nd English
edition. Elsevier Science BV, Amsterdam. 

Sokal, R. R. and F. J. Rohlf. 1995. Biometry -- The principles and
practice of statistics in biological research. 3rd
edition. W. H. Freeman, New York. 
}

\seealso{ 
A tutorial (file \dQuote{Model II User's guide, R edition}) is provided
with this function, and can be read within \R session using command
\code{vignette("mod2user", package="lmodel2")}. 
}

\author{ Pierre Legendre, Departement de Sciences Biologiques, Universite de Montreal }

\examples{
## The example data files are described in more detail in the
## \dQuote{Model II User's guide, R edition} tutorial. 

## Example 1 (surgical unit data)
data(mod2ex1)
Ex1.res <- lmodel2(Predicted_by_model ~ Survival, data=mod2ex1, nperm=99)
Ex1.res
plot(Ex1.res) 

## Example 2 (eagle rays and Macomona)
data(mod2ex2)
Ex2.res <- lmodel2(Prey ~ Predators, data=mod2ex2, "relative", "relative", 99)
Ex2.res
op <- par(mfrow = c(1,2))
plot(Ex2.res, "SMA")
plot(Ex2.res, "RMA")
par(op)

## Example 3 (cabezon spawning)
op <- par(mfrow = c(1,2))
data(mod2ex3)
Ex3.res <- lmodel2(No_eggs ~ Mass, data=mod2ex3, "relative", "relative", 99)
Ex3.res
plot(Ex3.res, "SMA")
plot(Ex3.res, "RMA")
par(op)

## Example 4 (highly correlated random variables)
op <- par(mfrow=c(1,2))
data(mod2ex4)
Ex4.res <- lmodel2(y ~ x, data=mod2ex4, "interval", "interval", 99)
Ex4.res
plot(Ex4.res, "OLS")
plot(Ex4.res, "MA")
par(op)

# Example 5 (uncorrelated random variables)
data(mod2ex5)
Ex5.res <- lmodel2(random_y ~ random_x, data=mod2ex5, "interval", "interval", 99)
Ex5.res
op <- par(mfrow = c(2,2))
plot(Ex5.res, "OLS")
plot(Ex5.res, "MA")
plot(Ex5.res, "SMA")
plot(Ex5.res, "RMA")
par(op)

## Example 6 where cor(y,x) = 0 by construct (square grid of points)

y0 = rep(c(1,2,3,4,5),5)
x0 = c(rep(1,5),rep(2,5),rep(3,5),rep(4,5),rep(5,5))
plot(x0, y0)
Ex6 = as.data.frame(cbind(x0,y0))
zero.res = lmodel2(y0 ~ x0, data=Ex6, "relative", "relative")
print(zero.res)
op <- par(mfrow = c(1,2))
plot(zero.res, "OLS")
plot(zero.res, "MA")
par(op)
}

\keyword{ models}
\keyword{regression}
