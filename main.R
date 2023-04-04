library(sqldf)
library(dplyr)
library(data.table)

Comments <- read.csv("./data/Comments.csv.gz")
Users <- read.csv("./data/Users.csv.gz")
Posts <- read.csv("./data/Posts.csv.gz")

setDT(Comments)
setDT(Users)
setDT(Posts)

source("./src/query_1/sql_1.R")
source("./src/query_1/base_1.R")
source("./src/query_1/dplyr_1.R")
source("./src/query_1/table_1.R")

source("./src/query_2/sql_2.R")
source("./src/query_2/base_2.R")
source("./src/query_2/dplyr_2.R")
source("./src/query_2/table_2.R")

source("./src/query_3/sql_3.R")
source("./src/query_3/base_3.R")
source("./src/query_3/dplyr_3.R")
source("./src/query_3/table_3.R")

source("./src/query_4/sql_4.R")
source("./src/query_4/base_4.R")
source("./src/query_4/dplyr_4.R")
source("./src/query_4/table_4.R")

source("./src/query_5/sql_5.R")
source("./src/query_5/base_5.R")
source("./src/query_5/dplyr_5.R")
source("./src/query_5/table_5.R")



sql_1_result <- sql_1(Users)

all_equal(sql_1_result, base_1(Users))
all_equal(sql_1_result, dplyr_1(Users))
all_equal(sql_1_result, table_1(Users))

#2

sql_2_result <- sql_2(Posts)

all_equal(sql_2_result, base_2(Posts))
all_equal(sql_2_result, dplyr_2(Posts))
all_equal(sql_2_result, table_2(Posts))

#3
sql_3_result <- sql_3(Posts, Users)

all_equal(sql_3_result, base_3(Posts, Users))
all_equal(sql_3_result, dplyr_3(Posts, Users))
all_equal(sql_3_result, table_3(Posts, Users))

#4
sql_4_result <- sql_4(Posts, Users)

all_equal(sql_4_result, base_4(Posts, Users))
all_equal(sql_4_result, dplyr_4(Posts, Users))
all_equal(sql_4_result, table_4(Posts, Users))

#5
sql_5_result <- sql_5(Posts, Comments, Users)

all_equal(sql_5_result, base_5(Posts, Comments, Users))
all_equal(sql_5_result, dplyr_5(Posts, Comments, Users))
all_equal(sql_5_result, table_5(Posts, Comments, Users))

