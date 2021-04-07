#!/bin/bash

# Use $4 for your standard admin user account
# $4 should be your local admin account
# $5 should be your Jamf management account

local_admins=`dscl . read /Groups/admin GroupMembership | cut -d " " -f 2-`

function delete_admin_user
{
        while [ $# -gt 0 ]
        do
                case $1 in

                        root)
                                echo "$1 user"
                                ;;
                        $4)
                                echo "$1 intended admin"
                                ;;
                        $5)
                                echo "$1 intended admin"
                                ;;
                        *)
                                dseditgroup -o edit -d $1 admin
                                echo "$1 removed from admin group: "$?
                                ;;
                esac
                shift
        done
}

delete_admin_user $local_admins

exit 0