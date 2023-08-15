# Script pour installer / mettre à jour les packages utilisés

if (!requireNamespace("remotes")) install.packages("remotes")
remotes::install_cran("renv")
remotes::install_cran("purrr")

renv::dependencies() |>
  purrr::pluck("Package") |>
  unique() |> 
  remotes::install_cran()
