# Write in this file customization code that will get executed before 
# autoproj is loaded.

# Set the path to 'make'
# Autobuild.commands['make'] = '/path/to/ccmake'

# Set the parallel build level (defaults to the number of CPUs)
# Autobuild.parallel_build_level = 10

# Uncomment to initialize the environment variables to default values. This is
# useful to ensure that the build is completely self-contained, but leads to
# miss external dependencies installed in non-standard locations.
#
# set_initial_env
#
# Additionally, you can set up your own custom environment with calls to env_add
# and env_set:
#
# env_add 'PATH', "/path/to/my/tool"
# env_set 'CMAKE_PREFIX_PATH', "/opt/boost;/opt/xerces"
# env_set 'CMAKE_INSTALL_PATH', "/opt/orocos"
#
# NOTE: Variables set like this are exported in the generated 'env.sh' script.
#


Autoproj.config.load_config_once("config_seed.yml")

#only needed while on dfki server
require 'autoproj/git_server_configuration'
#Autoproj.git_server_configuration('SPACEAPP', 'gitlab.spaceapplications.com', :fallback_to_http => false, default: 'http,ssh', disabled_methods: 'http,git')
#Autoproj.git_server_configuration('DFKIGIT', 'git.hb.dfki.de', :fallback_to_http => false, default: 'ssh,ssh', disabled_methods: 'http,git')
