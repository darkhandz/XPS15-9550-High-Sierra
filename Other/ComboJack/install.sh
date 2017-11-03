#!/bin/bash
sudo cp ComboJack /usr/bin
sudo chmod 755 /usr/bin/ComboJack
sudo chown root:wheel /usr/bin/ComboJack
sudo cp hda-verb /usr/bin
sudo chmod 755 /usr/bin/hda-verb
sudo chown root:wheel /usr/bin/hda-verb
sudo cp com.XPS.ComboJack.plist /Library/LaunchAgents/
sudo chmod 644 /Library/LaunchAgents/com.XPS.ComboJack.plist
sudo chown root:wheel /Library/LaunchAgents/com.XPS.ComboJack.plist
sudo launchctl load /Library/LaunchAgents/com.XPS.ComboJack.plist
echo
echo "Please reboot! Also, it may be a good idea to turn off \"Use"
echo "ambient noise reduction\" when using an input method other than"
echo "the internal mic (meaning line-in, headset mic). As always: YMMV."
echo
echo "You can check to see if the watcher is working in the IORegistry:"
echo "there should be a device named \"VerbStubUserClient\" attached to"
echo "\"com_XPS_SetVerb\" somewhere within the \"HDEF\" entry's hierarchy."
echo
echo "Enjoy!"
echo
exit 0
