library('microbenchmark')

#1
microbenchmark(
  sql_1(Users),
  base_1(Users),
  dplyr_1(Users),
  table_1(Users)
)

#2
microbenchmark(
  sql_2(Posts),
  base_2(Posts),
  dplyr_2(Posts),
  table_2(Posts)
)

#3
microbenchmark(
  sql_3(Posts,Users),
  base_3(Posts,Users),
  dplyr_3(Posts,Users),
  table_3(Posts,Users),
  times=10
)

#4
microbenchmark(
  sql_4(Posts,Users),
  base_4(Posts,Users),
  dplyr_4(Posts,Users),
  table_4(Posts,Users),
  times=10
)

#5
microbenchmark(
  sql_5(Posts,Comments,Users),
  base_5(Posts,Comments,Users),
  dplyr_5(Posts,Comments,Users),
  table_5(Posts,Comments,Users),
  times=10
)

#Conclusion - data.table > dplyr > base > sqldf