#!/usr/bin/env ruby
#
#   check-snapshot
#
# DESCRIPTION:
#   Check the age of the last restic snapshot
#
# OUTPUT:
#   Plain text
#
# PLATFORMS:
#   Any platform with restic client
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   ./check-snapshot.rb [-p path_to_restic] -w warn -c crit
#
# LICENSE:
#   Jan Kunzmann <jan.kunzmann@erasys.de>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'json'
require 'time'
require 'sensu-plugin/check/cli'

class ResticSnapshot < Sensu::Plugin::Check::CLI

  option :path,
         short: '-p RESTIC_PATH',
         long: '--path RESTIC_PATH',
         description: 'Path to the restic client binary.  Defaults to /usr/bin/restic',
         default: '/usr/bin/restic'

  option :missing_status,
         long: '--missing-status STATUS',
         description: 'Returns this exit status there there is no snapshot',
         default: 'critical',
         in: %w[unknown ok warning critical]

  option :warning_age,
         short: '-w SECONDS',
         long: '--warning SECONDS',
         description: 'Warn if latest snapshot is older than provided age in seconds',
         proc: proc(&:to_i),
         required: true

  option :critical_age,
         short: '-c SECONDS',
         long: '--critical SECONDS',
         description: 'Critical if latest snapshot is older than provided age in seconds',
         proc: proc(&:to_i),
         required: true

  def run
    snapshots = available_snapshots
    if snapshots.length == 0
      send(config[:missing_status], 'No backup found')
    end
    last_snap = Time.parse(snapshots[-1][:time])
    age = (Time.now - last_snap).to_i

    msg = "Last backup was at #{last_snap}"
    if age >= config[:critical_age]
      critical msg
    elsif age >= config[:warning_age]
      warning msg
    else
      ok msg
    end
  end

  #
  # Return an array of hashes with details about the snapshots
  #
  def available_snapshots
    snapshot_info = `#{config[:path]} --json snapshots`
    JSON.parse(snapshot_info, { symbolize_names: true })
  end
end
