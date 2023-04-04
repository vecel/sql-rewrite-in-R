table_5 <- function(Posts, Comments, Users) {
  CmtTotScr <- Comments[, .(CommentsTotalScore=sum(Score)), by=PostId]
  PostsBestComments <- merge(
    Posts,
    CmtTotScr,
    by.x="Id",
    by.y="PostId"
  )[PostTypeId==1, .(OwnerUserId, Title, CommentCount, ViewCount, CommentsTotalScore)]
  
  merge(
    Users,
    PostsBestComments,
    by.x="Id",
    by.y="OwnerUserId"
  )[ order(CommentsTotalScore, decreasing=TRUE), .(Title, CommentCount, ViewCount, CommentsTotalScore, DisplayName, Reputation, Location)][1:10]
}
