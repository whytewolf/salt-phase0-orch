fileserver_update:
  salt.runner:
    - name: fileserver.update

master_sync_all:
  salt.runner:
    - name: saltutil.sync_all
    - require:
      - salt: fileserver_update

{% if 'git' in salt.saltutil.runner('config.get',arg=["ext_pillar"]) %}
git_pillar_update:
  salt.runner:
    - name: git_pillar.update
    - require:
      - salt: master_sync_all
    - require_in:
      - salt: pillar_refresh
{%endif%}

minion_sync_all:
  salt.function:
    - tgt: '*'
    - name: saltutil.sync_all
    - batch: '10%'
    - require:
      - salt: fileserver_update

pillar_refresh:
  salt.function:
    - tgt: '*'
    - name: saltutil.pillar_refresh
    - batch: '10%'

mine_update:
  salt.function:
    - tgt: '*'
    - name: mine.update
    - batch: '10%'
    - require:
      - salt: pillar_refresh

{# Do we have windows minions? #}
{% if salt.saltutil.runner('cache.grains',arg= ['os:Windows','grain'])|length > 0 %}
update_winrepo:
  salt.runner:
    - name: winrepo.update_git_repos

update_winrepo_databases:
  salt.function:
    - name: pkg.refresh_db
    - tgt: 'os:Windows'
    - tgt_type: grain
    - batch: '10%'
    - require:
      - salt: fileserver_update
      - salt: update_winrepo
{% endif %}
