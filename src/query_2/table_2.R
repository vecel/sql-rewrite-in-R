table_2 <- function(Posts) {
  # Z Posts
  # Rozwazam wiersze, w ktorych PostTypeId = 1 lub 2, wyznaczam Year, Month. W grupach Year, Month zliczam liczbe rekordow (PostsNumber) i maksimum z Score
  # Wybieram te wiersze, w ktorych PostsNumber > 1000
  Posts[PostTypeId %in% c(1, 2), 
        .(Year=sprintf("%04d", year(CreationDate)), Month=sprintf("%02d", month(CreationDate)), Score)][
          , .(PostsNumber=.N, MaxScore=max(Score)), by=.(Year, Month)
        ][PostsNumber > 1000]
}
