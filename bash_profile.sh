export bastionHostArr=("bastion.lvs.ff.com"
			            "ff.lvs.ff.com")
#export bastionHostArr=("bastion.vip.com")

export bastionIndex=2
export bastionRnoIndex=1
export userName="<>"
export corpPwd="<>"
export ptPwd="<>"
export ntPetPwd="<>"

#just bastion
shb() {
    ssh ${bastionHostArr[bastionIndex]}  -o ServerAliveInterval=60
}

#jump...not required anymore
sshp() {
    ssh ${bastionHostArr[bastionIndex]}  -o ServerAliveInterval=60 -tt ssh -tt $userName@"$1" -o ServerAliveInterval=60
}

#just tunnel creation...not required anymore
sht(){
    # sudo killall ssh
    # ssh USER@FINAL_DEST -o "ProxyCommand=nc -X connect -x PROXYHOST:PROXYPORT %h %p"

    ps -ef | grep bastion | grep 1070 | grep $userName | grep -v grep > /dev/null

    if [ $? -eq 1 ]
    then
      echo ' You missing ssh tqunnel. Creating one..'
      ssh -f -N -D *:1070 $userName@${bastionHostArr[bastionIndex]} -o ServerAliveInterval=60 -o "StrictHostKeyChecking no"
    fi

}

#connect to any prod machine through ssh tunnel
shp() {
    # sudo killall ssh
    # ssh USER@FINAL_DEST -o "ProxyCommand=nc -X connect -x PROXYHOST:PROXYPORT %h %p"

    ps -ef | grep bastion | grep 1070 | grep $userName | grep -v grep > /dev/null

    if [ $? -eq 1 ]
    then
      echo ' You missing ssh tunnel. Creating one..'
      ssh -f -N -D *:1070 $userName@${bastionHostArr[bastionIndex]} -o ServerAliveInterval=60 -o "StrictHostKeyChecking no"
    fi

    echo 'SSH through sock tunnel'
    sshpass -p "$petPwd" ssh -o "ProxyCommand=nc -x localhost:1070 %h %p" $userName@$1 -o ServerAliveInterval=60 -o "StrictHostKeyChecking no"


}

hdp-apollo() {
    # sudo killall ssh
    # ssh USER@FINAL_DEST -o "ProxyCommand=nc -X connect -x PROXYHOST:PROXYPORT %h %p"

    ps -ef | grep bastion | grep 1070 | grep $userName | grep -v grep > /dev/null

    if [ $? -eq 1 ]
    then
      echo ' You missing ssh tunnel. Creating one..'
      ssh -f -N -D *:1070 $userName@${bastionHostArr[bastionIndex]} -o ServerAliveInterval=60 -o "StrictHostKeyChecking no"
    fi

    echo 'SSH through sock tunnel'
    sshpass -p $ntPetPwd ssh  -o "ProxyCommand=nc -x localhost:1070 %h %p" $userName@apollo-rno-devours.vip.hadoop.ebay.com -o ServerAliveInterval=60 -o "StrictHostKeyChecking no"

}
