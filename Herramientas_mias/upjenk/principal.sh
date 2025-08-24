#!/bin/bash

export jenkins_home="$HOME/.jenkins"
source ./pluginsversion.sh && source ./securitybackups.sh && echo -e "\e[1;32m All modules have been loaded successfully \e[0m"


echo -e "
\e[1;36m
     _______________
    |_______0_______|
    |^||^||^||^||^|^| 
    |^||^||^||^||^|^| 
<<<<=================>>>>
  /                   \                  
 |    ___       ___    |
 |   |   |     |   |   |
 |   |_@_|     |_@_|   |
 |          #          | 
 \          #          /
  \         #         /
   \   ###########   /
    \  ###########  / 
     \_____________/

#         __               __   .__                                     
#        |__| ____   ____ |  | _|__| ____   ______  
#        |  |/ __ \\/     \\|  |/ /  |/    \\ /  ___/ 
#        |  \\  ___/|   |  \    <|  |   |  \\___ \\
#    /\\__|  |\\___  >___|  /__|_ \__|___|  /____ >
#    \\______|    \\/     \\/     \\/       \\/    \\/

\e[0m
"
while true; do

echo -e "
\e[1;36m
WHAT IS YOUR WISH ?
\e[0m

\e[1;32m
0) POWEROFF
1) BACKUP OF JENKINS HOME
2) KNOW PLUGIN'S VERSION
3) UPDATE PENDING PLUGINS
\e[0m
"
read -p "your choice here: " userinput

echo -e "\n" 

case $userinput in
    "0") exit 0 ;;
    "1") backupjenkinshome ;;
    "2") getpluginversion ;;
    "3") installpendingplugins ;;
    *)   echo -e "\e[1;31m not valid choice, CLICK 0 to exit \e[0m" ;;

esac
done

