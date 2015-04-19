# BSB: blackboard-scantron-bridge

# import blackboard grade center "offline work" spreadsheet
blackboard = read.delim("data/blackboard/download.xls", fileEncoding = "UTF-16")

# import the scantron results
version_a = read.csv("data/scantron/scantron-version-a.csv")
version_b = read.csv("data/scantron/scantron-version-b.csv")
version_c = read.csv("data/scantron/scantron-version-c.csv")

# combine the scantron versions
scantrons = rbind(version_a, version_b, version_c)
