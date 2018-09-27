<!--
# This file is part of the doubledog-filesystem Puppet module.
# Copyright 2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later
-->

# filesystem

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with filesystem](#setup)
    * [What filesystem affects](#what-filesystem-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with filesystem](#beginning-with-filesystem)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined types](#defined-types)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module lets you manage filesystems.

## Setup

### What filesystem Affects

### Setup Requirements

### Beginning with filesystem

## Usage

## Reference

**Classes:**

**Defined types:**

* [filesystem::mount](#filesystemmount-defined-type)
* [filesystem::mount::point](#filesystemmountpoint-defined-type)

**Data types:**

* [Filesystem::Mount::Ensure](#filesystemmountensure-data-type)


### Classes


### Defined types

#### filesystem::mount defined type

This defined type wraps the standard Puppet `mount` resource type but has the additional capability of managing the underlying mount point.

##### `namevar` (required)
An arbitrary identifier for the mount instance unless the *point* parameter is not set in which case this must provide the value normally set with the *point* parameter.

##### `backing` (required)
The block device providing the backing storage for the instance that is to be mounted.

##### `atboot`
Whether the instance is to be mounted at boot.  Defaults to `true`.

Not all platforms support this.

##### `ensure`
Control what to do with this instance.  Defaults to `'mounted'`.

* `'mounted'` to ensure the instance is present in the fstab and mounted
* `'unmounted'` to ensure the instance is present in the fstab but not mounted
* `'absent'` to ensure the instance is not mount nor present in the fstab
* `'present'` to ensure the instance is present in the fstab, but otherwise as is

##### `fstype`
The mount type.  Defaults to `'auto'`.  Valid values depend on the operating system.

##### `group`
Group that is to own the mount point.  Defaults to `'root'`.  Ignored if *manage_mount_point* is `false`.

##### `manage_mount_point`
Should the mount point directory be managed here?  Defaults to `true` which is ideal for most use cases.  However, if another Puppet module is managing the *point* directory, this must be set to `false` to avoid conflicting declarations.

##### `mode`
Filesystem mode of the mount *point* directory.  Defaults to `'0755'`.  Ignored if *manage_mount_point* is `false`.

##### `options`
Mount options as they should appear in the fstab.  Defaults to `'defaults'`.

##### `owner`
User that is to own the mount *point* directory.  Defaults to `'root'`.  Ignored if *manage_mount_point* is `false`.

##### `point`
The absolute path to where the filesystem is to be mounted.  This may be used in place of *namevar* if it's beneficial to give *namevar* an arbitrary value.

##### `pass`
The pass in which the mount is checked.  Defaults to `3`.

##### `selrole`
The SELinux role component of the context applied to the mount *point* directory.  Defaults to `'object_r'`.  Ignored if *manage_mount_point* is `false`.

##### `seltype`
The SELinux type component of the context applied to the mount *point* directory.  Defaults to `'default_t'`.  Ignored if *manage_mount_point* is `false`.

##### `seluser`
The SELinux user component of the context applied to the mount *point* directory.  Defaults to `'system_u'`.  Ignored if *manage_mount_point* is `false`.


#### filesystem::mount::point defined type

This will ensure that the named directory exists.  Any parent directories must be managed separately.

##### `namevar` (required)
An arbitrary identifier for the mount point instance unless the *point* parameter is not set in which case this must provide the value normally set with the *point* parameter.

##### `ensure`
Instance is to be `'present'` (default) or `'absent'`.  Alternatively, a Boolean value may also be used with `true` equivalent to `present` and `false` equivalent to `absent`.

##### `group`
Group that is to own the mount *point* directory.  Defaults to `'root'`.

##### `mode`
File system mode of the mount *point* directory.  Defaults to `'0755'`.

##### `owner`
User that is to own the mount *point* directory.  Defaults to `'root'`.

##### `point`
The absolute path in the file system to the mount point directory.  This may be used in place of *namevar* if it's beneficial to give namevar an arbitrary value.


### Data types

#### `Filesystem::Mount::Ensure` data type

Matches acceptable *ensure* values for [filesystem::mount](#filesystemmount-defined-type) resources: `absent`, `defined`, `mounted`, `present` or `unmounted`.


## Limitations

Tested on modern Fedora and CentOS releases, but likely to work on any Red Hat variant.  Adaptations for other operating systems should be trivial as this module follows the data-in-module paradigm.  See `data/common.yaml` for the most likely obstructions.  If "one size can't fit all", the value should be moved from `data/common.yaml` to `data/os/%{facts.os.name}.yaml` instead.  See `hiera.yaml` for how this is handled.

## Development

Contributions are welcome via pull requests.  All code should generally be compliant with puppet-lint.
