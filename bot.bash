#!/usr/bin/env bash

function send {
    echo "-> $1"
    echo "$1" >> .botfile
}
rm .botfile
mkfifo .botfile
tail -f .botfile | openssl s_client -connect irc.cat.pdx.edu:6697 | while true ; do
    if [[ -z $started ]] ; then
        send "USER owlbot owlbot owlbot :owlbot"
        send "NICK newowlbot"
        send "JOIN #newowlbottest"
        started="yes"
    fi
    read irc
    echo "<- $irc"
    if `echo $irc | cut -d ' ' -f 1 | grep PING > /dev/null` ; then
        send "PONG"
    elif `echo $irc | grep PRIVMSG > /dev/null` ; then
        chan=`echo $irc | cut -d ' ' -f 3`
        barf=`echo $irc | cut -d ' ' -f 1-3`
        saying=`echo ${irc##$barf :}|tr -d "\r\n"`
        nick="${irc%%!*}"; nick="${nick#:}"
        cmd=`echo $saying | cut -d ' ' -f 1`
        args="${saying#$cmd }"
        if [[ $cmd == 'quit' && $nick == 'dom' ]] ; then
            send "QUIT :Cya!"
        fi
        var=$(echo $nick $chan $cmd $args $saying | ./commands.bash)
        if [[ ! -z $var ]] ; then
            send "$var"
        fi
    fi
done
