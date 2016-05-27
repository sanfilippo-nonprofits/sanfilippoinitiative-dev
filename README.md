# Sanfilippo Initiative Development

* [Requirements](#requirements)
* [Site Maintenance](#site-maintenance)
  * [(Re)Configure](#)
  * [Backup and Restore](#backup-and-restore)




## Requirements

```
pip install ansible==2.0 boto
```




## Environments

There are 3 environments:
* Development - `dev` - http://dev.sanfilippoinititive.org  
  nothing is guaranteed to work here :).
* Staging - `stg` - http://stg.sanfilippoinititive.org  
  pre-production. Stable.
* Production - `prd` - http://sanfilippoinititive.org




## Site Maintenance


### (Re)Configure

If you want to update WP configuration run:

```BASH
make configure ROLE=sanfilippoinitiative ENV=dev
```


### Backup and Restore

To backup both code and DB run the following commands agains selected
environment (ENV)

```BASH
make playbook PLAYBOOK=support/backup.yml ENV=dev
```

To restore both code and DB to given version (backup_name) run the following
commands agains selected environment (ENV)

```BASH
make playbook PLAYBOOK=support/restore.yml ENV=dev \
  EXTRAS='-ebackup_name=2016.05.24.0001'
```
