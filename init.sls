# LibreOffice,tree,vlc sekä ssh asennus.

InstallPrograms:
  pkg.installed:
    - pkgs:
      - libreoffice
      - tree
      - vlc
      - openssh-server
      
# Google Chromen asentaminen Linux käyttöjärjestelmälle

google_chrome_repository:
  pkgrepo.managed:
    - humanname: Google Chrome
    - name: deb http://dl.google.com/linux/chrome/deb/ stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/chrome-browser.list
    - gpgcheck: 1
    - key_url: https://dl-ssl.google.com/linux/linux_signing_key.pub

google-chrome-stable:
  pkg.installed:
    - require:
      - pkgrepo: google_chrome_repository


# LIBREOFFICE- ASETUKSET
# Templatejen valmiiksi asettaminen libreofficeen.

/usr/lib/libreoffice/share/template/common/presnt/:
  file.recurse:
    - source: salt://projekti/templates/
    
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
