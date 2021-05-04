# -*- coding: utf-8 -*-
# vim: ft=sls

{%- from "rspamd/map.jinja" import rspamd with context %}

{%- for type, files in rspamd.config.items() %}
  {%- for file, params in files.items() %}
    {%- if file == 'rspamd' %}
      {%- set filename = rspamd.base_dir ~ '/rspamd.conf.' ~ type %}
    {%- else %}
      {%- set ext = 'conf' if (params.module is defined and params.module == true) else 'inc' %}
      {%- set filename = rspamd.base_dir ~ '/' ~ type ~ '.d/' ~ file ~ '.' ~ ext %}
    {%- endif %}

    {# If `manage_dkim_keys: true` #}
    {%- if file == 'dkim_signing' and rspamd.manage_dkim_keys %}

      {# add a domain entry in the dkim_signing dict if it does not exist #}
      {%- do params.update({'domain': {} }) if params.domain is not defined %}

      {%- for dom, domp in rspamd.dkim_keys.items() %}
        {%- set domain = domp.domain | default(dom) %}

        {# enable is default for domains, so if the parameter is undefined,
           it means we consider it true #}
        {%- if domp.enable | default(true) %}
          {%- set privkey_file = domp.privkey_file | default( rspamd.dkim_keys_dir ~ '/' ~ domain ~ '.key') %}
          {%- set selector = domp.selector | default(domain) %}

          {# add the domain to the domains dict if it does not exist #}
          {%- do params.domain.update({domain: {} }) if params.domain[domain] is not defined %}

          {# update the selector and file for the domain #}
          {%- do params.domain[domain].update({'path': privkey_file }) %}
          {%- do params.domain[domain].update({'selector': selector}) if params.domain[domain]['selector'] is not defined %}
        {%- else %}
          {%- do params.domain.pop(domain) if params.domain[domain] is defined %}
        {%- endif %}
      {%- endfor %}
    {%- endif %}

    {%- set enabled = false if (params == {} or (params.enable is defined and params.enable == false)) else true %}
{{ filename }}:
  {%- if enabled %}
  file.managed:
    - source: salt://rspamd/templates/config.jinja
    - template: jinja
    - makedirs: true
    - context:
        data: {{ params|json }}
  {%- else %}
  file.absent:
  {%- endif %}
    - require:
      - pkg: rspamd_pkg
    - require_in:
      - service: rspamd_service
    - watch_in:
      - service: rspamd_service
  {%- endfor %}
{%- endfor %}
