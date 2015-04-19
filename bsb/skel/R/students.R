# BSB: blackboard-scantron-bridge

# evaluate the scantron input
evaluate(scantrons, blackboard)

# correct student ID entry errors
# scantrons = fix_id(scantrons, old_id = 999000000, new_id = 999000001)

# manually add any students who completed makeup exams or whatever
#manual = rbind(
#  data.frame(ID=999000002, Last.Name="Schmo", First.Name="Joe", Total.Score=49),
#)
#scantrons = merge(scantrons, manual, all=T)
