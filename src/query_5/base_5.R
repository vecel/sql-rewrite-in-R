base_5 <- function(Posts, Comments, Users) {
  CmtTotScr <- aggregate(
    Comments$Score,
    by=list(Comments$PostId),
    sum
  )
  colnames(CmtTotScr) <- c("PostId", "CommentsTotalScore")
  
  PostsBestComments <- merge(
    Posts,
    CmtTotScr,
    by.x="Id",
    by.y="PostId"
  )
  
  PostsBestComments <- PostsBestComments[ 
    PostsBestComments$PostTypeId==1,
    c("OwnerUserId", "Title", "CommentCount", "ViewCount", "CommentsTotalScore")]
  
  df <- merge(
    Users,
    PostsBestComments,
    by.x="Id",
    by.y="OwnerUserId"
  )
  df <- df[, c("Title", "CommentCount", "ViewCount", "CommentsTotalScore", "DisplayName", "Reputation", "Location")]
  df <- df[ order(df$CommentsTotalScore, decreasing=TRUE), ]
  df <- df[1:10,]
  return(df)
}
