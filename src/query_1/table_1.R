table_1 <- function(Users) {
  # Z Users
  # wybieram wiersze, gdzie Location nie jest puste, wyliczam sume UpVotes grupujac po Location
  # wynik sortuje niemalejaco po -TotalUpVotes (czyli nierosnaco po TotalUpVotes)
  # i wybieram 10 pierwszych wierszy poprzedniego wyniku
  Users[ 
    Location != "", .(TotalUpVotes = sum( UpVotes )), by=Location
  ][order(-TotalUpVotes)
  ][1:10]
}
