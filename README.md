## Quick Instructions (also works for ubuntu:latest docker container from dockerhub.com):

    apt-get update
    apt-get install -y build-essential ruby ruby-dev python3-dev python sudo wget
    
    wget http://rock-robotics.org/autoproj_bootstrap
    # If you have no write access to this repository:
    ruby autoproj_bootstrap git https://github.com/H2020-InFuse/cdff-buildconf.git branch=cdff_dev
    # If you have write access:
    ruby autoproj_bootstrap git git@github.com:H2020-InFuse/cdff-buildconf.git branch=cdff_dev
    # Answer "whether C++11 should be enabled for Rock packages [false]" with "true" and the
    # other with default (just hit enter)
    
    source env.sh
    autoproj update
    autoproj build
    

## Infuse framework install instructions

Execute the following to get the infuse framework ready to use on your machine.

0. Create a folder and move into it

0. Download the autoproj bootstrap script
    ```
    $ wget http://www.rock-robotics.org/autoproj_bootstrap
    ```

0. Run the boostrap script and provide the repository address
    ```
    $ ruby autoproj_bootstrap git git@gitlab.spaceapplications.com:InFuse/cdff-buildconf branch=cdff_dev
    ```

    Append `branch=cdff_dev` if you want to install CDFF and CDFF-dev. Remove it if you only want to install CDFF.

    Answer the autoproj_bootstrap questions. Defaults are usually OK (just hit enter), except for:
    ```
    whether C++11 should be enabled for Rock packages [false]
    ```
    There you type 'true' and hit enter.

0. Source your InFuse environment
    ```
    $ source env.sh
    ```

0. Update the checkout
    ```
    $ autoproj update
    ```

    Answer the questions. Defaults are ok again.
    If it went fine, you should see a message similar to:
    ```
    Command finished successfully at 2018-04-09 15:13:05 +0200
    ```

0. Compile the Sources

    ```
    $ autoproj build
    ```
    If it went fine, you should see a message similar to:
    ```
    Command finished successfully at 2018-04-10 03:13:37 +0200
    ```

## Uninstalling

Autoproj also may have installed OS dependencies, but autoproj cannot decide
whether those are still needed or not, they cannot be automatically
uninstalled. To see which packages were installed, please look at the 
install/logs/autoptoj-osdeps.log file for a complete list.

Autoproj itself (and it's ruby dependencies) is installed
to the user folder ~/.autoproj

Autoproj installes all source packages to a local a folder called "install" in the
base folder (i.e. where you executed autoproj_bootstrap).

Just delete these folders to uninstall.

## Expert Options: Configuration of your autoproj build

### CMake

Since everything is CMake based, environment variables such as
CMAKE_PREFIX_PATH are always picked up. You can set them
in init.rb too, which will copy them to your env.sh script.

Because of cmake's aggressive caching behaviour, manual options
given to cmake will be overriden by autoproj later on. To make
such options permanent, add

    package('package_name').define "OPTION", "VALUE"

in overrides.rb. For instance, to set CMAKE_BUILD_TYPE for the rtt
package, do

    package('rtt').define "CMAKE_BUILD_TYPE", "Debug"

### Files in the `autoproj/` directory

The `autoproj/` directory (this directory) contains the files and configuration
that defines the whole build.

`manifest`:
  Simple key-value pair file in the YAML format. It lists sources for "package
  sets", other autoproj configuration directories in which packages have been
  declared for you to reuse (package_sets section). It also lists the packages
  that you actually want to build (layout section)

`remotes/`:
  contains a checkout of the package sets listed in the manifest. You should not
  have to go in there unless you are yourself developing a package set.

`config.yml`:
  Autoproj can be parametrized by build options. This file is where your
  previous choices for these options are saved. You should not change it manually.
  If you need to change an option, run
    autoproj reconfigure

`overrides.yml`:
  Simple key-value pair file in the YAML format.  It allows to override branch
  information for specific packages.  Most people leave this to the default,
  unless they want to use a feature from an experimental branch. See the following
  page for a description of its contents.
    http://www.rock-robotics.org/stable/documentation/autoproj/advanced/importers.html

`init.rb`:
  Ruby script that contains customization code that will get executed before
  autoproj is loaded.

`overrides.rb`: 
  Ruby script that contains customization code that will get executed after
  autoproj is loaded, but before the build starts.


