#!/bin/bash

#Application downloads data from the REN.
#Example:./ren.sh 2010
#2010 is a year.

is_leap_year() {
    year=$1

    true=0
    false=1

    [ `expr $year % 400` -eq 0 ] && return $true
    [ `expr $year % 100` -eq 0 ] && return $false
    [ `expr $year %   4` -eq 0 ] && return $true
    return $false
}

get_path() {
    date=$1

    echo "http://www.centrodeinformacao.ren.pt/userControls/GetExcel.aspx?T=CRG&P=$date&variation=PT"
}

get_day() {
    year=$1
    month=$2
    day=$3

    date="$day-$month-$year"
    dst="$year-$month-$day.xls"
    wget -O $dst `get_path $date`
}

get_month() {
    year=$1
    month=$2
    days=$3

    for day in `seq -w 1 $days`; do
        get_day $year $month $day
    done
}

get_year() {
    year=$1

    is_leap_year $year && feb=29 || feb=28

    get_month $year 01 31
    get_month $year 02 $feb
    get_month $year 03 31
    get_month $year 04 30
    get_month $year 05 31
    get_month $year 06 30
    get_month $year 07 31
    get_month $year 08 31
    get_month $year 09 30
    get_month $year 10 31
    get_month $year 11 30
    get_month $year 12 31
}

###
# Main body of script starts here
###
echo "Start of script..."
get_year $1
echo "End of script..."
