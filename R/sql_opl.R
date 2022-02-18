
#' Utility function to pin the csv of the latest OpenPowerLifting data
#' with the Pins 1.0.0 API.
#'

#' @param ipf LOGICAL, IPF-affiliated competitons only, default TRUE.
#' @param location optional string for the location to store the SQLite DB.
#' @param name optional STRING for the name for the table. Defaults to "opl-ipf" or "opl-all"
#'
#' @return name of the table, invisibly
#'
sql_opl =   function(ipf = TRUE,
                     name = NULL,
                     location = "~/.local/share/opl"){
  #Assertions
  assertthat::is.flag(ipf)

  #handle pin name, with defaults if not supplied
  name = ifelse(is.null(name), ifelse(ipf, "opl-ipf", "opl-all"))

  #Make directory
  if (!dir.exists(location)) dir.create(location, recursive = T)

  url =
    c(open_ipf =
        "https://openpowerlifting.gitlab.io/opl-csv/files/openipf-latest.zip",
      opl =
        "https://openpowerlifting.gitlab.io/opl-csv/files/openpowerlifting-latest.zip")
  url = dplyr::if_else(ipf, url[1], url[2])

  # Unzip to tmpdir

  tmp_dir = file.path(tempdir(), as.integer(Sys.time()))
  dir.create(tmp_dir)

  utils::download.file(url, file.path(tmp_dir,"opl.zip"), mode = "wb")
  utils::unzip(file.path(tmp_dir,"opl.zip"),
               exdir = tmp_dir)
  data_path = list.files(tmp_dir, pattern = "csv$", recursive = T)

  assertthat::assert_that(length(data_path) == 1)

  data_path = file.path(tmp_dir, data_path)

  # Start working with DB

  con = DBI::dbConnect(RSQLite::SQLite(), file.path(location, name))

  #Easier to drop table than to filter dupes
  if(DBI::dbExistsTable(con, "opl")) DBI::dbRemoveTable(con, "opl")

  db_callback = function(data, index){
    data = janitor::clean_names(data)
    DBI::dbWriteTable(con, "opl", data, append = TRUE)

  }
  #read csv by chunks
  readr::read_csv_chunked(data_path,
                          readr::SideEffectChunkCallback$new(db_callback),
                          progress = FALSE)

  ## Cleanup
  con = DBI::dbDisconnect(con)

  files = list.files(tmp_dir, recursive = TRUE)
  file.remove(file.path(tmp_dir, files))
  invisible(name)
}
