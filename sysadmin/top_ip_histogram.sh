#!/bin/bash

# Uses dos.awk to display a histogram of IPs appearing in the most recent 1000 log entries

# Once you identify the culprit, make sure it's not something important by doing a reverse
# DNS lookup:
# $ dig -x [IP address]
# Then you can block the IP using an iptables rule:
# # iptables -A INPUT -s [IP address] -j DROP

tail -n 1000 /var/log/apache2/dev.plone.org/access.log /var/log/apache2/deus.plone.org/access.log /var/log/apache2/dev.plone.org/access.log /var/log/apache2/paste.plone.org/access.log /var/log/apache2/planet.plone.org/access.log /var/log/apache2/svn.plone.org/access.log | awk -f dos.awk | sort -nrk3
