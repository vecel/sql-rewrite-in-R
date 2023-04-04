# sql-rewrite-in-R



A project, in which I re-write SQL queries into R scripts. Each one with the different R library 

## Info

**Data Source:** https://archive.org/details/stackexchange   

**Technologies** : 
* R
 * dplyr
 * data.table 
 * sqldf 
 * microbenchmark


**Conclusion**   
In terms of computing speed, data.table is the fastest option.   
Then dplyr and base R functions.   
Sqldf is the slowest

**Credits**
Repo structure and README structure inspired by:  https://github.com/Iwaniukooo11/sql-queries-in-r

**Author**
Mateusz Karandys



## Query 1
```sql
SELECT 
  Location, 
  SUM(UpVotes) as TotalUpVotes 
FROM 
  Users 
WHERE 
  Location != '' 
GROUP BY 
  Location 
ORDER BY 
  TotalUpVotes DESC 
LIMIT 
  10

```

## Query 2
```sql
SELECT 
  STRFTIME('%Y', CreationDate) AS Year, 
  STRFTIME('%m', CreationDate) AS Month, 
  COUNT(*) AS PostsNumber, 
  MAX(Score) AS MaxScore 
FROM 
  Posts 
WHERE 
  PostTypeId IN (1, 2) 
GROUP BY 
  Year, 
  Month 
HAVING 
  PostsNumber > 1000

```

## Query 3
```sql
SELECT 
  Id, 
  DisplayName, 
  TotalViews 
FROM 
  (
    SELECT 
      OwnerUserId, 
      SUM(ViewCount) as TotalViews 
    FROM 
      Posts 
    WHERE 
      PostTypeId = 1 
    GROUP BY 
      OwnerUserId
  ) AS Questions 
  JOIN Users ON Users.Id = Questions.OwnerUserId 
ORDER BY 
  TotalViews DESC 
LIMIT 
  10
 

```

## Query 4
```sql
SELECT 
  DisplayName, 
  QuestionsNumber, 
  AnswersNumber, 
  Location, 
  Reputation, 
  UpVotes, 
  DownVotes 
FROM 
  (
    SELECT 
      * 
    FROM 
      (
        SELECT 
          COUNT(*) as AnswersNumber, 
          OwnerUserId 
        FROM 
          Posts 
        WHERE 
          PostTypeId = 2 
        GROUP BY 
          OwnerUserId
      ) AS Answers 
      JOIN (
        SELECT 
          COUNT(*) as QuestionsNumber, 
          OwnerUserId 
        FROM 
          Posts 
        WHERE 
          PostTypeId = 1 
        GROUP BY 
          OwnerUserId
      ) AS Questions ON Answers.OwnerUserId = Questions.OwnerUserId 
    WHERE 
      AnswersNumber > QuestionsNumber 
    ORDER BY 
      AnswersNumber DESC 
    LIMIT 
      5
  ) AS PostsCounts 
  JOIN Users ON PostsCounts.OwnerUserId = Users.Id


```

## Query 5

```sql
SELECT 
  Title, 
  CommentCount, 
  ViewCount, 
  CommentsTotalScore, 
  DisplayName, 
  Reputation, 
  Location 
FROM 
  (
    SELECT 
      Posts.OwnerUserId, 
      Posts.Title, 
      Posts.CommentCount, 
      Posts.ViewCount, 
      CmtTotScr.CommentsTotalScore 
    FROM 
      (
        SELECT 
          PostId, 
          SUM(Score) AS CommentsTotalScore 
        FROM 
          Comments 
        GROUP BY 
          PostId
      ) AS CmtTotScr 
      JOIN Posts ON Posts.Id = CmtTotScr.PostId 
    WHERE 
      Posts.PostTypeId = 1
  ) AS PostsBestComments 
  JOIN Users ON PostsBestComments.OwnerUserId = Users.Id 
ORDER BY 
  CommentsTotalScore DESC 
LIMIT 
  10

```


