#!/bin/sh
#
# Update the nameserver cache information file once per month.
# This is run automatically by a cron entry.
#
# Original by Al Longyear
# Updated for BIND 8 by Nicolai Langfeldt
# Miscelanious error-conditions reported by David A. Ranch
# Ping test suggested by Martin Foster
# named up-test suggested by Erik Bryer.
#
(
 echo "To: hostmaster <hostmaster>"
 echo "From: system <root>"

 # Is named up? Check the status of named.
 case `rndc status 2>&1` in
    *refused*)
        echo "named is DOWN. named.ca was NOT updated"
        echo
        exit 0
        ;;
 esac

 PATH=/sbin:/usr/sbin:/bin:/usr/bin:
 export PATH
 # NOTE: /var/named must be writable only by trusted users or this script 
 # will cause root compromise/denial of service opportunities.
 cd /var/named 2>/dev/null || {
    echo "Subject: Cannot cd to /var/named, error $?"
    echo
    echo "The subject says it all"
    exit 1
 }

 # Are we online?  Ping a server at your ISP
 case `ping -qnc 1 some.machine.net 2>&1` in
   *'100% packet loss'*)
        echo "Subject: named.ca NOT updated.  The network is DOWN."
        echo
        echo "The subject says it all"
        exit 1
        ;;
 esac

 dig @e.root-servers.net . ns >named.ca.new 2> errors

 case `cat named.ca.new` in
   *NOERROR*)
        # It worked
        :;;
   *)
        echo "Subject: The named.ca file update has FAILED."
        echo
        echo "The named.ca update has failed"
        echo "This is the dig output reported:"
        echo
        cat named.ca.new errors
        exit 1
        ;;
 esac

 echo "Subject: The named.ca file has been updated"
 echo
 echo "The named.ca file has been updated to contain the following   
information:"
 echo
 cat named.ca.new

 chown root.root named.ca.new
 chmod 444 named.ca.new
 rm -f named.ca.old errors
 mv named.ca named.ca.old
 mv named.ca.new named.ca
 rndc reload
 echo
 echo "The nameserver has been restarted to ensure that the update is complete."
 echo "The previous named.ca file is now called   
/var/named/named.ca.old."
) 2>&1 >> /var/log/named/named.ca.log
exit 0
