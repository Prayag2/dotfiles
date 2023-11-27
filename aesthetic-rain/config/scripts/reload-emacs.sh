#/bin/env sh

killall -KILL emacs; sleep 0.5 && emacs --daemon &
