#!/bin/bash

pushd jenkins-integration
source jenkins-jobs/common/scripts/job_steps/initialize_ruby_env.sh

# This job triggers a file sync operation on the SUT

set -x
set -e

# Setup SSH agent for SSH access to PUPPET_GATLING_MASTER_BASE_URL
eval $(ssh-agent -t 24h -s)
ssh-add ${HOME}/.ssh/id_rsa

bundle exec beaker \
        --config hosts.yaml \
        --load-path lib \
        --log-level debug \
        --no-color \
        --tests \
beaker/install/pe/98_sync_codedir.rb

# without this set +x, rvm will log 10 gigs of garbage
set +x
popd
