{% target = pillar.get('target','master-mom') %}
{% target_type = pillar.get('target_type','glob') %}

fileserver_update:
  salt.runner:
    - name: state.orch
    - mods: orch.sys.salt.update

mysql_install_1:
  salt.state:
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: 
      - sys.install.mysql

mysql_redhat_password_fix:
  salt.state:
    - tgt: 'master-mom'
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: 
      - sys.other.mysql.rh_root

mysql_users:
  salt.state:
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: 
      - sys.other.mysql.users

mysql_databases:
  salt.state:
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: 
      - sys.other.mysql.databases

dyn_top_install:
  salt.state:
    - tgt: 'master-mom'
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls:
      - sys.top.mysql
