dplyr_2 <- function(Posts) {
  # Z Posts
  # rozwazam tylko te wiersze, w ktorych PostTypeId = 1 lub 2
  # dodaje kolumny Year i Month
  # po ktorych grupuje
  # i zliczam liczbe rekordow oraz maksimum ze Score
  # wybieram tylko te wiersze, gdzie liczba rekordow > 1000
  Posts %>%
    filter(PostTypeId %in% c(1, 2)) %>%
    mutate(Year=sprintf("%04d", year(CreationDate)), Month=sprintf("%02d", month(CreationDate))) %>%
    group_by(Year, Month) %>%
    summarise(PostsNumber=n(), MaxScore=max(Score), .groups="drop") %>%
    filter(PostsNumber > 1000)
}
