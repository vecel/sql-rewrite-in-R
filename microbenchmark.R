library('microbenchmark')

#1
microbenchmark(
  sqldf = sql_1(Users),
  base = base_1(Users),
  dplyr = dplyr_1(Users),
  table = table_1(Users)
)

# Unit: milliseconds
# expr       min        lq      mean    median        uq      max neval
# sqldf 194.74060 209.52540 243.16292 223.49657 281.48876 377.0821   100
# base 147.85017 157.31232 185.53777 170.86461 208.47947 311.0623   100
# dplyr  39.26092  42.54320  63.01531  46.35772  69.16775 375.0232   100
# table  10.61300  11.09248  15.92129  11.70950  14.61686  74.0208   100

#2
microbenchmark(
  sqldf = sql_2(Posts),
  base = base_2(Posts),
  dplyr = dplyr_2(Posts),
  table = table_2(Posts)
)

# Unit: milliseconds
# expr       min        lq      mean    median        uq      max neval
# sqldf 664.10849 675.30493 704.82280 682.70385 739.87782 932.1046   100
# base 119.53115 122.88182 161.10835 182.72457 188.08349 213.9036   100
# dplyr  68.05711  69.36856  86.23576  70.70062  73.94223 310.8963   100
# table  27.51663  28.10413  34.86606  28.48383  31.97399 101.0875   100

#3
microbenchmark(
  sqldf = sql_3(Posts,Users),
  base = base_3(Posts,Users),
  dplyr = dplyr_3(Posts,Users),
  table = table_3(Posts,Users),
  times=20
)

# Unit: milliseconds
# expr       min        lq      mean    median         uq        max neval
# sqldf 820.79655 865.63042 933.60739 892.98000 1005.34847 1185.20988    20
# base 247.20040 252.16854 282.04148 269.27950  305.35957  374.18953    20
# dplyr 103.07438 110.59330 152.62173 158.97179  170.28556  232.08534    20
# table  21.38334  22.13773  25.07312  23.02255   27.59701   33.28495    20

#4
microbenchmark(
  sqldf = sql_4(Posts,Users),
  base = base_4(Posts,Users),
  dplyr = dplyr_4(Posts,Users),
  table = table_4(Posts,Users),
  times=20
)

# Unit: milliseconds
# expr       min        lq      mean    median        uq        max neval
# sqldf 830.35426 848.66734 899.81624 884.45450 923.92926 1108.45119    20
# base 366.53789 384.93332 421.89875 423.57748 448.26225  489.99799    20
# dplyr 687.18504 762.85807 833.93015 791.37766 884.76508 1225.46645    20
# table  20.15207  20.99437  26.80985  23.98904  25.76952   91.78687    20

#5
microbenchmark(
  sqldf = sql_5(Posts,Comments,Users),
  base = base_5(Posts,Comments,Users),
  dplyr = dplyr_5(Posts,Comments,Users),
  table = table_5(Posts,Comments,Users),
  times=20
)

# Unit: milliseconds
# expr        min         lq       mean     median         uq       max neval
# sqldf 1345.76124 1418.02014 1486.98398 1456.80591 1515.71481 1838.6320    20
# base  765.14909  870.01821  946.93563  902.95420 1055.63939 1222.3784    20
# dplyr  254.56799  343.38992  378.49579  365.02756  419.09036  514.3387    20
# table   62.39671   69.64899   84.17514   79.48346   84.26594  133.7008    20

#Conclusion - data.table > dplyr > base > sqldf