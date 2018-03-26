do_highstate:
  salt.state:
    - tgt: {{ salt.pillar.get('target')}}
    - highstate: True
