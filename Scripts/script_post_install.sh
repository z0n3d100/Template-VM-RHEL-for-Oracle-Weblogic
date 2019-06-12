#!/bin/bash
#
# Description:
#
#
#

# Packages i386 arch
yum -y install binutils.i686 compat-libcap1.i686 compat-libstdc++.i686 gcc-c++.i686 glibc.i686 glibc-devel.i686 glibc.i686 libX11.i686 libXau.i686 libXext.i686 libXi.i686 libXtst.i686 libaio.i686 libaio-devel.i686 libgcc.i686 libstdc++.i686 libstdc++-devel.i686 libxcb.i686 motif-devel.i686 nss-softokn-freebl.i686 numactl-devel.i686 numactl.i686

# Package for X Window
yum -y groupinstall "X Window System"

# Packages x86_64 arch
yum -y install aide binutils.x86_64 chrony compat-libcap1.x86_64 compat-libstdc++.x86_64 dejavu-serif-fonts device-mapper-multipath gcc-c++.x86_64 gdm glibc-devel.x86_64 glibc.x86_64 ksh ksh-20120801-26.el7.x86_64 libX11.x86_64 libXau.x86_64 libXaw.x86_64 libXi.x86_64 libXtst.x86_64 libaio-devel.x86_64 libaio.x86_64 libgcc.x86_64 libstdc++-devel.x86_64 libstdc++.x86_64 libxcb.x86_64 m4 make.x86_64 motif motif-devel motif-devel.x86_64 net-tools.x86_64 nfs-utils.x86_64 ntp numactl-devel.x86_64 numactl.x86_64 sg3_utils smartmontools.x86_64 sysstat.x86_64 xauth xhost xorg-x11*

# Package update
yum -y update

# Step : Configuration Services
systemctl enable ntpd
systemctl disable firewalld
systemctl enable rsyslogd
systemctl enable auditd
systemctl enable crond
systemctl enable chronyd
systemctl enable gdm

# Step : Banner 
echo "**************************************************************************" >>/etc/motd
echo "* Este sistema es para uso exclusivo de personal autorizado.Si Ud.       *" >>/etc/motd
echo "* no es un usuario autorizado por favor proceda con la desconexion       *" >>/etc/motd
echo "* inmediata. Todas sus actividades estan monitoreadas y seran            *" >>/etc/motd
echo "* registradas. Igualmente seran susceptibles de monitoreo y registro     *" >>/etc/motd
echo "* aquellas actividades de usuarios autorizados o de mantenimiento        *" >>/etc/motd
echo "* del sistema. Cualquiera que acceda y use este sistema, expresamente    *" >>/etc/motd
echo "* consiente y autoriza el hecho de ser monitoreado y que sus actividades *" >>/etc/motd
echo "* sean registradas. Quien haga uso de este sistema sin autorizacion      *" >>/etc/motd
echo "* expresa o abuse de sus privilegios, sus registros de actividad podran  *" >>/etc/motd
echo "* ser usados como evidencia para que se tomen las acciones legales o     *" >>/etc/motd
echo "* laborales del caso.                                                    *" >>/etc/motd
echo "**************************************************************************" >>/etc/motd

# Step : Hosts/IPs
echo "127.30.30.1 	nombre_maquina.claro.com.co 	nombre_maquina" >> /etc/hosts

# Step : Limits
echo "oracle soft  nofile  4096">> /etc/security/limits.d/oracle.conf
echo "oracle hard  nofile  65536">> /etc/security/limits.d/oracle.conf
echo "oracle soft  nproc   2047">> /etc/security/limits.d/oracle.conf
echo "oracle hard  nproc   16384">> /etc/security/limits.d/oracle.conf

# Step : System Configuration
echo "# Controls the maximum shared segment size, in bytes" >> /etc/sysctl.conf
echo "kernel.shmmax = 68719476736" >> /etc/sysctl.conf
echo "# Controls the maximum number of shared memory segments, in pages" >> /etc/sysctl.conf
echo "kernel.shmall = 12542081024" >> /etc/sysctl.conf
echo "kernel.sem = 250 32000 100 128" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 9000 65500" >> /etc/sysctl.conf
echo "net.core.rmem_default = 4194304" >> /etc/sysctl.conf
echo "net.core.rmem_max = 4194304" >> /etc/sysctl.conf
echo "net.core.wmem_default = 262144" >> /etc/sysctl.conf
echo "net.core.rmem_default = 262144" >> /etc/sysctl.conf
echo "net.core.wmem_max = 1048576" >> /etc/sysctl.conf
echo "fs.aio-max-nr = 6815744" >> /etc/sysctl.conf
echo "# Recommended value for kernel.shmmni" >> /etc/sysctl.conf
echo "kernel.shmmni = 4096" >> /etc/sysctl.conf
echo "# Recommended value for fs.file-max" >> /etc/sysctl.conf
echo "fs.file-max = 6815744" >> /etc/sysctl.conf
echo "# Recommended value for kernel.panic_on_oops" >> /etc/sysctl.conf
echo "kernel.panic_on_oops = 1" >> /etc/sysctl.conf
sysctl --system

# Step : Filesystems
# /etc/fstab
# CIS 1.1.6 + 1.1.14-1.1.16
cat << EOF >> /etc/fstab
/tmp      /var/tmp    none    bind,nosuid,nodev,noexec    0 0
none      /dev/shm/  tmpfs  nosuid,nodev,noexec      0 0
EOF

