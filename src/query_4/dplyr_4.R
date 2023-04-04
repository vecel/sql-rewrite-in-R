dplyr_4 <- function(Posts, Users) {
  Answers <- Posts %>%
    filter(PostTypeId == 2) %>%
    group_by(OwnerUserId) %>%
    summarise(AnswersNumber = n())
  
  Questions <- Posts %>%
    filter(PostTypeId == 1) %>%
    group_by(OwnerUserId) %>%
    summarise(QuestionsNumber = n())
  
  PostsCount <- inner_join(
    Answers,
    Questions,
    by=join_by(OwnerUserId)
  ) %>%
    filter(AnswersNumber > QuestionsNumber & !is.na(OwnerUserId)) %>%
    arrange(desc(AnswersNumber)) %>%
    slice_head(n=5)
  
  inner_join(
    Users,
    PostsCount,
    by=join_by(Id==OwnerUserId)
  ) %>%
    select(DisplayName, QuestionsNumber, AnswersNumber, Location, Reputation, UpVotes, DownVotes)
}
