# Website for TaskRoller App

Uses the Sinatra framework to display information about [TaskRoller](https://github.com/dsandstrom/task_roller)

## Local Setup

#### System dependencies
* Ruby
* rbenv, rvm, or similar

#### Configuration

##### Install Ruby and gems

Clone from GitHub and `cd` into project directory

```sh
# install ruby version set in .ruby-version
rbenv install # or `rvm install`
gem install bundler
bundle install --without production
```

#### Install Frontend Dependencies
Install [yarn](https://github.com/yarnpkg/berry) on your system. This step might
also install Node.js, but please see below to ensure that you use the right
version when working on the project.

I use [Node Version Manager](https://github.com/nvm-sh/nvm) to maintain a more
consistent Node.js version. The version number is stored in *./.nvmrc*. Please
use that version of node or use **nvm** to install it.

```sh
# using nvm
# cd into project directory
nvm install
nvm use

# finally, install packages
yarn install
```

### Run Development Server

Starts puma and asset compilation scripts

```sh
bin/dev
```
