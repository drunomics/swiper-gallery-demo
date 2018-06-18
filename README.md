# swiper-gallery-demo
developed by drunomics GmbH, office@drunomics.com

This project is maintained using composer. Please refer to the documentation 
provided at https://github.com/drupal-composer/drupal-project and 
https://www.drupal.org/node/2471553.

All photos in the examples are from https://www.pexels.com and licensed under 
the Creative Commons Zero (CC0) license.

## Project setup with docker

Install phapp as described below (Command line tools > Phapp).

```bash
composer install
phapp setup docker
./scripts/init-project.sh

# Add hosts entry.
echo $(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' swipergallerydemo_web_1) swiper-gallery-demo.local | sudo tee -a /etc/hosts

# Open http://swiper-gallery-demo.local
```

## Command line tools

### Phapp
Version 0.6.2 or later is required. Either install it globally and run `phapp`
or execute the embedded phapp version from the root repository directory:

```./vendor/bin/phapp ```

*Note*:
If phapp is not installed globally, `./vendor/bin/phapp` must be used instead of
just `phapp` always.

Refer to [the project page](http://github.com/drunomics/phapp-cli) for
instructions on how to install phapp globally.

### Drush
 To run drush, execute from the root repository directory:
 ```./vendor/bin/drush ```

 The more convenient alternative is to install a global launcher or a global
 drush with version 8, which includes a global launcher. Then, drush picks up
 the project-local drush automatically.
 For docs on drush see http://docs.drush.org/en/master/.

## Useful commands

- Commands for setting up or updating the project:

```
# Initialize the setup.
phapp setup docker

# Get in the docker web container (where you can use the phapp commands)
docker-compose exec web bash

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

Coding style can be checked automatically via Git's pre-commit hooks. To do so, just make sure to run the script `devsetup/setup-git-config.sh` at least once.

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
