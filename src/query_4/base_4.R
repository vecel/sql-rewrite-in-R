base_4 <- function(Posts, Users) {
  Answers <- Posts[ Posts$PostTypeId == 2, ]
  Answers <- aggregate(
    Answers$OwnerUserId,
    by=list(Answers$OwnerUserId),
    length
  )
  Answers <- Answers[, c(2,1)]
  colnames(Answers) <- c("AnswersNumber", "OwnerUserId")
  
  # Uwaga: base pomija NA, sqldf zlicza je jako jedna grupe
  
  Questions <- Posts[ Posts$PostTypeId == 1, ]
  Questions <- aggregate(
    Questions$OwnerUserId,
    by=list(Questions$OwnerUserId),
    length
  )
  Questions <- Questions[, c(2,1)]
  colnames(Questions) <- c("QuestionsNumber", "OwnerUserId")
  
  PostsCount <- merge(
    Answers,
    Questions,
    by="OwnerUserId"
  )
  PostsCount <- PostsCount[ PostsCount$AnswersNumber > PostsCount$QuestionsNumber, ]
  PostsCount <- PostsCount[ order(PostsCount$AnswersNumber, decreasing = TRUE), ]
  PostsCount <- PostsCount[1:5, ]
  
  df <- merge(
    Users,
    PostsCount,
    by.x="Id",
    by.y="OwnerUserId"
  )
  df <- df[ , c("DisplayName", "QuestionsNumber", "AnswersNumber", "Location", "Reputation", "UpVotes", "DownVotes")]
  return(df)
}
