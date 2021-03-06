#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
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

#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to check the service before disabling and stopping it.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-12010
#Group Title: Unencrypted FTP or Telnet
#Rule ID: SV-28636r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004800
#Rule Title: Unencrypted FTP must not be used on the system.
#
#Vulnerability Discussion: FTP is typically unencrypted and, therefore, presents confidentiality and integrity risks. FTP may be protected by encryption in certain cases, such as when used in a Kerberos environment. SFTP and FTPS are encrypted alternatives to FTP.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Perform the following to determine if unencrypted FTP or Telnet are enabled:
#
# chkconfig --list telnet
# chkconfig --list gssftp
# chkconfig --list vsftpd
#
#
#If either of these services are found, ask the SA if both of these services are encrypted. If they are not, this is a finding.
#
#Fix Text: Disable the Telnet and FTP daemons.
#
#Procedure:
# chkconfig telnet off
# chkconfig gssftp off
# chkconfig vsftpd off   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004800

#Start-Lockdown

for SERVICE in telnet gssftp vsftpd
do
  chkconfig --list $SERVICE 2> /dev/null | egrep 'on' > /dev/null
  if [ $? -eq 0 ]
  then
    chkconfig $SERVICE off
    if [ "$SERVICE" = 'vsftpd' ]
    then 
      service $SERVICE stop > /dev/null
    fi
  fi
done

