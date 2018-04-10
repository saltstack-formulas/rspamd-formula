# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rspamd/map.jinja" import rspamd with context %}

rspamd-config:
  file.managed:
    - name: {{ rspamd.config }}
    - source: salt://rspamd/files/example.tmpl
    - mode: 644
    - user: root
    - group: root
