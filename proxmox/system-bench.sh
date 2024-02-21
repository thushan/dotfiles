sysbench memory --memory-block-size=1G --memory-total-size=16G --memory-oper=write run > ./default-write.txt
sysbench memory --memory-block-size=1G --memory-total-size=16G --memory-oper=read run > default-read.txt
