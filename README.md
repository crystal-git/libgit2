# Crystal Git

Yet another Crystal library for manipulating Git repositories in an object-oriented way.

Crystal Git internally uses libgit2, but is not a wrapper. It provides its own APIs.

This project is currently experimental.

[![Build Status](https://travis-ci.org/mosop/git.svg?branch=master)](https://travis-ci.org/mosop/git)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  git:
    github: mosop/git
```

<a name="code_samples"></a>
## Code Samples

### Checkout from Remote Branches

```crystal
`git init`
`git remote add origin https://github.com/mosop/git.git`

repo = Git::Repo.from_path(Dir.current)
repo.remotes["origin"].checkout("master")

puts `git branch` # => "* master"
```

### Remote URLs

```crystal
`git init`
`git remote add origin https://github.com/mosop/fetch.git`
`git remote set-url --push origin https://github.com/mosop/push.git`

remote = Git::Repo.from_path(Dir.current).remotes["origin"]
remote.fetch_url # => https://github.com/mosop/fetch.git
remote.push_url # => https://github.com/mosop/push.git
```

## Usage

```crystal
require "git"
```

and see [Code Samples](#code_samples).

## Release Notes

See [Releases](https://github.com/mosop/git/releases).
