{% target = salt.pillar.get('target','master-mom') %}
{% target_type = salt.pillar.get('target_type','glob') %}

fileserver_update:
  salt.runner:
    - name: state.orch
    - mods: orch.sys.salt.update

mysql_install_1:
  salt.state:
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: 
      - sys.remove.mysql
