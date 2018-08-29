if [ -n "$READLINE_INIT" ] ; then
    echo "$READLINE_INIT" > ~/.inputrc
fi
yangcli "$@"
