# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rspamd/map.jinja" import rspamd with context %}

{% if rspamd.manage_redis -%}
rspamd_redis_service:
  service.running:
    - name: {{ rspamd.redis_service }}
    - enable: true
    - require_in:
      - service: rspamd_service
{% endif %}

rspamd_service:
  service.running:
    - name: {{ rspamd.service.name }}
    - enable: true
    - reload: true
