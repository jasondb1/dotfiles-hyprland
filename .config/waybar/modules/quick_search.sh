#! /bin/bash

browser="brave"
        
#INPUTTEXT=$(yad --text-align=center --text="Please enter your request" --entry --entry-label=""
# --entry-text="Type here" )
#yad --text="You entered: $INPUTTEXT"

INPUTForm=$(yad --Title="User Entry" \
	--text="Please enter your data:"
		--form\
		--field="Date:" \
		--field="Details:" \
		)
		
		
		yad --form --field="Date::DT" --field="Data::TXT"

#yad --calendar --date-format=%Y-%m-%d


#~ case "$1" in
    #~ --search)
#~ #search internet using 
        #~ ;;
        
    #~ --ollama)
    
    
				#~ ;;
    
    #~ --email)
    
    
				#~ ;;
    #~ *)
        #~ echo $"Usage: $0 {--search | --ollama | --email}"
        #~ ;;
#~ esac
