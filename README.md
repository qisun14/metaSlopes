
# metaSlopes <img src="https://img.shields.io/badge/status-active-brightgreen" alt="status" align="right"/>

`metaSlopes` is an R package that performs meta-analysis of standardized
slopes (Cohen’s *d*) using longitudinal summary data: covariance
matrices, mean vectors, and sample sizes.

## 📥 Installation

``` r
install.packages("devtools")
devtools::install_github("qisun14/metaSlopes")
library(metaSlopes)
```

## 🚀 Usage Example

``` r
cov_matrices <- list(
  matrix(c(.143, .066, .062, .066, .094, .071, .062, .071, .082), nrow = 3, byrow = TRUE),
  matrix(c(.150, .070, .065, .070, .100, .075, .065, .075, .090), nrow = 3, byrow = TRUE),
  matrix(c(.135, .060, .058, .060, .090, .065, .058, .065, .080), nrow = 3, byrow = TRUE)
)

mean_vectors <- list(
  c(1.1696, 1.1131, 1.1012),
  c(1.2000, 1.1500, 1.1300),
  c(1.1800, 1.1300, 1.1200)
)

sample_sizes <- c(84, 90, 95)

result <- meta_slope_analysis(cov_matrices, mean_vectors, sample_sizes)
print(result)
```

## 📘 Function

- `meta_slope_analysis()` Takes in a list of covariance matrices, mean
  vectors, and sample sizes. Returns a meta-analytic estimate of the
  standardized slope (Cohen’s *d*), 95% confidence interval, and
  p-value.

## 🙋 Author

Qi Sun Ph.D. Educational Psychology and Methodology University at
Albany, SUNY [https://github.com/qisun14](https://github.com/qisun88)

## 📄 License

MIT © Qi Sun
