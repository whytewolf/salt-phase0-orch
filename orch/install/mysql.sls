fileserver_update:
  salt.runner:
    - name: state.orch
    - mods: orch.sys.salt.update

mysql_install_1:
  salt.state:
    - tgt: 'master-mom'
    - sls: 
      - sys.install.mysql

mysql_redhat_password_fix:
  salt.state:
    - tgt: 'master-mom'
    - sls: 
      - sys.other.mysql.rh_root

mysql_users:
  salt.state:
    - tgt: 'master-mom'
    - sls: 
      - sys.other.mysql.users

mysql_databases:
  salt.state:
    - tgt: 'master-mom'
    - sls: 
      - sys.other..mysql.databases

dyn_top_install:
  salt.state:
    - tgt: 'master-mom'
    - sls:
      - sys.top.mysql
