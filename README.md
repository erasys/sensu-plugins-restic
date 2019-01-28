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

This example checks the repository on `/mnt/backups`, warn if the last backup is older than 1 day + 1 hour, and become critical after 2 days + 1 hour.

```
check-restic-snapshot.rb --missing-status ok -w 90000 -c 176400 -p '/opt/bin/restic -r /mnt/backups -p /etc/restic/password'
```

You could also use the environment variables given in the restic documentation to specify repository and password.

## Installation

[Installation and Setup](http://sensu-plugins.io/docs/installation_instructions.html)

## Notes