# Step : Kernel modules
echo "install udf /bin/true">>/etc/modprobe.d/udf.conf
echo "install vfat /bin/true">>/etc/modprobe.d/vfat.conf
echo "install cramfs /bin/true">>/etc/modprobe.d/cramfs.conf
echo "install freevxfs /bin/true">>/etc/modprobe.d/freevxfs.conf
echo "install jffs2 /bin/true">>/etc/modprobe.d/jffs2.conf
echo "install hfs /bin/true">>/etc/modprobe.d/hfs.conf
echo "install hfsplus /bin/true">>/etc/modprobe.d/hfsplus.conf
echo "install squashfs /bin/true">>/etc/modprobe.d/squashfs.conf
echo "install dccp /bin/true">>/etc/modprobe.d/dccp.conf
echo "install sctp /bin/true">>/etc/modprobe.d/sctp.conf
echo "install rds /bin/true">>/etc/modprobe.d/rds.conf
echo "install tipc /bin/true">>/etc/modprobe.d/tipc.conf

# Step: SSHD Configuration

mv /etc/ssh/sshd_config /etc/ssh/sshd_config.orig

cat << SSHD_FILE >> /etc/ssh/sshd_config
cat << EOF
#       $OpenBSD: sshd_config,v 1.93 2014/01/10 05:59:19 djm Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/local/bin:/usr/bin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

# If you want to change the port on a SELinux system, you have to tell
# SELinux about this change.
# semanage port -a -t ssh_port_t -p tcp #PORTNUMBER
#
#Port 22
AddressFamily inet
#ListenAddress 0.0.0.0
#ListenAddress ::

# The default requires explicit activation of protocol 1
Protocol 2

# HostKey for protocol version 1
#HostKey /etc/ssh/ssh_host_key
# HostKeys for protocol version 2
HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

# Lifetime and size of ephemeral version 1 server key
#KeyRegenerationInterval 1h
#ServerKeyBits 1024

# Ciphers and keying
Ciphers aes256-ctr,aes192-ctr,aes128-ctr
#RekeyLimit default none

# Logging
# obsoletes QuietMode and FascistLogging
#SyslogFacility AUTH
SyslogFacility AUTHPRIV
LogLevel INFO

# Authentication:

#LoginGraceTime 2m
PermitRootLogin yes
#StrictModes yes
MaxAuthTries 4
#MaxSessions 10

#RSAAuthentication yes
#PubkeyAuthentication yes

# The default is to check both .ssh/authorized_keys and .ssh/authorized_keys2
# but this is overridden so installations will only check .ssh/authorized_keys
AuthorizedKeysFile      .ssh/authorized_keys

#AuthorizedPrincipalsFile none

#AuthorizedKeysCommand none
#AuthorizedKeysCommandUser nobody

# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
#RhostsRSAAuthentication no
# similar for protocol version 2
HostbasedAuthentication no
# Change to yes if you don't trust ~/.ssh/known_hosts for
# RhostsRSAAuthentication and HostbasedAuthentication
#IgnoreUserKnownHosts no
# Don't read the user's ~/.rhosts and ~/.shosts files
IgnoreRhosts yes

# To disable tunneled clear text passwords, change to no here!
#PasswordAuthentication yes
PermitEmptyPasswords no
PasswordAuthentication yes

# Change to no to disable s/key passwords
#ChallengeResponseAuthentication yes
ChallengeResponseAuthentication no

# Kerberos options
#KerberosAuthentication no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes
#KerberosGetAFSToken no
#KerberosUseKuserok yes

# GSSAPI options
GSSAPIAuthentication yes
GSSAPICleanupCredentials no
#GSSAPIStrictAcceptorCheck yes
#GSSAPIKeyExchange no
#GSSAPIEnablek5users no

# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication.  Depending on your PAM configuration,
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of "PermitRootLogin without-password".
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication
# and ChallengeResponseAuthentication to 'no'.
# WARNING: 'UsePAM no' is not supported in Red Hat Enterprise Linux and may cause several
# problems.
UsePAM yes

#AllowAgentForwarding yes
AllowTcpForwarding yes
#GatewayPorts no
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes
#PermitTTY yes
#PrintMotd yes
#PrintLastLog yes
#TCPKeepAlive yes
#UseLogin no
UsePrivilegeSeparation sandbox          # Default for new installations.
PermitUserEnvironment no
#Compression delayed
#ClientAliveInterval 0
#ClientAliveCountMax 3
#ShowPatchLevel no
#UseDNS yes
#PidFile /var/run/sshd.pid
#MaxStartups 10:30:100
#PermitTunnel no
#ChrootDirectory none
#VersionAddendum none

# no default banner path
Banner /etc/issue.net

# Accept locale-related environment variables
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS

# override default of no subsystems
Subsystem       sftp    /usr/libexec/openssh/sftp-server

# Example of overriding settings on a per-user basis
#Match User anoncvs
#       X11Forwarding no
#       AllowTcpForwarding no
#       PermitTTY no
#       ForceCommand cvs server
#MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
LoginGraceTime 30
EOF
SSHD_FILE

# Step : GRUB
# Set bootloader password# CIS 1.5.3
cat << EOF2 >> /etc/grub.d/01_users
cat << EOF
set superusers="bootuser"
password_pbkdf2 bootuser
grub.pbkdf2.sha512.10000.A1180A3500F3BE6B40DB6E5BF47E79D42968854564611369CEBAAA6EAE8A2ACF0AF66B06D7D86531B20D7272CCC1C17D5983D3357FBCEAC0CCC78E5CCE095A9F.C1B9D0862657CC3CEAEE5171E55D2D4CFE3036B5F18A27C3E28B57FF0A0BD1C579F5DAD6268A4FAB1DA8713D937C15015037DBD5FEDAA0514E84F3AD562B03D4
EOF
EOF2

