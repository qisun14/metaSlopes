devtools::document()
devtools::install()
library(metaSlopes)
cov_matrices <- list(
  matrix(c(.143, .066, .062, .066, .094, .071, .062, .071, .082),
         nrow = 3, byrow = TRUE,
         dimnames = list(c("t1", "t2", "t3"), c("t1", "t2", "t3"))),
  matrix(c(.150, .070, .065, .070, .100, .075, .065, .075, .090),
         nrow = 3, byrow = TRUE,
         dimnames = list(c("t1", "t2", "t3"), c("t1", "t2", "t3"))),
  matrix(c(.135, .060, .058, .060, .090, .065, .058, .065, .080),
         nrow = 3, byrow = TRUE,
         dimnames = list(c("t1", "t2", "t3"), c("t1", "t2", "t3")))
)

# Mean vectors (3 studies)
mean_vectors <- list(
  c(1.1696, 1.1131, 1.1012),
  c(1.2000, 1.1500, 1.1300),
  c(1.1800, 1.1300, 1.1200)
)

# Sample sizes (3 studies)
sample_sizes <- c(84, 90, 95)
res <- meta_slope_analysis(cov_matrices, mean_vectors, sample_sizes)
print(res)
