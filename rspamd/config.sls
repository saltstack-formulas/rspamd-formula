# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rspamd/map.jinja" import rspamd with context %}

{% for type, files in rspamd.config.items() %}
  {% for file, params in files.items() %}
    {% if file == 'rspamd' %}
      {% set filename = rspamd.base_dir ~ '/rspamd.conf.' ~ type %}
    {% else %}
      {% set ext = 'conf' if (params.module is defined and params.module == true) else 'inc' %}
      {% set filename = rspamd.base_dir ~ '/' ~ type ~ '.d/' ~ file ~ '.' ~ ext %}
    {% endif %}

    {% set enabled = false if (params == {} or (params.enable is defined and params.enable == false)) else true %}
{{ filename }}:
  {% if enabled %}
  file.managed:
    - source: salt://rspamd/templates/config.jinja
    - template: jinja
    - context:
        data: {{ params|json }}
  {% else %}
  file.absent:
  {% endif %}
    - require:
      - pkg: rspamd_pkg
    - require_in:
      - service: rspamd_service
    - watch_in:
      - service: rspamd_service
  {% endfor %}
{% endfor %}
