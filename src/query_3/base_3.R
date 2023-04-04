base_3 <- function(Posts, Users) {
  # Tworze ramke Questions do zlaczenia z Users
  # Wybieram z Posts rekordy, ktorych wartosc PostTypeId = 1 (biore tylko wartosci kolumn OwnerUserId, ViewCount)
  Questions <- Posts[ Posts$PostTypeId==1, c("OwnerUserId", "ViewCount")]
  
  # Grupuje po OwnerUserId i zliczam sume ViewCount w kazdej grupie 
  Questions <- aggregate(
    Questions$ViewCount,
    by=list(Questions$OwnerUserId),
    sum
  )
  
  # Naprawiam nazwy kolumn
  colnames(Questions) <- c("OwnerUserId", "TotalViews")
  
  # Lacze ramki Users i Questions po wartosci Id
  # Lacze te i tylko te wiersze, ktore maja Users.Id = Questions.OwnerUserId, wiersze bez pary nie sa brane pod uwage
  df <- merge(
    Users,
    Questions,
    by.x="Id",
    by.y="OwnerUserId"
  )
  
  # Wybieram interesujace mnie kolumny
  df <- df[ , c("Id", "DisplayName", "TotalViews")]
  
  # Sortuje nierosnaco po TotalViews
  df <- df[ order(df$TotalViews, decreasing = TRUE), ]
  
  # Dla estetyki
  rownames(df) <- NULL
  
  # Wybieram pierwsze 10 rekordow
  df <- df[1:10,]
  return(df)
}
