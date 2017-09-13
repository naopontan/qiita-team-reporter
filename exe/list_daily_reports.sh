#!/bin/sh

list_daily_reports() {
    # Show given user's daily repots this month
    ./list_tag_items_all "日報/$(date +%Y/%m)" | grep $1 | sort | cut -d, -f2-
}

# Check number of given arguments
if [ $# -ne 1 ]
then
    echo "Usage: ./list_daily_reports.sh USERNAME"
    echo "  Ex.: ./list_daily_reports.sh yasulab"
    exit 1
fi

# Check required commands
COMMANDS=( "envchain" "qiita" "jq" )
cmd_check() {
    type $1 > /dev/null 2>&1
    if [ $? != 0 ]
    then
	echo "'$1' not found"
	echo "Please install this command via Homebrew or RubyGems"
	echo ""
	exit 1
    fi
}
for cmd in ${COMMANDS[@]}
do
    cmd_check $cmd
done

# Exec with given arguments if ready
list_daily_reports $@
