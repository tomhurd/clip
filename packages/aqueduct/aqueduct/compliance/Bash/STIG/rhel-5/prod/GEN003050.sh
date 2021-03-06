#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.
##########################################################################

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-22385
# Group Title: GEN003050
# Rule ID: SV-37400r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003050
# Rule Title: Crontab files must be group-owned by root, cron, or the 
# crontab creator's primary group.
#
# Vulnerability Discussion: To protect the integrity of scheduled system 
# jobs and prevent malicious modification to these jobs, crontab files must 
# be secured.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the crontab files.
# Procedure:

# ls -lL /var/spool/cron

# ls -lL /etc/cron.d /etc/crontab /etc/cron.daily /etc/cron.hourly 
# /etc/cron.monthly /etc/cron.weekly
# or 
# ls -lL /etc/cron*|grep -v deny

# If the group owner is not root or the crontab owner's primary group, this 
# is a finding.
#
# Fix Text: 
#
# Change the group owner of the crontab file to root, cron, or the 
# crontab's primary group.
# Procedure:
# chgrp root [crontab file]   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003050
	
# Start-Lockdown
find /etc/cron.hourly /etc/cron.daily /etc/cron.weekly /etc/cron.monthly /etc/cron.d /etc/crontab /etc/cron.allow ! -group root -type f -exec chgrp root {} \; > /dev/null

# Make sure user crons are owned by the user or root
for USERCRON in `find /var/spool/cron -type f`
do
  USERNAME=`basename $USERCRON`
  GROUPNAME=`id -g -n $USERNAME`
  find $USERCRON -type f ! -group $GROUPNAME ! -group root -exec chgrp $GROUPNAME {} \;
done

