#!/bin/bash

local_admins=`dscl . read /Groups/admin GroupMembership | cut -d " " -f 2-`
echo "$local_admins"

if [[ $local_admins != "root itsadmin" ]]; then
	echo "<RESULT>FAIL</RESULT>"
else
	echo "<RESULT>PASS</RESULT>"
fi
