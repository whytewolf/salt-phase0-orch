do_highstate:
  salt.state:
    - tgt: '*'
    - highstate: True
