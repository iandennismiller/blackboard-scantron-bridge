# BSB: blackboard-scantron-bridge

library(gdata, quietly=T, warn.conflicts=F, verbose=F)
library(data.table, quietly=T, warn.conflicts=F, verbose=F)

clean_env = function() {
  items = ls(envir=.GlobalEnv)
  filter = 'clean_env|make'
  filtered = items[grep(filter, items, invert=TRUE)]
  rm(list=filtered, envir=.GlobalEnv)
}

find_student = function(student_id, blackboard) {
  found = blackboard[toupper(blackboard[["Last.Name"]])==last_name,]
  return(found)
}

# which students are still listed in Blackboard but have no scantrons?
missing_exams = function(scantrons, blackboard) {
  entered_ids = blackboard[["Student.ID"]]
  not_found = entered_ids[!is.element(entered_ids, scantrons[["ID"]])]
  results = data.frame()
  if (length(not_found)>0) {
    for (student_id in not_found) {
      results = rbind(results, blackboard[blackboard$Student.ID==student_id,])
    }
  }
  print(results[c("Last.Name", "First.Name", "Student.ID")])
}

find_entry_errors = function(scantrons, blackboard) {
  cat("figure out who entered a student ID that is not in the spreadsheet from blackboard\n")  
  entered_ids = scantrons[["ID"]]
  not_found = entered_ids[!is.element(entered_ids, blackboard[["Student.ID"]])]
  if (length(not_found)>0) {
    for (student_id in not_found) {
      first_name = as.character(scantrons[scantrons[["ID"]]==student_id,"First.Name"])
      last_name = as.character(scantrons[scantrons[["ID"]]==student_id,"Last.Name"])
      cat("scantron name:", last_name, ",", first_name, "\n")
      cat("scantron ID:", student_id, "\n")

      results = find_student(student_id, blackboard)
      cat("students in Blackboard with same last name:", "\n")
      print(results[c("Last.Name", "First.Name", "Student.ID")])
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
              file="data/blackboard/temp-utf8.csv",
              sep="\t",
              quote=TRUE,
              na="",
              row.names=F,
              col.names=c(blackboard_colnames, unique_colnames),
              fileEncoding = "UTF-8")

  cat('\xFF\xFE', file = (con <- file("data/blackboard/upload.csv", "w"))); close(con)
  system("iconv -f UTF-8 -t UTF-16LE data/blackboard/temp-utf8.csv >> data/blackboard/upload.csv && rm data/blackboard/temp-utf8.csv")
}

dimensions = function(blackboard, scantrons) {
  print("Scantrons")
  print(dim(scantrons))
  print(head(scantrons, n=1))

  print("Blackboard")
  system('head -n1 data/blackboard/download.xls | tail -c +3 | cut -f7- | tr "\t" "," | sed -e "s/,/,@/g" | tr @ "\n" ')

  # determine the column that needs to be replaced on blackboard
  print(names(blackboard))
}

# merge the scantron results, replace the proper column, and export

finalize = function(scantrons, blackboard, column_to_replace, to_export, unique_colnames) {
  to_export = merge_exam(scantrons, blackboard, column_to_replace)
  export_exam(to_export, unique_colnames)
}

