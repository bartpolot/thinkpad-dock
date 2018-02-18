#!/bin/sh
export DISPLAY=:0

##########################################################################################
################################# Set VGA mode ###########################################
##########################################################################################
# 1440x900 59.89 Hz (CVT 1.30MA) hsync: 55.93 kHz; pclk: 106.50 MHz
#Modeline "1440x900_60.00"  106.50  1440 1528 1672 1904  900 903 909 934 -hsync +vsync
# 1920x1080 59.96 Hz (CVT 2.07M9) hsync: 67.16 kHz; pclk: 173.00 MHz
#Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
# 1920x1080 74.91 Hz (CVT 2.07M9) hsync: 84.64 kHz; pclk: 220.75 MHz
#Modeline "1920x1080_75.00"  220.75  1920 2064 2264 2608  1080 1083 1088 1130 -hsync +vsync

if ! xrandr | grep -q dock_1920x1080; then
    xrandr --newmode "dock_1920x1080"  173.25  1920 2048 2248 2576  1080 1083 1088 1121 -hsync +vsync
    xrandr --addmode VGA1 "dock_1920x1080"
    #xrandr --output VGA1 --mode 1920x1080 --pos 1440x0 --rotate left
    #xrandr --output LVDS1 --pos 0x1020 --primary
fi
xrandr --output VGA1 --mode "dock_1920x1080" --pos 0x0
xrandr --output LVDS1 --pos 0x1080 --primary

##########################################################################################
################################# Use proper conky config ################################
##########################################################################################
if ! ls -l ~/.conkyrc | grep -q VGA; then  
    ln -sf ~/.conkyrc.VGA ~/.conkyrc
    killall -USR1 conky;
fi

##########################################################################################
################################# Start synergy  #########################################
##########################################################################################
#killall -9 synergyc; synergyc server.localdomain
#killall -9 synergys; synergys