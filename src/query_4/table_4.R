table_4 <- function(Posts, Users) {
  Answers <- Posts[
    PostTypeId==2, 
    .(AnswersNumber = .N),
    by=OwnerUserId]
  
  Questions <- Posts[
    PostTypeId==1,
    .(QuestionsNumber = .N),
    by=OwnerUserId]
  
  PostsCount <- merge(
    Answers,
    Questions,
    by="OwnerUserId"
  )[!is.na(OwnerUserId) & AnswersNumber > QuestionsNumber][
    order(AnswersNumber, decreasing = TRUE)
  ][1:5]
  
  merge(
    Users,
    PostsCount,
    by.x="Id",
    by.y="OwnerUserId"
  )[, c("DisplayName", "QuestionsNumber", "AnswersNumber", "Location", "Reputation", "UpVotes", "DownVotes")]
  
}
