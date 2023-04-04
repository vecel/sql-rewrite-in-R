base_2 <- function(Posts) {
  # Dodaje kolumny Year i Month
  df <- cbind(Posts, Year = sprintf("%04d", year(Posts$CreationDate)), Month = sprintf("%02d", month(Posts$CreationDate)))
  
  # Usuwam wiersze, w ktorych PostTypeId jest rozne od 1 i 2
  df <- df[ df$PostTypeId %in% c(1, 2), ]
  
  # Grupuje po Year i Month, zliczam liczbe rekordow i max ze Score w kazdej grupie
  df <- aggregate(
    cbind(df$Score),
    by=list(df$Year, df$Month),
    FUN = function(x) c(length(x), max(x))
  )
  
  # Wynikiem powyzszego aggregate jest ramka danych, w ktorej podsumowane wyniki
  # sa macierzami a nie kolumnami. Tutaj "wyplaszczam" wynik do zwyklej ramki damych
  df <- do.call(data.frame, df)
  
  # Naprawiam nazwy kolumn
  colnames(df) <- c("Year", "Month", "PostsNumber", "MaxScore")
  
  # Usuwam wiersze, w ktorych PostsNumber jest <= 1000
  df <- df[ df$PostsNumber > 1000, ]
  
  # dla estetyki sortuje i naprawiam numeracje wierszy
  df <- df[ order(df$Year, df$Month), ]
  rownames(df) <- NULL
  df
}
