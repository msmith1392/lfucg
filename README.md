[![Circle CI](https://circleci.com/gh/lfucg/lexingtonky.gov/tree/master.svg?style=svg)](https://circleci.com/gh/lfucg/lexingtonky.gov/tree/master)
Visual regression testing via [Browserstack Automate](browserstack.com/automate) and [shoov.io](http://shoov.io/) (Our config is currently in alpha, housed in [separate repo](https://github.com/eeeschwartz/shoov-tutorial))

# Lexington, KY city site

The upcoming site for the City of Lexington, currently in pilot phase. It's built on [Drupal 8](https://www.drupal.org/8) and uses the draft [US Web Design Standards](https://playbook.cio.gov/designstandards/).

## Installation

Use the following instructions to set up a local development environment for the city's Drupal site.

An [example walkthrough of install process](http://erikschwartz.net/2015-11-16-install-pantheon-drupal-8-mamp) on a Mac.

[Install terminus](https://github.com/pantheon-systems/terminus)

### Download codebase

```
git clone git@github.com:lfucg/lexingtonky.gov.git
cd lexingtonky.gov
```

### Download database from pantheon

Add to .ssh/config

```
Host pantheon
  HostName codeserver.dev.PANTHEONID.drush.in
  Port 2222
  User codeserver.dev.PANTHEONID
  IdentityFile ~/.ssh/your-identity-file.id_rsa
```

```
terminus site backups get --element=database --env=live --to=. --latest
gunzip --stdout <your-site_2016-03-11T13-00-00_UTC_database.sql.gz> | mysql -u <username> -p<password> <local-db-name>
drush cr
```

### Download files from pantheon (optional)

If you want to see files that contributors have uploaded to the site like images and pdfs:

Add to .ssh/config

```
Host pantheon-files
  HostName hostname-from-pantheon
  Port 2222
  User username-from-pantheon
  IdentityFile ~/.ssh/your-identity-file.id_rsa
```

`rsync -rlvz --size-only --ipv4 --progress -e 'ssh -p 2222' pantheon-files:~/files/ ./sites/default/files`

### Configure local settings

copy sites/example.settings.local.php sites/default/settings.local.php

append to the new file: settings.local.php

```php
$settings['trusted_host_patterns'][] = '^localhost$';

/**
 * Enable access to rebuild.php.
 *
 * This setting can be enabled to allow Drupal's php and database cached
 * storage to be cleared via the rebuild.php page. Access to this page can also
 * be gained by generating a query string from rebuild_token_calculator.sh and
 * using these parameters in a request to rebuild.php.
 */
$settings['rebuild_access'] = FALSE;

$settings['hash_salt'] = 'somethingunique';

$databases['default']['default'] = array(
  'driver' => 'mysql',
  'database' => 'your-local-db',
  'username' => 'your-username',
  'password' => 'your-password',
  'host' => 'localhost',
  'prefix' => '',
  'collation' => 'utf8mb4_general_ci',
);
```

## Development

[Install composer](https://getcomposer.org/doc/00-intro.md)

Install Drush

`composer require "drush/drush:dev-master"`

### Run tests locally

Create a project clone to mimic the working directory. This is where we
will `composer install` dev dependencies.

create copy of working dir

```
/mkdir dev-dependencies
rsync -vah ../site-working-dir/ dev-dependencies/
cd dev-dependencies
composer install
```

* Set your drupal_root in behat.yml (e.g. /my/path/to/drupal/install)
* Start selenium server: `java -jar selenium-server-standalone-2.50.1.jar`
* enable devel_mail_log: `drush en -y devel`

To run tests, make sure you have latest features in the dev-dependecies dir

```
cd dev-dependencies
rsync -vah ../site-working-dir/features/ features/
./vendor/bin/behat

# as a one-liner
rsync -vah ../site-working-dir/features/ features/ && ./vendor/bin/behat
```

Backstory

This solution is imperfect. If we `composer install` dev dependencies to `site-working-dir/vendor`,
git will show a ton of changes since vendor can't be gitignored. So our local working
directory is a mess. Pantheon doesn't have a great way to deploy vendored files at build time.
To keep this project clean, we keep `vendor/` perfectly in sync with [Pantheon's Drupal 8 upstream](https://github.com/pantheon-systems/drops-8/).  We then install dev dependencies to a cloned version
of the working directory.

### Import/export of configuration changes

As you make changes to the site, you'll want to export your configuration changes:

`drush cex -y`

And to set the local database to the configuration stored in git:

`drush cim -y`

## Recommended process for upgrading modules

* Read release notes
* Check bug reports for problems with new version. If not a security update, often best to wait a few weeks to let bug reports filter in. Checking usage statistics is helpful to make sure the version is being used.
* `drush pm-update my-module`
* Run behat tests locally
* Scan code diffs for any red flags
* Commit and push

## Google Translate

The Google Translation widget javascript is triggered by a menu item in the `header-quick-links`
block titled `Translation`. See lex.theme:lex_preprocess_menu__header_quick_links for details

## Lex theme

To add a custom banner image to a content type, give it field_lex_custom_banner_image. No
need to display the field, it gets added to a style tag in the document head.

## Admin theme (lex_admin)

To use the [chosen](https://www.drupal.org/project/chose) select widget, set the field to 'Select list' under content type > manage form display

## Analytics

Using Google Tag Manager as described in the [Unified Analytics](https://github.com/laurenancona/unified-analytics) repo
