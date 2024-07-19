#Nikolas Gustavson
#COSC-4327-
#Dr. Brown
#This program is a simple maze game where the user can go around the rooms looking for hints. When the user has collected all the hints, they get a chance to guess the password. If they get it wrong then they can keep trying until they get it right

#!/bin/bash

# Turn the maze into an array and give each descriptions
maze=(
  "You are in Room 1,1. Very dark room. There are exits to the $(tput setaf 1;tput smul;tput bold)south$(tput sgr 0), and $(tput setaf 1;tput smul;tput bold)east$(tput sgr 0)."
  "You are in Room 1,2. Hidden in the wallpaper is a hint. You can go $(tput setaf 1;tput smul;tput bold)south$(tput sgr 0), $(tput setaf 1;tput smul;tput bold)east$(tput sgr 0), and $(tput setaf 1;tput smul;tput bold)west$(tput sgr 0)."
  "You are in Room 1,3. This room is just pink. There are exits to the $(tput setaf 1;tput smul;tput bold)south$(tput sgr 0) and $(tput setaf 1;tput smul;tput bold)west$(tput sgr 0)."
  "You are in Room 2,1. Wow it's cold in here. There are exits to the $(tput setaf 1;tput smul;tput bold)north$(tput sgr 0)north, $(tput setaf 1;tput smul;tput bold)east$(tput sgr 0), and $(tput setaf 1;tput smul;tput bold)south$(tput sgr 0)."
  "You are in Room 2,2. You can barely see a hint on the floor. You can go $(tput setaf 1;tput smul;tput bold)north$(tput sgr 0), $(tput setaf 1;tput smul;tput bold)south$(tput sgr 0), $(tput setaf 1;tput smul;tput bold)east$(tput sgr 0), or $(tput setaf 1;tput smul;tput bold)west$(tput sgr 0)."
  "You are in Room 2,3. All you see is fake windows. You can go $(tput setaf 1;tput smul;tput bold)north$(tput sgr 0), $(tput setaf 1;tput smul;tput bold)south$(tput sgr 0), and $(tput setaf 1;tput smul;tput bold)west$(tput sgr 0)."
  "You are in Room 3,1. There's a dog in the room. There are exits to the $(tput setaf 1;tput smul;tput bold)east$(tput sgr 0) and $(tput setaf 1;tput smul;tput bold)north$(tput sgr 0)."
  "You are in Room 3,2. You've stumbled upon a hint. You can go $(tput setaf 1;tput smul;tput bold)north$(tput sgr 0), $(tput setaf 1;tput smul;tput bold)east$(tput sgr 0), and $(tput setaf 1;tput smul;tput bold)west$(tput sgr 0)."
  "You are in Room 3,3. This room looks like a sauna. You can go $(tput setaf 1;tput smul;tput bold)north$(tput sgr 0) and $(tput setaf 1;tput smul;tput bold)west$(tput sgr 0)."
)

# Set the password and the rooms the hints are in
password="basketball"
hintRooms=("${maze[1]}" "${maze[4]}" "${maze[7]}")

hint1="You can dribble it!"
hint2="You can shoot it!"
hint3="You can pass it around with four other teammates!"

let a=0
let b=0
let c=0

# Don't let the user terminate the program
trap "echo You cannot terminate the program that way! Hit enter to continue or type exit to quit the game" 2 3 4

# Splash screen
splash_screen () {
tput clear
tput setaf 2
tput smul
echo -e "THE INFAMOUS MAZE GAME\n"
# when user hits enter is when you execute the game
read -e -r -s -p $'HIT ENTER WHEN YOU ARE READY TO PLAY\n' -d $'\x0a'
tput sgr 0
}

splash_screen

victory_screen() {
tput clear
echo -e "$(tput setaf 4; tput setab 7)CONGRATULATIONS AFTER A LONG JOURNEY YOU HAVE FINALLY MADE IT OUT OF THE MAZE!!!\n$(tput sgr 0)"
read -r -s -p $'HIT ENTER WHEN YOU ARE READY TO QUIT THE GAME' -d $'\x0a'
}

hints_echo() {
    if [ "$a" -eq 1 ]; then
      tput setaf 4; tput bold
	echo "$hint1"
	tput sgr 0
    fi
    if [ "$b" -eq 1 ]; then
	  tput setaf 4; tput bold
        echo "$hint2"
	  tput sgr 0
    fi
    if [ "$c" -eq 1 ]; then
	  tput setaf 4; tput bold
        echo "$hint3"
	  tput sgr 0
    fi
}


