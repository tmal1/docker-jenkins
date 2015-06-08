# docker-jenkins

This repository comprises of 3 components:
* jenkins-job-builder
* master - for running master jenkins instance
* slave - for running multiple types of slave instances (composer, maven, gradle, etc...)

## Jenkins Slave 

Slave is branched out per Docker version + Swarm version.
When upgrading, a new branch should be created of form slave-<docker-version>_<swarm-version> , e.g. slave-1.5.0_1.23.
Then the changes should be merged to _master_ - _master_ branch should always contain the latest version.

## Jenkins Master 

Upgrades to should be done in _develop_ branch and merged when stable to the _master_ branch.

## Jenkins Job Builder

Upgrades to should be done in _develop_ branch and merged when stable to the _master_ branch.

