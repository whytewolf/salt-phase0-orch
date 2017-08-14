{% set target = salt.pillar.get('target','master-mom') %}
{% set target_type = salt.pillar.get('target_type','glob') %}

fileserver_update:
  salt.runner:
    - name: state.orch
    - mods: orch.sys.salt.update

mysql_install:
  salt.state:
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: sys.install.mysql

mysql_redhat_password_fix:
  salt.state:
    - tgt: 'master-mom'
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: sys.other.mysql.rh_root
    - require:
      - salt: mysql_install

mysql_users:
  salt.state:
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: sys.other.mysql.users
    - require:
      - salt: mysql_redhat_password_fix

mysql_databases:
  salt.state:
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: sys.other.mysql.databases
    - require: 
      - salt: mysql_redhat_password_fix

dyn_top_install:
  salt.state:
    - tgt: 'master-mom'
    - tgt: {{target}}
    - tgt_type: {{target_type}}
    - sls: sys.top.mysql
    - require:
      - salt: mysql_install
      - salt: mysql_redhat_password_fix
      - salt: mysql_users
      - salt: mysql_databases
