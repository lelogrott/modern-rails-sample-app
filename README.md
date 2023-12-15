[![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide)
[![main workflow](https://github.com/lelogrott/modern-rails-sample-app/actions/workflows/main.yml/badge.svg)](https://github.com/lelogrott/modern-rails-sample-app/actions/workflows/main.yml)

<a id="modern-rails-sample-app"></a>
# Modern Rails Sample App

This app was developed using Ruby on Rails + Hotwire + Turbo + Stimulus.
There are many areas to improve in this code, but I wanted to demonstrate how I leveraged Hotwire + Turbo Streams and Stimulus to build a real-time validation in the frontend.

I understand that there are side effects and possible issues with this exact approach, like ending up with multiple requests being sent to the server, and an excessive amount of requests can be an issue.

GitHub actions are in place with linter, builds, and specs so we can get a proper CI/CD pipeline ready for production.



## Setting up a dev environment

<!-- MarkdownTOC autolink="true" autoanchor="true" -->

- [Modern Rails Sample App](#modern-rails-sample-app)
  - [Setting up a dev environment](#setting-up-a-dev-environment)
  - [Dependencies](#dependencies)
  - [Clone repo](#clone-repo)
  - [Install CLI tools and programs](#install-cli-tools-and-programs)
    - [\[OS X only\] Brew](#os-x-only-brew)
    - [Ruby + rbenv for managing versions](#ruby--rbenv-for-managing-versions)
    - [Node.js](#nodejs)
  - [Setup repo](#setup-repo)
    - [Add ssh keys to github](#add-ssh-keys-to-github)
    - [Setup database and boot Rails server](#setup-database-and-boot-rails-server)
  - [Available URLs](#available-urls)
  - [Done!](#done)
  - [Potential issues](#potential-issues)
    - [\[OS X only\] Command Line Tools](#os-x-only-command-line-tools)
    - [Puma issue with tmp/pids/ folder](#puma-issue-with-tmppids-folder)

<!-- /MarkdownTOC -->

<a id="dependencies"></a>

## Dependencies

- ruby
- postgresql
- node

_Note: Before installing all the dependencies locally, check the [Services](#dependencies-services) section._

<a id="clone-repo"></a>

## Clone repo

```bash
git clone git@github.com:lelogrott/modern-rails-sample-app.git
cd modern-rails-sample-app
```

<a id="install-cli-tools-and-programs"></a>

## Install CLI tools and programs

<a id="brew"></a>

### [OS X only] Brew

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`

<a id="rbenv--ruby-for-managing-ruby"></a>

### Ruby + rbenv for managing versions

Also: https://stackoverflow.com/questions/10940736/rbenv-not-changing-ruby-version

```bash
# OS X.
brew install rbenv ruby-build

# Debian, Ubuntu, and derivatives.
sudo apt install rbenv

rbenv init # Follow the printed instructions
rbenv install $(cat .ruby-version)

# You may need to restart your shell before running this command.
# Verify ruby --version is properly sourcing the newly installed
# ruby from rbenv before running this command.

gem install bundler
```

<a id="node"></a>

### Node.js

Find more details about installing and updating NVM @ https://github.com/nvm-sh/nvm#installing-and-updating. Check `package.json` for our node version, then copy that version into `~/.nvmrc`.

```bash
# Install NVM by running the following command, or check NVM
# documentation to see how to install its latest version.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

You may have to add the following to the correct profile file (probably ~/.zprofile if you're on macOS Catalina or later) and restart your terminal session:

```bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

```bash
nvm install "$(cat .nvmrc)"
nvm use
corepack enable
```

<a id="setup-repo"></a>

## Setup repo

<a id="add-ssh-keys-to-github"></a>

### Add ssh keys to github

1. [Create an SSH Key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
2. [Add it to GitHub](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)
3. Add identity to git

```bash
git config --global user.name "<your_full_name>"
git config --global user.email "<your_email>"
```

<a id="setup-database-and-boot-rails-server"></a>

### Setup database and boot Rails server

If you are running service dependencies via docker, install libpq via brew for the
`pg` rubygem to compile successfully.

```bash
# OS X.
brew install libpq

# Debian, Ubuntu, and derivatives.
sudo apt install libpq-dev

# Intel Macs:
bundle config --local build.pg --with-opt-dir="/usr/local/opt/libpq"
# Apple Silicon Macs:
bundle config --local build.pg --with-opt-dir="/opt/homebrew/opt/libpq"
```

Run the following commands:

```bash
bundle install # Installs gems, including Rails
yarn install # Install JS dependencies
rbenv rehash # Make newly installed gems available from command-line

rails console # and then `exit`

# Creates DB
rails db:create

# Sets up DB, can take a while
rails db:schema:load


# start the server with nodemon
./bin/dev
```

<a id="available-urls"></a>

## Available URLs

When server is up, you should be able to access the following URL's:

Status URL

- http://localhost:3000/

Users URL

- http://localhost:4100/users


<a id="done"></a>

## Done!

That should do it. If you encounter any problems, ask another engineer for help and update the steps so that the next person doesn't run into the same issue 😃

<a id="potential-issues"></a>

## Potential issues

<a id="command-line-tools"></a>

### [OS X only] Command Line Tools

try running this command after you have installed xcode `sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer`

### Puma issue with tmp/pids/ folder

> No such file or directory @ rb_sysopen - tmp/pids/server.pid (Errno::ENOENT)

If Puma crashes within the message above, just create the folder `/tmp/pids` manually and it should work.

