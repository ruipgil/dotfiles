truncated_appointment=`icalBuddy -n -npn -nc -iep "title,datetime" -ps "|=|" -po "datetime,title" -tf "=%H.%M" -df "" -eed eventsToday+ | head -n 1 | awk -F "=" '{print substr($2,0,5)" : "$3}' | cut -c -25`
echo "🗓  $truncated_appointment"
