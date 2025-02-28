#! /bin/bash

browser="brave"
model="llama3.1"
format="Plain Text"
output=""
exval=0

rofi_command="rofi -theme $HOME/.config/rofi/themes/center-nord.rasi"

outputoptions="Plain Text\!Markdown\!HTML\!LaTeX\!Code Snippets\!Lists\!Tables\!CSV\!XML\!URL\!Ascii Art"

#schedule meetings / appointments
#find quote / daily quote
#prioritizing / email management
#choose your own adventure
#compose and outline
#details of an outline
#executive summary
#summarize a transcript
#herbalist
#20 questions
#translate

get_ollama_response () {
	
#response=curl http://localhost:11434/api/generate -d '{
##  "model": "${model}",
#  "prompt": "${prompt}",
#  "stream": false
#}' | jq '.["response"]'
	
response=curl http://localhost:11434/api/chat -d '{
  "model": "${model}",
  "stream":false,
  "messages": [
    {
      "role": "user",
      "content": "Why is the sky blue? Give the shortest answer possible in under 20 words"
    }
  ]
}' | jq '.["message"]["content"]'

}



#Ask user for type of prompt
options="$general\n$emailcompose\n$emailreply\n$emailinvite\n$chatgpt\n$info\n$summarize\n$search"
choice=="$(echo -e "$options" | $rofi_command -p "Please Select" -dmenu -selected-row 0)"

case $choice in
    $general)
				system=""
        ;;
        
    $emailcompose)
    
    #Train a model with something like the following system
    #model="emailHelper"
    #Please ask follow-up questions if audience or topic are not clear
    
    system="Write a professional but generally informal email from a 46-year-old male living in Calgary, Alberta, Canada. The writer is tech-savvy and has a strong interest in academics, as well as outdoor sports like hiking and skiing. He's married with two teenage kids. Write the email to an unknown audience, but assume they're familiar with basic technology concepts. Include a brief one-line greeting wishing the recipient well or hoping their week is going well. Use a tone that's approachable, yet professional, and incorporate general interests or experiences in a subtle way.
    
    * You could add specific topics or areas of interest to discuss (e.g. new technology trends, best practices for [specific industry], etc.)
    * You could include a brief reference to an upcoming event or deadline
    
    ***Example output:***
    Using this prompt, a generated email might look something like:
    
    Subject: Re: [Topic]
    
    Hi [Recipient],
    
    I hope this email finds you well. I wanted to follow up on our previous discussion about [topic]. As we move forward, I'd be happy to provide some additional insights and resources to help us get started.
    
    In my free time, I've been enjoying exploring some of Calgary's outdoor trails - the scenery here is really something special! However, I'm also excited to dive back into some new research papers I've been meaning to read. Have you come across any interesting articles or studies recently?
    
    Looking forward to hearing back from you.
    
    Best,
    
    [Your Name]
    
    ***End Example***
    
    Please write the email on the following: "

				#xdg-email $output &
    
				;;
    
    $emailreply)
    
    #Train a model with something like the following system
    #model="emailHelper"
    #Please ask follow-up questions if audience or topic are not clear
    
    system="Write a professional but generally informal email from a 46-year-old male living in Calgary, Alberta, Canada. The writer is tech-savvy and has a strong interest in academics, as well as outdoor sports like hiking and skiing. He's married with two teenage kids. Write the email to an unknown audience, but assume they're familiar with basic technology concepts. Include a brief one-line greeting wishing the recipient well or hoping their week is going well. Use a tone that's approachable, yet professional, and incorporate general interests or experiences in a subtle way.
    
    * You could add specific topics or areas of interest to discuss (e.g. new technology trends, best practices for [specific industry], etc.)
    * You could include a brief reference to an upcoming event or deadline
    
    ***Example output:***
    Using this prompt, a generated email might look something like:
    
    Subject: Re: [Topic]
    
    Hi [Recipient],
    
    I hope this email finds you well. I wanted to follow up on our previous discussion about [topic]. As we move forward, I'd be happy to provide some additional insights and resources to help us get started.
    
    In my free time, I've been enjoying exploring some of Calgary's outdoor trails - the scenery here is really something special! However, I'm also excited to dive back into some new research papers I've been meaning to read. Have you come across any interesting articles or studies recently?
    
    Looking forward to hearing back from you.
    
    Best,
    
    [Your Name]
    
    ***End Example***
    
    Please write the email response to the following email: "

				#xdg-email $output &
    
				;;
				
    $emailinvite)
    
    #Train a model with something like the following system
    #model="emailHelper"
    #Please ask follow-up questions if audience or topic are not clear
    
    system="Write a professional but generally informal email invite from a 46-year-old male living in Calgary, Alberta, Canada. The writer is tech-savvy and has a strong interest in academics, as well as outdoor sports like hiking and skiing. He's married with two teenage kids. Write the email to an unknown audience, but assume they're familiar with basic technology concepts. Include a brief one-line greeting wishing the recipient well or hoping their week is going well. Use a tone that's approachable, yet professional, and incorporate general interests or experiences in a subtle way.
    
    * You could add specific topics or areas of interest to discuss (e.g. new technology trends, best practices for [specific industry], etc.)
    * You could include a brief reference to an upcoming event or deadline
    
    ***Example output:***
    Using this prompt, a generated email might look something like:
    
    Subject: Re: [Topic]
    
    Hi [Recipient],
    
    I hope this email finds you well. I wanted to follow up on our previous discussion about [topic]. As we move forward, I'd be happy to provide some additional insights and resources to help us get started.
    
    In my free time, I've been enjoying exploring some of Calgary's outdoor trails - the scenery here is really something special! However, I'm also excited to dive back into some new research papers I've been meaning to read. Have you come across any interesting articles or studies recently?
    
    Looking forward to hearing back from you.
    
    Best,
    
    [Your Name]
    
    ***End Example***
    
    Please write the email invite for the following: "

				#xdg-email $output &
    
				;; 
    
    $info)
    
    
				;;
				
		 $search)
    
    
				;;
				
			$adventure)
			
			
			system="Hey AI, I’d like to play a choose-your-own adventure style text game with you.

