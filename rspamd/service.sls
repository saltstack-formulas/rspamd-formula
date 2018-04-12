# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rspamd/map.jinja" import rspamd with context %}

rspamd_service:
  service.running:
    - name: {{ rspamd.service.name }}
    - enable: true