# Set the starting position
tput clear
starting_position="${maze[4]}"

# Set hints found to zero
hintsFound=0

echo $starting_position
echo -e "Hints found: \n"

# Set both the variables x and y to 1 in order set the starting position and set gameOver to false
x=1
y=1
gameOver=false

# While loop to keep game going until it's finished

while [ "$gameOver" != true ]; do
  echo "Please choose a command: $(tput setaf 2;tput smul;tput bold)north$(tput sgr 0), $(tput setaf 3;tput smul;tput bold)south$(tput sgr 0), $(tput setaf 4;tput smul;tput bold)west$(tput sgr 0), $(tput setaf 1;tput smul;tput bold)east$(tput sgr 0), $(tput setaf 5;tput smul;tput bold)look$(tput sgr 0), $(tput setaf 2;tput smul;tput bold)search$(tput sgr 0) or $(tput setaf 6;tput smul;tput bold)exit$(tput sgr 0)"
  read -r input
input="${input,,}"

# Use case for each command and use -gt and -lt to check if x or y is greater than or less than 0 or 2
# I used a one dimensional array for the maze as I don't know how to do a 2D array in bash, so for my logic I used the statement x*3+y to move the user accordingly
  case $input in
    "north")
      if [ $x -gt 0 ]; then
        ((x -= 1))
	  tput clear
        echo "${maze[x * 3 + y]}"
	  echo -e "Hints Found: "
	  hints_echo
      else
        tput clear
        echo "Invalid move try again!"
        echo "${maze[x * 3 + y]}"
      fi
      ;;
    "south")
      if [ $x -lt 2 ]; then
        ((x += 1))
	  tput clear
        echo "${maze[x * 3 + y]}"
	  echo -e "Hints Found: "
	  hints_echo
      else
        tput clear
        echo "Invalid move try again!"
        echo "${maze[x * 3 + y]}"
      fi
      ;;
    "east")
      if [ $y -lt 2 ]; then
        ((y += 1))
	  tput clear
        echo "${maze[x * 3 + y]}"
	  echo -e "Hints Found: "
	  hints_echo
      else
        tput clear
        echo "Invalid move try again!"
        echo "${maze[x * 3 + y]}"
      fi
      ;;
    "west")
      if [ $y -gt 0 ]; then
        ((y -= 1))
	  tput clear
        echo "${maze[x * 3 + y]}"
	  echo -e "Hints Found: "
	  hints_echo
      else
        tput clear
        echo "Invalid move try again!"
        echo "${maze[x * 3 + y]}"
      fi
      ;;
    "look")
	tput clear
      echo "${maze[x * 3 + y]}"
      echo -e "Hints Found: "
      hints_echo
      ;;

# For the search command I used the for loop to iterate through the hintRooms and compare if the current room is a part of the hintRooms. If it is then you show the appropriate hint. And lastly whenever all the hints are found then it's going to prompt the user to input the password
    "search")
      for hintRoom in "${hintRooms[@]}"; do
        if [ "${maze[x * 3 + y]}" = "$hintRoom" ]; then
          ((hintsFound++))

          case "${maze[x * 3 + y]}" in
            "${maze[1]}")
          tput clear
          echo "You have found a hint:"
          tput setaf 4; tput bold
		  echo $hint1
		  tput sgr 0
		  let a=1
              ;;
            "${maze[4]}")
            tput clear
            echo "You have found a hint:"
            tput setaf 4; tput bold
	        echo $hint2
	        tput sgr 0
	       let b=1
              ;;
            "${maze[7]}")
            tput clear
            echo "You have found a hint:"
            tput setaf 4; tput bold
	        echo $hint3
	        tput sgr 0
	        let c=1
              ;;
          esac
        fi
      done

# I used {guess,,} to turn the guess lowercase so it wouldn't impact the comparison. If the user doesn't guess right they get to try again until the guess matches the password
      if [ $hintsFound -eq 3 ]; then
        echo "You've collected all the hints, now it is time to guess the password!"
        echo "Below are all the hints:"
        hints_echo
        echo "Give me your best guess"
        read -r guess
        if [ "${guess,,}" = $password ]; then
          victory_screen
          gameOver=true
		else 
			while [ "${guess,,}" != $password ]; do
			echo "You guessed wrong, try again!"
			read -r guess
			if [ "${guess,,}" = $password ]; then
          echo "Congratulations you have guessed the password correctly!"
          gameOver=true
		fi
		done
        fi
      fi
      ;;
    "exit")
      echo "Thanks for trying..."
      gameOver=true
	trap 2 3
      ;;
  esac
done