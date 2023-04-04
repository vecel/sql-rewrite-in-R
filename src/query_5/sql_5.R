sql_5 <- function(Posts, Comments, Users) {
  PostsBestComments <- sqldf("SELECT Posts.OwnerUserId, Posts.Title, Posts.CommentCount, Posts.ViewCount,
    CmtTotScr.CommentsTotalScore
    FROM (
      SELECT PostId, SUM(Score) AS CommentsTotalScore
      FROM Comments
      GROUP BY PostId
    ) AS CmtTotScr
    JOIN Posts ON Posts.Id = CmtTotScr.PostId
    WHERE Posts.PostTypeId=1")
  sqldf("SELECT Title, CommentCount, ViewCount, CommentsTotalScore, DisplayName, Reputation, Location
    FROM PostsBestComments JOIN Users ON PostsBestComments.OwnerUserId = Users.Id
    ORDER BY CommentsTotalScore DESC
    LIMIT 10")
}
