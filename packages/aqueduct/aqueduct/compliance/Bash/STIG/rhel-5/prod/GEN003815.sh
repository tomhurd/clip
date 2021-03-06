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
# Group ID (Vulid): V-22430
# Group Title: GEN003815
# Rule ID: SV-26666r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003815
# Rule Title: The portmap or rpcbind service must not be installed unless 
# needed.
#
# Vulnerability Discussion: The portmap and rpcbind services increase the 
# attack surface of the system and should only be used when needed.  The 
# portmap or rpcbind services are used by a variety of services using 
# Remote Procedure Calls (RPCs).
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check if the portmap package is installed.
# rpm -qa | grep portmap
# If a package is found, this is a finding.
#
# Fix Text: 
#
# Remove the portmap package.
# rpm -e portmap
# or 
# yum remove portmap  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003815
	
#Start-Lockdown
rpm -q portmap > /dev/null
if [ $? -eq 0 ]
then
  yum remove portmap -y 
fi
rpm -q rpcbind > /dev/null
if [ $? -eq 0 ]
then
  yum remove rpcbind -y 
fi
