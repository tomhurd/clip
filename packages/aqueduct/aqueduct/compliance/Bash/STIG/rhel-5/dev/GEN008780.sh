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
# Group ID (Vulid): V-22587
# Group Title: GEN008780
# Rule ID: SV-26988r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN008780
# Rule Title: The system's boot loader configuration file(s) must be 
# group-owned by root, bin, sys, or system.
#
# Vulnerability Discussion: The system's boot loader configuration files 
# are critical to the integrity of the system and must be protected.  
# Unauthorized modifications resulting from improper group ownership may 
# compromise the boot loader configuration.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the group ownership of the file.
# ls -lLd /boot/grub/grub.conf
# If the group-owner of the file is not root, bin, sys, or system this is a 
# finding.

#
# Fix Text: 
#
# Change the group ownership of the file.
# chgrp root /boot/grub/grub.conf    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008780
	
# Start-Lockdown

