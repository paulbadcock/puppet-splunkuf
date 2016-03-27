# splunkuf [![Build Status](https://travis-ci.org/paulbadcock/puppet-splunkuf.svg)](https://travis-ci.org/paulbadcock/puppet-splunkuf) [![Coverage Status](https://coveralls.io/repos/paulbadcock/puppet-splunkuf/badge.svg)](https://coveralls.io/r/paulbadcock/puppet-splunkuf)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with splunkuf](#setup)
    * [What splunkuf affects](#what-splunkuf-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with splunkuf](#beginning-with-splunkuf)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The SplunkUF module manages the Splunk Universal forwarder on RedHat, Debian, and Ubuntu.

## Module Description

This module installs the Splunk Universal forwarder only and will configure it to talk to a deployment server. Supported OS's include RedHat, Debian, and Ubuntu.

For a more full featured Splunk install or module look at [huit/splunk](https://forge.puppetlabs.com/huit/splunk)

## Setup

### What splunkuf affects

* /etc/init.d/splunkforwarder
* /opt/splunkforwarder

### Setup Requirements

Have access to a yum repository or debian repository with splunkforwarder from [Splunk](http://www.splunk.com/en_us/download/universal-forwarder.html)

### Beginning with splunkuf

The only mode this module has is to install a [Universal Forwarder](http://docs.splunk.com/Documentation/Splunk/6.2.3/Forwarding/Introducingtheuniversalforwarder) If you need a fully featured Splunk install [huit/splunk](https://forge.puppetlabs.com/huit/splunk)

## Usage

To use the universal forwarder one parameter can be passed to the class to set the deployment server to communicate with

```Puppet
class { 'splunkuf':
  targeturi => 'deployment.tld:8089',
}
```

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

####RHEL/CentOS 7
RHEL/CentOS 7 is fully supported and functional

####Debian/Ubuntu
Currently under testing

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc 

### v0.3.6
* Credit fixed

### v0.3.5
* Fixes from [Ryan Sabatini](https://github.com/scotchsterling) for systemd

### v0.3.4
* Typo and general spelling stuff, 100% code coverage for RHEL6/7

### v0.3.3
* Metadata work to improve code quality

### v0.3.2
* Reworked the deployment info into a file to do things correctly

### v0.3.1
* Silly default line endings in Windows

### v0.3.0
* Working Ubuntu/Debian code

### v0.2.0
* Working CentOS/RHEL7 code

### v0.1.1
* Cleaned up readme

### v0.1.0
* Initial work
