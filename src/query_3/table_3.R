table_3 <- function(Posts, Users) {
  # Tworze ramke Questions (patrz funkcja table_1)
  Questions <- Posts[PostTypeId==1, .(TotalViews = sum( ViewCount )), by=OwnerUserId]
  
  # Lacze ramki Users i Questions po kolumnach Id i OwnerUserId
  # sortuje nierosnaco po TotalViews i wybieram kolumny Id, DisplayName, TotalViews
  # wybieram 10 pierwszych rekordow
  merge(Users, Questions, by.x="Id", by.y="OwnerUserId")[
    order(TotalViews, decreasing=TRUE), .(Id, DisplayName, TotalViews)
  ][1:10]
}