The way I’d like this to work is you are going to create a story as we go, and keep the game grounded in its own world and game parameters. And I would like to call you GAL (Game AI Liaison), so you know when i’m talking to you, and not talking in game.

You create a story, and let me make the choices to progress the story.

I’ll start by giving you the game parameters and rules. ( If at any point in the game you need to figure out something for the rules of the game, you can ask me what I prefer.)

Here are some parameters/rules:

I'd like this to be like an RPG. So that means I'd like to work on my skills. So if there is an activity , and my character can't do it because i don't have the skill, that's ok. I can come back to it when i have learned the proper skills. Or i can have an expert on my team do the activity.

I'd like there to be back and forth conversations. That means when I am having a conversation with characters, let’s pretend like I'm having a conversation with the character in the game so it's more immersive.

Whenever I say anything such as: I talk to, or I converse with (anything like that). Please add some conversation between the characters for some more immersive dialogue context.

I'd like to micro manage decisions, I want to control as much as I can. Place as much control with me as possible. Of course it is ok to write a bit, to keep the story moving. Just give me control of the decisions.

I want to have this be as immersive and creative as possible. So please don't give me options of things to do. when you need my input, just say something along the lines of, what do you do now?

I want there to be a main overarching story of what we are trying to accomplish, and side missions. Think like a video game.

Keep all of my actions and your story grounded in the same theme. That means if i'm in a space sci fi, no dragons flying around. Unless it's a fantasy sci-fi blend.

I want it to be challenging, which means it's ok for you to tell me that something didn't go to plan from one of my actions. So if I say, hit with a sword, or jump over a river, it's ok to say the sword was blocked or I slipped and fell in the water. It's also ok for you to create conflict or heartbreak. Let's just have some fun by making it a little unpredictable.

Like a video game, I need limits on my power or anything similar. So I can't just use infinite magic, or I can't just run forever without getting tired, or have infinite ammo. That kinda stuff. I should have some sort of energy or inventory.

I'd like you to keep track of things I would have in my inventory, like gold, items, misc. When we use an item, collect an item or use money, anything of that sort, please let me know or calculate it visually and let me see the changes happening.

it's ok for this to be mature. As in, mature themes.

Let's have a day/night cycle. And let me know every once and a while what time it is.

Don’t be afraid to write long passages. I don't mind you explaining all the fine details in the settings and people around. You can even have my character speak , if it's light conversation and within the context of what you know of my character. But I'd like to be in control of decisions and most of the talking.

Please provide responses and reactions from the people and world around me as I talk and interact with them.

Please provide a jumping off statement when you are finished with your writing. Something such as: What do you do now? How do you respond? Something open -ended but also guiding me to make a decision.

As we go along, we will be adding some parameters that are needed when they come up. If there are any other rules / parameters you think you want to clarify, let me know.

Lastly, In game I want my name to be: Sir Jaso

And I want the setting for this game to be a (ENTER GAME TYPE HERE)

And I want the Story to begin here with some details about the story to start with: (ENTER OPTIONAL STORY START OFF POINT HERE W/ANY DETAILS YOU WANT, OR DELETE THIS SECTION TO HAVE GAL CREATE STORY FROM SCRATCH)"
			
			;;
		
		 $summarize)
    
    
				;;		  
      *)
        
        ;;
        
esac



prompt=$( rofi -config $HOME/.config/rofi/themes/nord-alt.rasi -mesg "${model}" -dmenu -p "Prompt" )
prompt="$system$prompt"



#echo -e "$output" | rofi -config $HOME/.config/rofi/themes/nord-alt.rasi -scroll-method 1 -mesg "..." -dmenu -p "Prompt"
#echo "$output" | yad --text-info --wrap --scroll --button="Prompt":2 --button="Quit":1 --file-op --editable "-"

while [[ $exval == 0 ]] 
do

echo "$prompt"

#output=$(ollama run "$model" "$prompt")
output=$(ollama run "$model" "$prompt")
#copy to the clipboard
wl-copy "$output"

#userinput=$(yad --text-info --wrap --scroll --button="Prompt":0 --button="Quit":1 --file-op --text "${output}" \
#userinput=$(yad --button="Prompt":0 --button="Quit":1 --text "Prompt:${prompt}\n\n---" --scroll \
userinput=$(yad --button="Prompt":0 --button="Quit":1  --scroll \
--form \
--field="Prompt" "" \
--field="------------:LBL" \
--field="Output:TXT" "${output}" )

exval=$?
echo 
echo "$output" >> /tmp/ollama_chat
prompt="Prompt:$userinput \n\nApply the prompt above to this previous message:$output"

done


#yad --calendar --date-format=%Y-%m-%d
