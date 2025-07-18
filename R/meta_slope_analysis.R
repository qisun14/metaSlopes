#' Meta-analysis of standardized slopes (Cohen's d) from multiple studies
#'
#' @param cov_matrices A list of covariance matrices
#' @param mean_vectors A list of mean vectors
#' @param sample_sizes A vector of sample sizes
#'
#' @return A list with meta-analytic estimate of Cohen's d, confidence interval, and p-value
#' @export
#'
#' @examples
#' # See README for a reproducible example
meta_slope_analysis <- function(cov_matrices, mean_vectors, sample_sizes) {
  # Helper function to extract standardized slope from one study
  extract_standardized_slope <- function(cov.mat, mean.vec, sample.nobs) {
    time.points <- length(mean.vec)
    var.names <- paste0("t", 1:time.points)
    # Add names to covariance matrix and mean vector if missing
    dimnames(cov.mat) <- list(var.names, var.names)
    names(mean.vec) <- var.names
    int.loads <- paste0("1*", var.names, collapse = " + ")
    slp.loads <- paste0((0:(time.points - 1)), "*", var.names, collapse = " + ")

    model <- paste0(
      "int =~ ", int.loads, "\n",
      "slp =~ ", slp.loads, "\n",
      "int ~~ slp"
    )

    fit <- lavaan::growth(model,
                          sample.cov = cov.mat,
                          sample.mean = mean.vec,
                          sample.nobs = sample.nobs)

    est <- lavaan::parameterEstimates(fit)
    slope_mean <- est$est[est$lhs == "slp" & est$op == "~1"]
    slope_var  <- est$est[est$lhs == "slp" & est$op == "~~" & est$rhs == "slp"]
    slope_std  <- slope_mean / sqrt(slope_var)
    return(slope_std)
  }

  # Step 1: Extract standardized slopes for all studies
  slp_list <- sapply(seq_along(cov_matrices), function(i) {
    extract_standardized_slope(cov_matrices[[i]], mean_vectors[[i]], sample_sizes[i])
  })

  # Step 2: Convert to Fisher's z
  fisher_z <- 0.5 * log((1 + slp_list) / (1 - slp_list))

  # Step 3: Estimate variance
  vi <- 1 / (sample_sizes - 3)

  # Step 4: Meta-analysis
  meta_result <- metafor::rma(yi = fisher_z, vi = vi, method = "REML")

  # Step 5: Back-transform to d
  z_to_d <- function(z) (exp(2 * z) - 1) / (exp(2 * z) + 1)

  list(
    cohen_d   = z_to_d(as.numeric(meta_result$beta)),
    ci_lower  = z_to_d(meta_result$ci.lb),
    ci_upper  = z_to_d(meta_result$ci.ub),
    p_value   = meta_result$pval
  )
}
