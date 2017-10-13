do_highstate:
  salt.state:
    - tgt: 'master-mom'
    - highstate: True
