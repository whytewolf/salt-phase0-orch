fileserver-update:
  salt.runner:
    - name: fileserver.update

master_sync_all:
  salt.runner:
    - name: saltutil.sync_all


git_pillar-update:
  salt.runner:
    - name: git_pillar.update

minion_sync_all:
  salt.function:
    - tgt: '*'
    - name: saltutil.sync_all
    - batch: '10%'

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
