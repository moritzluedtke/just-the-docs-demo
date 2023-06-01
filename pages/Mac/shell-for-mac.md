# Shell Scripts for Macintosh

## Toggle awdl0 Interface on/off
```shell
#!/bin/bash
interface="awdl0"
awdlstatus=$(ifconfig awdl0| fgrep status | cut -d: -f2 | sed 's/[[:space:]]*//g')
echo "awdl0 status was: $awdlstatus"

if [[ "active" == $awdlstatus ]]; then
	sudo ifconfig $interface down
else
	sudo ifconfig $interface up
fi

awdlstatus=$(ifconfig awdl0| fgrep status | cut -d: -f2 | sed 's/[[:space:]]*//g')
echo "awdl0 is now: $awdlstatus"
```
