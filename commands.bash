#!/usr/bin/env bash

read nick chan cmd args saying

if `echo $saying | grep -i 'a user\>' | grep -v 'named\>' > /dev/null` ; then
    echo "PRIVMSG $chan :$nick: \"a user?\" What is their username?"
elif `echo $saying | grep -i 'owlbot: voodoo?' > /dev/null` ; then
    echo "PRIVMSG $chan :$nick: I\'m not Ep1trope."
elif `echo $saying | grep -i 'owlbot: help' > /dev/null` ; then
        echo "PRIVMSG $chan :$nick: I parse on 'a user', 'someone' and 'somebody'. If you need further help, contact dom."        
elif `echo $saying | grep '.*[a-z]: someone\>' | grep -v 'named\>' > /dev/null` ; then
        echo "PRIVMSG $chan :$nick: \"someone?\" Could you be more specific?"
elif `echo $saying | grep '.*[a-z]: somebody\>' | grep -v 'named\>' > /dev/null` ; then
        echo "PRIVMSG $chan :$nick: \"somebody?\" Could you be more specific?"
fi
