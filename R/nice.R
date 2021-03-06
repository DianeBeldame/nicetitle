dd <- function(x) {
  if (nchar(x) <= 56) {
    base <- (60 - nchar(x) - 2)/2
    return(paste(c("#", rep(" ", floor(base)), x, rep(" ",
      ceiling(base)), "#"), collapse = ""))
  }
  s1 <- strsplit(x, " ")[[1]]
  c(dd(paste(s1[1:floor(length(s1)/2)], collapse = " ")), dd(paste(s1[ceiling(length(s1)/2):length(s1)],
    collapse = " ")))
}


toutbeau <- function(x, l = 60) {
  # print(x)
  x <- gsub("\n", " ", x)
  x <- gsub("\t", " ", x)
  x <- gsub("^[# ]+", "", x)
  x <- gsub("[# =]+$", " ", x)
  x <- gsub(" $", " ", x)
  res <- paste(rep("#", l), collapse = "")
  res <- c(res, paste(c("#", rep(" ", l - 2), "#"), collapse = ""))


  res <- c(res, do.call(c, as.list(dd(x))))




  res <- c(res, paste(c("#", rep(" ", l - 2), "#"), collapse = ""))
  res <- c(res, paste(rep("#", l), collapse = ""))
  res <- c(res, "")
  res
  res <- paste(res, collapse = "\n")
  return(res)
}


nicetitle <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  for (sel in context$selection) {
    # print(sel)
    if (sel$text != "") {


      rstudioapi::modifyRange(sel$range, toutbeau(sel$text),
        context$id)
      break
    } else {

      lign <- context$selection[[1]]$range$start[["row"]]
      value <- context$contents[lign]
      range <- structure(list(start = structure(c(lign,
        1), .Names = c("row", "column"), class = "document_position"),
        end = structure(c(lign, 77777), .Names = c("row",
          "column"), class = "document_position")), .Names = c("start",
        "end"), class = "document_range")

      if (value != "") {
        rstudioapi::modifyRange(range, toutbeau(value),
          context$id)
      }
    }
  }
}
