# BSB: blackboard-scantron-bridge

library(gdata)
library(data.table)

clean_env = function() {
  items = ls(envir=.GlobalEnv)
  filter = 'clean_env|make'
  filtered = items[grep(filter, items, invert=TRUE)]
  rm(list=filtered, envir=.GlobalEnv)
}

find_student = function(student_id, scantrons, blackboard) {
  first_name = as.character(scantrons[scantrons[["ID"]]==student_id,"First.Name"])
  last_name = as.character(scantrons[scantrons[["ID"]]==student_id,"Last.Name"])
  found = blackboard[toupper(blackboard[["Last.Name"]])==last_name,]
  return(c(last_name, first_name, found[["Student.ID"]]))
}

find_entry_errors = function(scantrons, blackboard) {
  entered_ids = scantrons[["ID"]]
  not_found = entered_ids[!is.element(entered_ids, blackboard[["Student.ID"]])]
  if (!is.na(not_found)) {
    for (student_id in not_found) {
      cat("official data:", find_student(student_id, scantrons, blackboard), "\n")
      cat("incorrect entry:", student_id, "\n")
    }
  }
}

fix_id = function(scantrons, old_id, new_id) {
  scantrons[scantrons[["ID"]]==old_id,"ID"] = new_id
  return(scantrons)
}

merge_exam = function(scantrons, blackboard, column_to_replace) {
  id_and_score = subset(scantrons, select=c(ID, Total.Score))
  setnames(id_and_score, "ID", "Student.ID")

  merged <- merge(blackboard, id_and_score, by="Student.ID", all.x=T)
  merged = with(merged, {
    merged[order(Last.Name, First.Name),]
  })

  blackboard[column_to_replace] = merged[dim(merged)[2]]
  return(blackboard)
}

export_exam = function(to_export, unique_colnames) {
  blackboard_colnames = c(
    "Last Name",
    "First Name",
    "Username",
    "Student ID",
    "Last Access",
    "Availability"
  )

  write.table(to_export,
              file="blackboard/temp-utf8.csv",
              sep="\t",
              quote=TRUE,
              na="",
              row.names=F,
              col.names=c(blackboard_colnames, unique_colnames),
              fileEncoding = "UTF-8")

  cat('\xFF\xFE', file = (con <- file("blackboard/upload.csv", "w"))); close(con)
  system("iconv -f UTF-8 -t UTF-16LE blackboard/temp-utf8.csv >> blackboard/upload.csv && rm blackboard/temp-utf8.csv")
}

evaluate = function(scantrons, blackboard) {
  cat("figure out who entered a student ID that is not in the spreadsheet from blackboard\n")
  # these students need to have their IDs manually changed.
  find_entry_errors(scantrons, blackboard)

  # determine the column that needs to be replaced on blackboard
  print(names(blackboard))
}

dimensions = function() {
  print("Scantrons")
  print(dim(scantrons))
  print(head(scantrons))

  print("Blackboard")
  print(head(blackboard))
}

# merge the scantron results, replace the proper column, and export

finalize = function(scantrons, blackboard, column_to_replace, to_export, unique_colnames) {
  to_export = merge_exam(scantrons, blackboard, column_to_replace)
  export_exam(to_export, unique_colnames)
}
