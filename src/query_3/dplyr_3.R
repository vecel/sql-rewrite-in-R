dplyr_3 <- function(Posts, Users) {
  # Tworze ramke Questions
  # Z Posts
  # wybieram wiersze z PostTypeId = 1
  # grupuje po OwnerUserId
  # rozwazam dwie kolumny: OwnerUserId oraz ViewCount
  # zliczam sume ViewCount w kazdej grupie
  Questions <- Posts %>% 
    filter(PostTypeId == 1) %>%
    group_by(OwnerUserId) %>%
    select(OwnerUserId, ViewCount) %>%
    summarise(TotalViews = sum(ViewCount))
  
  # Lacze ramki Users i Questions po wartosci Id i OwnerUserId
  # wybieram interesujace mnie kolumny
  # sortuje nierosnaco po TotalViews
  # wybieram 10 pierwszych rekordow
  inner_join(
    Users,
    Questions,
    by=join_by(Id == OwnerUserId)
  ) %>%
    select(Id, DisplayName, TotalViews) %>%
    arrange(desc(TotalViews)) %>%
    slice_head(n=10)
}
