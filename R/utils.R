is_testing <- function () {
  identical(Sys.getenv("TESTTHAT"), "true")
}


# CLI ---------------------------------------------------------------------

box_chars <- function() {
  fancy <- getOption("lobstr.fancy.tree") %||% l10n_info()$`UTF-8`
  orange <- crayon::make_style("orange")

  if (fancy) {
    list(
      "h" = "\u2500",          # ─ horizontal
      "v" = "\u2502",          # │ vertical
      "l" = "\u2514",          # └ leaf
      "j" = "\u251C",          # ├ junction
      "n" = orange("\u2588")   # █ node
    )
  } else {
    list(
      "h" = "-",
      "v" = "|",
      "l" = "\\",
      "j" = "+",
      "n" = orange("o")
    )
  }
}

grey <- function(...) {
  crayon::make_style(grDevices::grey(0.5), grey = TRUE)(...)
}

# string -----------------------------------------------------------------

str_dup <- function(x, n) {
  vapply(n, function(i) paste0(rep(x, i), collapse = ""), character(1))
}

str_indent <- function(x, first, rest) {
  if (length(x) == 0) {
    character()
  } else if (length(x) == 1) {
    paste0(first, x)
  } else {
    c(
      paste0(first, x[[1]]),
      paste0(rest, x[-1L])
    )
  }
}

str_truncate <- function(x, n) {
  too_long <- nchar(x, type = "width") > n
  x[too_long] <- paste0(substr(x[too_long], 1, n - 3), "...")
  x
}

new_raw <- function(x) {
  structure(x, class = "lobstr_raw")
}

#' @export
print.lobstr_raw <- function(x, ...) {
  cat(paste(x, "\n", collapse = ""), sep = "")
  invisible(x)
}

