#!/usr/bin/env sh

[ -z "$POOL" ] && export POOL="$SCHEME://$USERNAME.$WORKERNAME:$PASSWORD@$POOLADDRESS:$POOLPORT"
[ -n "$API_PORT" ] && export API="--api-port $API_PORT"
[ -n "$RECHECK_TIME" ] && export RECHECK="--getwork-recheck $RECHECK_TIME"

nsfminer -G -P "$POOL" $API $RECHECK
