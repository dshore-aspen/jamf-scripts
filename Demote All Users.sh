#!/bin/bash

# Use $4 for your standard admin user account
excluded_user="$4"
local_admins=`dscl . read /Groups/admin GroupMembership | cut -d " " -f 2-`

function delete_admin_user
{
        while [ $# -gt 0 ]
        do
                case $1 in

                        root)
                                echo "$1 user"
                                ;;
                        $excluded_user)
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