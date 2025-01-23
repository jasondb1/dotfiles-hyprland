#! /bin/sh

#$TODO=~/Documents/test.txt
#file=~/Documents/test.txt

#while read p; do
#  echo "$p"
#done < <(sort -k2 -t, "$file")


#CUR_DATE=$(date +%s)
#while IFS="," read -r name date
#do
#  #echo "Displaying Record: $name"
#  DATE=$(date +%s --date=$date)
#  #echo "Date: $DATE"
#	DIFF_SEC=$(( (DATE - CUR_DATE) ))
#	DAYS=$(( ($DIFF_SEC/(60*60*24))  ))
#  echo "$name:$DAYS days"
#done < <(sort -k2 -t, "$file")



# Check if a filename is provided as an argument
#if [ $# -ne 1 ]; then
#  echo "Usage: $0 <input-file.md>"
#  exit 1
#fi



# Input file (markdown)
#input_file=$1
input_file=~/Documents/test.txt

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "File not found: $input_file"
  exit 1
fi

case $1 in
  --get_events)

# Get today's date in YYYY-MM-DD format
today=$(date +%Y-%m-%d)

# Read each line from the markdown file (assumes semicolon-separated values)
while IFS="," read -r description due_date; do
  # Trim leading/trailing spaces
  description=$(echo "$description" | xargs)
  due_date=$(echo "$due_date" | xargs)

  # Skip empty lines or lines that don't have both a description and a due date
  if [ -z "$description" ] || [ -z "$due_date" ]; then
    continue
  fi

  # Calculate the number of days between today and the due date
  due_seconds=$(date -d "$due_date" +%s)
  today_seconds=$(date -d "$today" +%s)
  days_left=$(( (due_seconds - today_seconds) / 86400 ))
  #DAYS=$(( ($DIFF_SEC/(60*60*24))  ))

  # Output the result
  if [ $days_left -ge 0 ]; then
    echo "$description in $days_left days"
  else
    echo "$description past $(( -days_left )) days ago"
  fi
#done < "$input_file"
done < <(sort -k2 -t, "$input_file")
    ;;
  --new_event)
  echo $0 $1 $2 $3
#	if [ $2 -nz ]; then
#		echo "Usage: $0 --new_event [description] [date]"
#		exit 1
#	fi
  
  echo "$2,$3" >> "$input_file"
  ;;
  
    
  *)
    echo "usage read_todo [--get_events | --new_event | --change_event ]"
    ;;
esac
