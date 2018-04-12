# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rspamd/map.jinja" import rspamd with context %}

{% if rspamd.use_upstream_repo -%}
  {% if grains.os_family == 'Debian' -%}
rspamd_repo:
  pkgrepo.managed:
    - humanname: {{ rspamd.repo.humanname }}
    - name: {{ rspamd.repo.name }}
    - enabled: {{ rspamd.repo.enabled }}
    - file: {{ rspamd.repo.file }}
    - key_url: {{ rspamd.repo.key_url }}
    - require_in:
      - pkg: rspamd_pkg

  {%- elif grains.os_family == 'RedHat' %}
rspamd_repo:
  pkgrepo.managed:
    - humanname: {{ rspamd.repo.humanname }}
    - name: {{ rspamd.repo.name }}
    - file: {{ rspamd.repo.file }}
    - enabled: {{ rspamd.repo.enabled }}
    - baseurl: {{ rspamd.repo.baseurl }}
    - gpgcheck: {{ rspamd.repo.gpgcheck }}
    - gpgkey: {{ rspamd.repo.gpgkey }}
    - require_in:
      - pkg: rspamd_pkg

  {%- else %}
rspamd_repo: {}
  {%- endif %}
{%- endif %}

rspamd_pkg:
  pkg.installed:
    - name: {{ rspamd.pkg }}
    - require_in:
      - service: rspamd_service
    - watch_in:
      - service: rspamd_service

