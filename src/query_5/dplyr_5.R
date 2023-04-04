dplyr_5 <- function(Posts, Comments, Users) {
  CmtTotScr <- Comments %>%
    group_by(PostId) %>%
    summarise(CommentsTotalScore=sum(Score))
  
  PostsBestComments <- inner_join(
    Posts,
    CmtTotScr,
    by=join_by(Id==PostId)
  ) %>%
    filter(PostTypeId==1) %>%
    select(OwnerUserId, Title, CommentCount, ViewCount, CommentsTotalScore)
  
  inner_join(
    Users,
    PostsBestComments,
    by=join_by(Id==OwnerUserId),
    multiple="all"
  ) %>%
    select(Title, CommentCount, ViewCount, CommentsTotalScore, DisplayName, Reputation, Location) %>%
    arrange(desc(CommentsTotalScore)) %>%
    slice_head(n=10)
}
