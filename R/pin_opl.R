
#' Utility function to pin the csv of the latest OpenPowerLifting data
#' with the Pins 1.0.0 API.
#'
#' @param board the Board object from {pins} to attach the data to
#' @param ipf LOGICAL, IPF-affiliated competitons only, default TRUE.
#' @param name optional STRING for the name for the pin. Defaults to "opl-ipf" or "opl-all"
#'
#' @return Same as pin_write
#' @export
#'
pin_opl =   function(board, ipf = TRUE, name = NULL){

  #handle pin name, with defaults if not supplied
  name = ifelse(is.null(name), ifelse(ipf, "opl-ipf", "opl-all"))

  opl =
    pins::board_url(
      c(open_ipf =
          "https://openpowerlifting.gitlab.io/opl-csv/files/openipf-latest.zip",
        opl =
          "https://openpowerlifting.gitlab.io/opl-csv/files/openpowerlifting-latest.zip"))


  zip_path = ifelse(ipf, #Cache the zip from the website.
    pins::pin_download(opl, "open_ipf"),
    pins::pin_download(opl, "open_ipf"))



  oldwd = getwd() #Move to tempdir to work with the zip files
  setwd(tempdir())
  unzip(zip_path)

  opl = list.files(pattern = "csv$", recursive = T) %>%
    readr::read_csv(col_types = "cfcfnfffnnnnnnnnnnnnnnnncnnnnf") #more-or-less the colspec we want...

  setwd(oldwd) #return to actual working directory.

  pins::pin_write(board, opl, name = name,
                  description = "OpenPowerLifting Data automatically pinned by the openpoweRlifting package")
}
