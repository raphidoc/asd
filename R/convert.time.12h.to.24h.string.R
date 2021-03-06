# Script to convert the time in UTC in 24h format file
#
# Writen by Simon Bélanger

convert.time.12h.to.24h.string <- function(DateTime, format.date,  UTClag) {
  TimeLocal = as.POSIXct(strptime(DateTime, format = format.date))
  dates.secs.from.beginning <- as.numeric(TimeLocal) - min(as.numeric(TimeLocal))

  n = length(TimeLocal)
  x = unlist(strsplit(DateTime," "))

  # Get indices where PM after noontime and add 12:00:00
  AMPM = matrix(x,nrow=n, byrow = T)[,3]
  HH = format(TimeLocal, "%H")
  ix = which(HH != '12' & AMPM == 'PM')
  Time24= TimeLocal
  Time24[ix] = as.POSIXct(as.numeric(TimeLocal[ix]) + 12*3600, origin="1970-01-01")

  # ADD the number of HOURs to UTC

  TimeUTC = as.POSIXct(as.numeric(Time24) + UTClag*3600, origin="1970-01-01")

  # update the COPS data matrix and write as TSV file
  DateTime = format(TimeUTC, format.date)

  return(DateTime)
}
