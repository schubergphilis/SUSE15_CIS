Linux CIS - Supports SUSE15, openSUSE42.3 ![](https://travis-ci.org/schubergphilis/SUSE15_CIS.svg?branch=main)
================
Inspired on the exellent work done by the MindPointGroup.

Configure SUSE15/OpenSUSE15.2 machine to be [CIS](https://www.cisecurity.org/cis-benchmarks/) compliant. Level 1 and 2 findings will be corrected by default.

## Warning on use

This role **will make changes to the system** that could break things. This is not an auditing tool but rather a remediation tool to be used after an audit has been conducted.

## IMPORTANT INSTALL STEP

If you want to install this via the `ansible-galaxy` command you'll need to run it like this:

`ansible-galaxy install -p roles -r requirements.yml`

With this in the file requirements.yml:

```
- src: https://github.com/schubergphilis/SUSE15_CIS.git
```

Based on [ CIS SUSE Linux Enterprise 15 Benchmark v1.0.0 - 06-30-2020 ](https://community.cisecurity.org/collab/public/index.php).

Requirements
------------

You should carefully read through the tasks to make sure these changes will not break your systems before running this playbook.
If you want to do a dry run without changing anything, set the below sections (suse15cis_section1-6) to false. 

Role Variables
--------------
There are many role variables defined in defaults/main.yml. This list shows the most important.

**suse15cis_section1**: CIS - General Settings (Section 1) (Default: true)

**suse15cis_section2**: CIS - Services settings (Section 2) (Default: true)

**suse15cis_section3**: CIS - Network settings (Section 3) (Default: true)

**suse15cis_section4**: CIS - Logging and Auditing settings (Section 4) (Default: true)

**suse15cis_section5**: CIS - Access, Authentication and Authorization settings (Section 5) (Default: true)

**suse15cis_section6**: CIS - System Maintenance settings (Section 6) (Default: true)  

##### Service variables:
###### These control whether a server should or should not be allowed to continue to run these services

```
suse15cis_avahi_server: false  
suse15cis_cups_server: false  
suse15cis_dhcp_server: false  
suse15cis_ldap_server: false  
suse15cis_telnet_server: false  
suse15cis_nfs_server: false  
suse15cis_rpc_server: false  
suse15cis_ntalk_server: false  
suse15cis_rsyncd_server: false  
suse15cis_tftp_server: false  
suse15cis_rsh_server: false  
suse15cis_nis_server: false  
suse15cis_snmp_server: false  
suse15cis_squid_server: false  
suse15cis_smb_server: false  
suse15cis_dovecot_server: false  
suse15cis_httpd_server: false  
suse15cis_vsftpd_server: false  
suse15cis_named_server: false  
suse15cis_bind: false  
suse15cis_vsftpd: false  
suse15cis_httpd: false  
suse15cis_dovecot: false  
suse15cis_samba: false  
suse15cis_squid: false  
suse15cis_net_snmp: false  
```  

##### Designate server as a Mail server
`suse15cis_is_mail_server: false`


##### System network parameters (host only OR host and router)
`suse15cis_is_router: false`  


##### IPv6 required
`suse15cis_ipv6_required: true`  


##### AIDE
`suse15cis_config_aide: true`

###### AIDE cron settings
```
suse15cis_aide_cron:
  cron_user: root
  cron_file: /etc/crontab
  aide_job: '/usr/sbin/aide --check'
  aide_minute: 0
  aide_hour: 5
  aide_day: '*'
  aide_month: '*'
  aide_weekday: '*'  
```

##### Set to 'true' if X Windows is needed in your environment
`suse15cis_xwindows_required: no` 


##### Client application requirements
```
suse15cis_openldap_clients_required: false 
suse15cis_telnet_required: false 
suse15cis_talk_required: false  
suse15cis_rsh_required: false 
suse15cis_ypbind_required: false 
```

##### Time Synchronization
```
suse15cis_time_synchronization: chrony

suse15cis_time_synchronization_servers:
    - 0.pool.ntp.org
    - 1.pool.ntp.org
    - 2.pool.ntp.org
    - 3.pool.ntp.org  
```  


```
suse15cis_firewall: firewalld
suse15cis_firewall: iptables
``` 
  

Dependencies
------------

Ansible > 2.9

Example Playbook
-------------------------

This sample playbook should be run in a folder that is above the main SUSE15_CIS folder.

```
- name: Harden Server
  hosts: servers
  become: yes

  roles:
    - SUSE15_CIS
```

Tags
----
Many tags are available for precise control of what is and is not changed.

Some examples of using tags:

```
    # Audit and patch the site
    ansible-playbook site.yml --tags="patch"
```

License
-------

MIT
