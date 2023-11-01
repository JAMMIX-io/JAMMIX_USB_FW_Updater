#/bin/bash  
#JAMMIX Updater 20231031 - This script aids in updating the firmware for JAMMIX

#set -e

echo "Please state if your JAMMIX uses a F401 or F407 chip."
echo "Pictures to determine your chip can be seen at https://github.com/JAMMIX-io/JAMMIX_USB_FW_Updater."  
echo "" 

mkdir -p /media/fat/JAMMIX_FW
cd /media/fat/JAMMIX_FW

while true; do
    echo "Please choose an option:"
    echo "1. F401"
    echo "2. F407"
    
    read -p "Enter 1 or 2: " choice

    case $choice in
        1)
            echo "You selected Option 1 F401."
            # Place any additional commands you want to run for Option 1 here.
            rm hid-flash
            wget --no-check-certificate https://github.com/JAMMIX-io/JAMMIX_USB_FW_Updater/raw/main/hid-flash
            BIN=`wget -q -O - https://github.com/JAMMIX-io/JAMMIX_USB_FW_Updater | grep JAMMIX_F401 | sed 's/<[^>]*>//g'| sort | tail -1`
			rm ${BIN// /}*
            wget --no-check-certificate https://github.com/JAMMIX-io/JAMMIX_USB_FW_Updater/raw/main/${BIN// /}
            ;;
        2)
            echo "You selected Option 2 F407."
            # Place any additional commands you want to run for Option 2 here.
            rm hid-flash
            wget --no-check-certificate https://github.com/JAMMIX-io/JAMMIX_USB_FW_Updater/raw/main/hid-flash
            BIN=`wget -q -O - https://github.com/JAMMIX-io/JAMMIX_USB_FW_Updater | grep JAMMIX_F407 | sed 's/<[^>]*>//g' | sort | tail -1`
			rm ${BIN// /}*
            wget --no-check-certificate https://github.com/JAMMIX-io/JAMMIX_USB_FW_Updater/raw/main/${BIN// /}
            ;;
        *)
            echo "Invalid input. Please enter 1 or 2."
            ;;
    esac

clear
echo ""
echo "Please set DIP 6 to ON, then..."
echo ""
echo "Rev2 boards: Momentarily press the STM32_RESET button."
echo ""
echo "Rev1 boards: Momentarily short the PROG header pins 1 and 3."
echo "(see the rev1 User Guide for help)"
echo ""

read -p "Do you want to flash JAMMIX (Y/N)? " response

case $response in
    [yY])
        echo "Flashing"
        # Replace 'your-command-here with the command you want to run.
        /media/fat/JAMMIX_FW/hid-flash /media/fat/JAMMIX_FW/${BIN// /} usb
		echo ""
		echo "If you see the 'Done!' message above, the firmware update succeeded."
		echo ""
		echo "Please set DIP 6 to OFF, then fully power-cycle your JAMMIX."
		echo ""
		read -p "" TEST
        ;;
    [nN])
        echo "Exiting, please re-run this script if you want to flash JAMMIX."
        exit
        ;;
    *)
        echo "Invalid response. Please enter Y or N."
        ;;
esac


done
