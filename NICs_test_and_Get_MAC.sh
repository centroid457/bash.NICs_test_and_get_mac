#=================
#Starichenko
#ver1.1
#2016.12.28
#=================


ip1="10"
ip2=".10"
ip3=".6"
ip40=".1"
ipping=$ip1$ip2".6.1"
mask=255.0.0.0


ls=`ls /proc/net/dev_snmp6/|tr -d '[:alpha:]'`
echo ls=[$ls]
#line


# switching off all NICs
for i in $(ls /proc/net/dev_snmp6/); do
	sudo /sbin/ifconfig $i down
	sudo /sbin/ifdown $i
done


echo DETECTED NETWORK ADAPTERS
echo ///
echo ///
echo ///
ls /proc/net/dev_snmp6/
echo ///
echo ///
echo ///
echo PRESS ENTER
#line

for i in $ls; do
	ipn=$ip1$ip2$ip3$ip40$i
	sudo /sbin/ifconfig eth$i|grep 'HWaddr'
	#reset
	ls /proc/net/dev_snmp6/
	echo ETH=eth[$i]
	sudo /sbin/ifconfig eth$i down
	sudo /sbin/ifconfig eth$i $ipn netmask $mask
	sudo /sbin/ifconfig eth$i up
	sudo /sbin/ifconfig eth$i $ipn netmask $mask
	/sbin/ifconfig eth$i|grep 'inet addr'
	ping -I eth$i $ipping
	sudo /sbin/ifconfig eth$i down
	sudo /sbin/ifdown eth$i
	#sudo ifdown eth$i
	sudo /sbin/ifconfig eth$i|grep 'HWaddr'
	#line
	reset
done
reset
echo TEST FINNISHED
echo CLOSE WINDOW (Alt+F4)
line

exit 0
