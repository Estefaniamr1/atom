Git = require 'git-utils'
fsUtils = require 'fs-utils'
path = require 'path'

module.exports =
  loadStatuses: (path) ->
    repo = Git.open(path)
    if repo?
      workingDirectoryPath = repo.getWorkingDirectory()
      statuses = {}
      for path, status of repo.getStatus()
        statuses[path.join(workingDirectoryPath, path)] = status
      upstream = repo.getAheadBehindCount()
      repo.release()
    else
      upstream = {}
      statuses = {}

    callTaskMethod('statusesLoaded', {statuses, upstream})
