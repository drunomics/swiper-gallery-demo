Swiper Gallery Demo
===================

This is a drupal thunder demo site which demonstrates how the swiper gallery 
module is used and what the gallery looks like in action. You can play around
with the settings or create your own theme in a sandbox environment.

The swiper gallery module provides a responsive integration of a [Swiper](http://idangero.us/swiper/) 
gallery with the drupal media entity. Depending on the window size, the gallery
consists of a horizontal slider with thumbnails in the desktop mode and turns 
into a vertical slider in the mobile version. It also supports ad entity
integration for putting ads in between the slides.

## Table of content

  * [Prerequisites](#prerequisites)
    * [Environment variables](#environment-variables)
    * [Command line tools](#command-line-tools)
      * [Phapp](#phapp)
      * [Drush](#drush)
    * [Installation](#installation)
  * [Useful commands](#useful-commands)
  * [Running tests](#running-tests)
  * [Coding style](#coding-style)
    * [Pre-commit checks](#pre-commit-checks)
    * [PHPstorm coding style configuration](#phpstorm-coding-style-configuration)
  * [Contributors](#contributors)
  * [License](#license)

## Prerequisites

This project is maintained using composer. Please refer to the documentation 
provided at https://github.com/drupal-composer/drupal-project and 
https://www.drupal.org/node/2471553.

The demo page runs in a docker container which is configured via [docker compose](https://docs.docker.com/compose/). 

### Environment variables

Default environments variables are set in `.defaults.env`. By default port 80 is 
used for HTTP and port 3306 for MYSQL. To override them create a `.local.env`
with your custom port settings.

If you want to change environment variables later on, you can rebuild the docker 
container with: `./dcp.sh up -d --build`.

`./dcp.sh` is used within the project as a shorthand link to run 
`docker-compose` within the current environment.

### Command line tools

#### Phapp

Version 0.6.2 or later is required. Either install it globally and run `phapp`
or execute the embedded phapp version from the root repository directory:

```./vendor/bin/phapp ```

*Note*:
If phapp is not installed globally, `./vendor/bin/phapp` must be used instead of
just `phapp` always.

Refer to [the project page](http://github.com/drunomics/phapp-cli) for
instructions on how to install phapp globally.

#### Drush

 To run drush, execute from the root repository directory:
 ```./vendor/bin/drush ```

 The more convenient alternative is to install a global launcher or a global
 drush with version 8, which includes a global launcher. Then, drush picks up
 the project-local drush automatically.
 For docs on drush see <http://docs.drush.org/en/master/>.

### Installation

```bash
composer install
phapp setup docker
./scripts/init-project.sh
```

The page is available under <http://swiper-gallery-demo.localdev.space>
Admin: dru_admin / dru_admin

## Useful commands

- Commands for setting up or updating the project:

```
# Initialize the setup.
phapp setup docker

# Run the docker container
./dcp.sh up -d

# Shutdown docker
./dcp.sh down

# Export init database & files.
./dcp.sh exec web ./scripts/export-init.sh

# Get in the docker web container (where you can use the phapp commands)
./dcp.sh exec web bash

# Initialize the application, after building it:
phapp init

# Update the build and run updates after switching branches:
phapp update

# Install from scratch.
phapp install
```

If composer install has been run and one wants to skip building again during
init or update, one can pass the --no-build option like so:

```
composer install
docker-compose exec web bash
phapp init --no-build
phapp update --no-build
```

The commands executed can be found in `phapp.yml`.

*Note*: If phapp is not installed globally or missing, refer to the "Phapp"
section under "Command line tools" above.

- During development, some useful commands are:

```
# Config export (export your config changes):
drush cex -y

# Config import (manual import of config files):
drush cim -y

# Cache clear/rebuild:
drush cr
```

## Running tests

Tests are implemented using behat. To run all tests, a recent chrome browser
(59+) that is used for headless tests.

To run the tests in the vagrant environment the following commands can be used:

    ./tests/behat/run.sh

Any further arguments are forwarded to behat:

    ./tests/behat/run.sh --tags=javascript

By default chrome is shown. To run it in headless mode use:

    HEADLESS=1 ./tests/behat/run.sh

## Coding style

To check the coding style for the project's custom code, run PHP code sniffer:

    composer cs

To automatically fix the coding style errors (as far as possible), run the PHP
code beautifier:

    composer cbf

### Pre-commit checks

Coding style can be checked automatically via Git's pre-commit hooks. To do so, 
just make sure to run the script `devsetup/setup-git-config.sh` at least once.

Once configured, running pre-commit hooks can be bypassed via the Git commmit
`--no-verify` option.

### PHPstorm coding style configuration

Configure the following settings:
* Under Languages / PHP / Code Sniffer
  - Select "local" configuration and make it point to `vendor/bin/phpcs`).
* Under Editor / Inspections / PHP Code Sniffer validation:
  - Select "warning" as severity.
  - Show warnings as "warning"
  - Show sniff name "true"
  - Coding standard: "custom", make it point to the phpcs.xml.dist file in the
    vcs root.

## Contributors

developed by drunomics GmbH, office@drunomics.com

## License

MIT © [drunomics GmbH](https://www.drunomics.com)

All photos in the examples are from https://www.pexels.com and licensed under 
the Creative Commons Zero (CC0) license.
