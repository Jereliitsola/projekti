# Firefox,libreoffice,tree sekä ssh asennus.

InstallPrograms:
  pkg.installed:
    - pkgs:
      - firefox-esr
      - libreoffice
      - tree
      - vlc
      - openssh-server
      
# LIBREOFFICE- ASETUKSET
# Templatejen valmiiksi asettaminen libreofficeen.

#/projekti/templates/ kansiion asetetut lisätään
# automaattisesti LibreOfficeen.

/usr/lib/libreoffice/share/template/common/presnt/:
  file.recurse:
    - source: salt://projekti/sshd_config
    
# SSHD- Asetukset

# CONFIG
/etc/ssh/sshd_config:
  file.managed:
    - source: salt://projekti/sshd_config
    
# TILA
sshd:
  service.running:
    - enable: True
    - watch:
      - file: /etc/ssh_sshd_config
      
# BANNER
/etc/ssh/banner:
  file.managed:
    - source: salt://projekti/banner.txt
