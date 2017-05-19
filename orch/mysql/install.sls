fileserver_update:
  salt.runner:
    - name: state.orch
    - mods: orch.sys.salt.update

mysql_install_1:
  salt.state:
    - tgt: 'master-mom'
    - sls: 
      - sys.mysql.installed

mysql_redhat_password_fix:
  salt.state:
    - tgt: 'master-mom'
    - sls: 
      - sys.mysql.redhat_root

mysql_users:
  salt.state:
    - tgt: 'master-mom'
    - sls: 
      - sys.mysql.users

mysql_databases:
  salt.state:
    - tgt: 'master-mom'
    - sls: 
      - sys.mysql.databases

dyn_top_install:
  salt.state:
    - tgt: 'master-mom'
    - sls:
      - sys.mysql.dyn_top
