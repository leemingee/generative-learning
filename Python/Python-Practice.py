# _*_ coding: UTF-8 _*_

# eg. 1
# 有四个数字1、2、3、4，能组成多少个互不相同而且无重复数字的三位数？各是多少?

# 将所有的结果排列，然后去除不满足条件的

for i in range(1,5):
    for j in range(1, 5):
        for k in range(1, 5):
            if (i != k) and (i != j) and (j != k):
                print(i, j, k)