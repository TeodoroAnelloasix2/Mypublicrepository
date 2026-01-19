#!/bin/bash


getpluginversion(){


    echo -e "
    <table style=\"border: 1px solid black; border-style: solid;\">
      <tr style=\"border: 1px solid black;\">
        <th style=\"border: 1px solid black;\" > Plugin </th>
        <th style=\"border: 1px solid black;\"> Version </th>
      </tr>
    " > ./pluginsdata/plugins.html
    
    echo -e "\e[1;32m Checking Jenkins plugins versions...  \e[0m "

    for plugin in "$jenkins_home/plugins/"*; do
        if [ -d "$plugin" ];then
            if [ -f "$plugin/META-INF/MANIFEST.MF" ];then
                #echo -e "Analizando: $plugin/META-INF/MANIFEST.MF"
                pl_path="$plugin/META-INF/MANIFEST.MF"
                
                pl_name=$(grep -i "Implementation-Title" $pl_path | cut -d ":" -f 2 | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g' | awk '{$1=$1;print}')
                pl_version=$(grep -i "Plugin-Version" $pl_path | cut -d ":" -f 2-3 | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g' | awk '{$1=$1;print}')
                               
            fi
            

            echo -e " <tr style=\"border: 1px solid black;\">
                    <td style=\"border: 1px solid black;\">$pl_name</td>
                    <td style=\"border: 1px solid black;\">$pl_version</td>
                </tr> " >> ./pluginsdata/plugins.html
        fi
    done

    echo -e "</table>" >> ./pluginsdata/plugins.html
}


installpendingplugins(){
  stopifrunning
  export pendingrepo="./pluginsdata/pendingplugins"
  export backuprepo="./pluginsdata/backup"
  echo -e "\e[1;32m Uploading pending plugins...\n This process will automatically create a backup of the last installed version of the plugins\e[0m "
  
  for plugin in "$pendingrepo/"*;do
    pl=$(echo $plugin| cut -d "/" -f 4 | cut -d "." -f 1)
    echo -e "\e[1;32m pl: $pl \e[0m"
    echo -e "\e[1;32m plugin: $plugin \e[0m"
    #if we find a previous version of the plugin we do a backup
    if [ -d "$jenkins_home/plugins/$pl" ];then
      if [ -f "$jenkins_home/plugins/$pl.jpi" ];then
        echo -e "\e[1;36m Doing backup of: $pl \e[0m"
        pl_path="$jenkins_home/plugins/$pl/META-INF/MANIFEST.MF"
        
        dir_name=$(grep -i "Implementation-Title" $pl_path | cut -d ":" -f 2 | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g' | awk '{$1=$1;print}')
        dir_version=$(grep -i "Plugin-Version" $pl_path | cut -d ":" -f 2-3 | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g' | awk '{$1=$1;print}')
        
        mkdir -p "$backuprepo/$dir_name/$dir_version"
        cp -f  "$jenkins_home/plugins/$pl.jpi" "$backuprepo/$dir_name/$dir_version/"
        t=$(date +%F-%H:%M)
        if [ $? -eq 0 ];then
          echo -e "\e[1;36m Backup successfully created: $backuprepo/$dir_name/$dir_version/$pl.jpi. Creating logs \e[0m"
          echo -e "Backup successfully created: $backuprepo/$dir_name/$dir_version/$pl.jpi. $t" >> ./logs/bkp_plugins_logs.log
        fi
      
      else
        echo -e "\e[1;31m WARNING: No .jpi file found for $pl, skipping backup \e[0m"
        echo -e "\WARNING: No .jpi file found for $pl, skipping backup $t" >> ./logs/bkp_plugins_logs.log
      fi

    else
      echo -e "No previous version found for $pl.jpi. $t" >> ./logs/bkp_plugins_logs.log
    fi
    
    echo -e "\e[1;36m Starting installation of: $pl\n Copying $plugin in $jenkins_home/plugins \e[0m"
    
    #Here we copy the plugin to Jenkins' plugins directory
    cp -f "$plugin" "$jenkins_home/plugins/$pl.jpi"
    if [ -f "$jenkins_home/plugins/$pl.jpi" ];then
      echo -e "\e[1;32m Plugin $pl successfully uploaded \e[0m"
      movependingtouploaded "$plugin"
    else
      echo -e "\e[1;31m Something went wrong with the $pl plugin, please check it \e[0m"
    fi
  
  done
  
  
  echo -e "\e[1;32m Starting jenkins....\e[0m"  
  java -jar ~/Personal/jenkinswork/warfiles/jenkins-2-479-2.war >./logs/starting-jenkins.log 2>&1 & disown
  sleep 5
  
}


movependingtouploaded(){

  mkdir -p ./pluginsdata/uploadedplugins
  mv "$1" ./pluginsdata/uploadedplugins

}

stopifrunning(){
  export stopped=false
  #jenkinspid=$(ps -aux  | grep -E 'java.*jenkins.*\.war' | grep -vi 'grep' | awk '{print $2}')
  jenkinspid=$(pgrep -f 'java.*jenkins.*\.war' | head -n1)
  if [ -z "$jenkinspid" ];then
    echo -e "\e[1;32m Jenkins pid $jenkinspid is null, jenkins is not running \e[0m "
  else 
    echo -e "\e[1;32m jenkins pid $jenkinspid \e[0m \n\e[1;31mSTOPPING JENKINS.....\e[0m\n"
    kill $jenkinspid
    sleep 5
    stopped=true
  fi
}