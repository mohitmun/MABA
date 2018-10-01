#!/usr/bin/env bash

notify(){
  osascript -e "display notification \"$2\" with title \"$1\""
}

stop_hogging_processes(){

  frontApp=$(osascript frontapp.osascript)

  if [ "$frontApp" != "Google Chrome" ] && [ -z $chrome_stopped ];then
    notify "Stopping google chrome"
    killall -STOP "Google Chrome"
    export chrome_stopped=true
    unset chrome_continued
  fi

  if [ "$frontApp" = "Google Chrome" ] && [ -z $chrome_continued ];then
    notify "Continue google chrome"
    killall -CONT "Google Chrome"
    export chrome_continued=true
    unset chrome_stopped
  fi
# generic ijmplementation
#stop_hogging_processes(){
  #export_osascript_system_status
  #for app in ${battery_hogging_apps[@]}; do
    #if [ "$frontApp" != $app ] ;then
      #notify "Stopping $app"
      #stop $app
      ##export stopped_$app=true
      ##unset continued_$app
    #fi

    #if [ "$frontApp" = $app ] ;then
      #notify "Continue $app"
      #cont $app
      ##export continued_$app=true
      ##unset stopped_$app
    #fi
  #done
#}
}

while true;do
  sleep 3
  stop_hogging_processes
  #volume_level=`osascript -e "output volume of (get volume settings)"`
done
