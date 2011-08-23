\name{eiginv}
\alias{eiginv}
\title{
Generate a (dense) matrix that has the given set of eigenvalues. 
}
\description{
Solves the ``inverse eigenvalue problem'' which is to generate a real-valued matrix that has the specified real eigenvalue spectrum.  It uses the Soules' matrix.
}
\usage{
eiginv(evals, n, x, y, symmetric=FALSE, stochastic=FALSE)
}
\arguments{
\item{evals}{A vector of eigenvalues.  Must be real valued.}
\item{n}{Dimension of the matrix to be generated. If \code{n} is missing, it is taken to be the length of the \code{evals}}
\item{x}{A real vector to be used for generating the intermediate Soules matrix.  If missing, a randomly generated vector is used 
}
\item{y}{A real vector to be used for generating the intermediate Soules matrix.  If missing, a randomly generated vector is used.
This vector is needed only for generating a non-symmetric matrix}
\item{symmetric}{A logical variable indicating whether to generate a symmetric matrix (TRUE) or not (FALSE).  Default is FALSE}
\item{stochastic}{A logical variable indicating whether to generate a stochastic matrix (TRUE) or not (FALSE).  Default is FALSE}
}

\details{ The algorithm of Chen et al. (2006) is used to generate symmetric and non-symmetric Soules matrices.  A random seed vector(s) is(are) used, if none is specified by the user.  It is, however, not necessary to specify the seed vector(s). To replicate the same matrix, for a given set of eigenvalues, the user should initialize the random seed (see example below). The algorithm is quite efficient, and it can generate large matrices quite quickly.  Algorithm can also generate stochastic and doubly stochastic matrices, which have the property that their elements are probability measures and that the row sums and colum sums (for doubly stochastic) are equal to 1.   These matrices are useful for studying Markov chains.  Since the eigenvalues of stochastic matrices are in [0, 1], only such values must be specified for \code{evals}, otherwise the elements of the generated matrix will not necessarily be probabilities. 

This algorithm can generate infinitely many, dense matrices all of which have the given set of real eigenvalues.
}

\value{
A matrix of dimension equal to either \code{n} or \code{length(evals)}.  This matrix has the property that its eigenvalues are the same as \code{evals}.  When \code{n} is specified and is larger than \code{length(evals)}, the generated matrix has a subset of eigenvalues that coincide with \code{evals}.
}
\references{
MQ Chen, L Han, and M Neumann, On single and double Soules matrices, \emph{Linear Algebra Appl}, 416, p.88-110, 2006

MT Chu and GH Golub, Inverse Eigenvalue Problems, Oxford University Press, 2005
}

\author{
Ravi Varadhan <rvaradhan@jhmi.edu>, Johns Hopkins University
URL:http://www.jhsph.edu/agingandhealth/People/Faculty_personal_pages/Varadhan.html
}

\examples{
n <- 100
evals <- sort(rnorm(n)) 
system.time(A <- eiginv(evals))
all.equal(evals, sort(eigen(A)$val))

ev <- -seq(1:6)
set.seed(123)
B <- eiginv(ev)
eigen(B)$val
B2 <- eiginv(ev) # B and B2 will be different
all.equal(B, B2)

set.seed(123)
B3 <- eiginv(ev)
all.equal(B, B3) # will be identical

# Generate a stochastic matrix
n <- 9
evals <- c(1, 0.95, rev(sort(runif(n-2, 0, 0.9))))
B4 <- eiginv(evals, stoch=TRUE)
eigen(B4)$value
rowSums(B4)

# Generate a doubly stochastic matrix
B5 <- eiginv(evals, symm=TRUE, stoch=TRUE)
eigen(B5)$value
rowSums(B5)
colSums(B5)
}
