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

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-915
# Group Title: GEN001560
# Rule ID: SV-37183r1_rule
# Severity: low
# Rule Version (STIG-ID): GEN001560
# Rule Title: All files and directories contained in user home 
# directories must have mode 0750 or less permissive.
#
# Vulnerability Discussion: Excessive permissions allow unauthorized 
# access to user files.

#
# Responsibility: Information Assurance Officer
# IAControls: ECLP-1
#
# Check Content:
#
# For each user in the /etc/passwd file, check for files and directories 
# with a mode more permissive than 0750.

# Procedure:
# find /<usershomedirectory> ! -fstype nfs ! \( -name .bashrc -o -name 
# .bash_login -o -name .bash_logout -o -name .bash_profile -o -name .cshrc 
# -o -name .kshrc -o -name .login -o -name .logout -o -name .profile -o 
# -name .tcshrc -o -name .env -o -name .dtprofile -o -name .dispatch -o 
# -name .emacs -o -name .exrc \) \( -perm -0001 -o -perm -0002 -o -perm 
# -0004 -o -perm -0020 -o -perm -2000 -o -perm -4000 \) -exec ls -ld {} \;

# If user home directories contain files or directories more permissive 
# than 0750, this is a finding.


#
# Fix Text: 
#
# Change the mode of files and directories within user home directories 
# to 0750.

# Procedure:
# chmod 0750 filename

# Document all changes.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001560
	
# Start-Lockdown

# So GEN000340 and GEN000360 should weed out non-system accounts being in the
# system and reserved account ranges from 0 to 499(0 to 999 in fedora 16). So 
# to keep from maintaining a massive list of accounts lets just check the user
# directories of accounts >= 500 minus nfsnobody. 

for USERNAME in `awk -F ':' '{if ($3 >= 500 && $3 != 65534)print $1}' /etc/passwd`
do
  USERHDIR=`egrep "^${USERNAME}" /etc/passwd | awk -F ':' '{print $6}'`
  if [ "$USERHDIR" != "/" ]
  then
    find $USERHDIR ! -fstype nfs -perm /7027 -exec chmod u-s,g-ws,o-rwxs {} \;
  fi
done
