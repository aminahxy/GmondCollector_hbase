lftp  product.scm.baidu.com  -u getprod,getprod -e "ls -t /data/prod-64/inf/computing/normandy-server/|head  && quit"|sed s/\-\>.*$//g|awk '{print $NF}'
https://svn.baidu.com/op/dmop/dpfop/trunk/online/conf//NJ01-NANLING/abaci/online

svn  mkdir --parents  -m"add by tentacles" https://svn.baidu.com/op/dmop/dpfop/trunk/online/conf/GZNS-LIZHU/normandy
svn   --username=weizhonghui --password=radiation mkdir --parents  -m"add by tentacles" https://svn.baidu.com/op/dmop/dpfop/trunk/online/conf/cq02-baihua/normandy
