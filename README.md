# docker-jenkins

This repository comprises of 3 components:
* jenkins-job-builder
* master - for running master jenkins instance
* slave - for running multiple types of slave instances (composer, maven, gradle, etc...)

## Jenkins Slave 

Slave is branched out per Swarm version.
When upgrading, a new branch should be created of form slave-&lt;swarm-version&gt; , e.g. slave-2.0.
Then the changes should be merged to _master_ - _master_ branch should always contain the latest version.

* Docker composer: 1.2
* Gradle version: 2.4
* Maven version: 3.3.3
* Android Studio version: 22

## Jenkins Master 

Upgrades to should be done in _develop_ branch and merged when stable to the _master_ branch.

Jenkins version: 1.609.2

## Jenkins Job Builder

Upgrades to should be done in _develop_ branch and merged when stable to the _master_ branch.

