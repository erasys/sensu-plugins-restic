# sensu-plugins-restic

[![Build Status](https://travis-ci.org/erasys/sensu-plugins-restic.svg?branch=master)](https://travis-ci.org/erasys/sensu-plugins-restic)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-restic.svg)](http://badge.fury.io/rb/sensu-plugins-restic)
[![Dependency Status](https://gemnasium.com/erasys/sensu-plugins-restic.svg)](https://gemnasium.com/erasys/sensu-plugins-restic)
[![Community Slack](https://slack.sensu.io/badge.svg)](https://slack.sensu.io/badge)

## Functionality

## Files

* bin/check-restic-snapshot.rb

## Usage

### check-restic-snapshot

Checks the presence and the age of the latest restic backup snapshot.

By default it expects the restic binary to be installed at `/usr/bin/restic`. Repository location and password are passed into the check
through the environment variables `$RESTIC_REPOSITORY` and `$RESTIC_PASSWORD_FILE`. Please check the
[restic documentation](https://restic.readthedocs.io/en/latest/manual_rest.html) for details.

This example checks the repository configured through the environment variables mentioned before. It warns if the last backup is older
than 1 day + 1 hour, and becomes critical after 2 days + 1 hour:

```
check-restic-snapshot.rb -w 90000 -c 176400
```

If your restic binary is in a different location and/or you prefer to pass repository location and password via parameters, use the `-p`
option to specify how the restic binary is invoked:

```
check-restic-snapshot.rb -w 90000 -c 176400 -p '/opt/bin/restic -r /mnt/backups -p /etc/restic/password'
```

The `--missing-status` allows you to specify the check's result if no backup has been created so far (defaults to `critical`).

```
check-restic-snapshot.rb -w 90000 -c 176400 --missing-status warning
```

## Installation

[Installation and Setup](http://sensu-plugins.io/docs/installation_instructions.html)

## Notes
