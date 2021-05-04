# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rspamd/map.jinja" import rspamd with context %}

{%-  if rspamd.manage_dkim_keys -%}
rspamd_dkim_keys_dir:
  file.directory:
    - name: {{ rspamd.dkim_keys_dir }}
    - user: {{ rspamd.user }}
    - group: {{ rspamd.group }}
    - mode: 755
    - clean: {{ rspamd.clean_dkim_keys_dir }}
    - require:
      - pkg: rspamd_pkg

  {%- for key, params in rspamd.dkim_keys.items() %}
    {%- set domain = params.domain | default(key) %}
    {%- set selector = params.selector | default(domain) %}
    {%- set privkey_file = params.privkey_file | default( rspamd.dkim_keys_dir ~ '/' ~ domain ~ '.key') %}
    {%- set txt_file = params.txt_file | default( rspamd.dkim_keys_dir ~ '/' ~ domain ~ '.txt') %}
    {%- set bits = params.bits | default(2048) %}
    {%- set type = params.type | default('rsa') %}
rspamd_dkim_keys_{{ key }}:
  cmd.run:
    - name: |
        mkdir -p {{ rspamd.dkim_keys_dir }} && \
        rspamadm dkim_keygen \
          --selector '{{ selector }}' \
          --bits {{ bits }} \
          --domain {{ domain }} \
          --privkey {{ privkey_file }} \
          > {{ txt_file }}
    - unless: test -f {{ txt_file }}
    - require_in:
      - file: rspamd_dkim_keys_{{ privkey_file }}_perms
      - file: rspamd_dkim_keys_{{ txt_file }}_perms
      - sls: config
      - service: rspamd_service

rspamd_dkim_keys_{{ privkey_file }}_perms:
  file.managed:
    - name: {{ privkey_file }}
    - user: {{ rspamd.user }}
    - group: {{ rspamd.group }}
    - mode: 640
    - onlyif: test -f {{ privkey_file }}
    - require_in:
      - file: rspamd_dkim_keys_dir

rspamd_dkim_keys_{{ txt_file }}_perms:
  file.managed:
    - name: {{ txt_file }}
    - user: {{ rspamd.user }}
    - group: {{ rspamd.group }}
    - mode: 640
    - onlyif: test -f {{ txt_file }}
    - require_in:
      - file: rspamd_dkim_keys_dir

  {%- endfor %}
{%- endif %}
