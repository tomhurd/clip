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
# on 20-Feb-2012 to point to the correct config entry.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22569
#Group Title: GEN008260
#Rule ID: SV-26956r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN008260
#Rule Title: If the system is using LDAP for authentication or account information, the LDAP TLS certificate file must have mode 0644 or less permissive.
#
#Vulnerability Discussion: LDAP can be used to provide user authentication and account information, which are vital to system security. The LDAP client configuration must be protected from unauthorized modification.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Determine the certificate file.
# grep -i '^tls_cacert' /etc/ldap.conf
#Check the permissions.
# ls -lL <certpath>
#If the mode of the file is more permissive than 0644, this is a finding.
#
#Fix Text: Change the mode of the file.
# chmod 0644 <certpath>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN008260

[ -f /etc/ldap.conf ] || exit 0

#Start-Lockdown

# The STIG check should be tls_cert but they did a copy/paste error.
TLSCERTS=$(  grep -i '^tls_cert' /etc/ldap.conf | awk '{print $2}' ) 

for line in $TLSCERTS
  do
    if [ -a "$TLSCERTS" ]
      then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' $TLSCERTS`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7133)
        if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]
          then
            chmod u-xs,g-wxs,o-wxt $TLSCERTS
        fi
    fi
done

