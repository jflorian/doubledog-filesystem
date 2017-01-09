# modules/filesystem/manifests/mount.pp
#
# == Define: filesystem::mount
#
# Manages a filesystem mount configuration.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   An arbitrary identifier for the mount instance unless the "point"
#   parameter is not set in which case this must provide the value normally
#   set with the "point" parameter.
#
# [*backing*]
#   The block device providing the backing storage that is to be mounted.
#
# ==== Optional
#
# [*atboot*]
#   Whether to mount the mount at boot. Defaults to true.
#
#   Not all platforms support this.
#
# [*ensure*]
#   Control what to do with this mount.  Defaults to 'mounted'.
#
#   Set to 'mounted'  to add it to the fstab and mount it.  Set this attribute
#   to 'unmounted' to make sure the filesystem is in the fstab but not mounted
#   (if the filesystem is currently mounted, it will be unmounted).  Set it to
#   'absent' to unmount (if necessary) and remove the filesystem from the
#   fstab.  Set to 'present' to add to fstab but not change mount/unmount
#   status.
#
# [*fstype*]
#   The mount type.  Defaults to 'auto'.
#
#   Valid values depend on the operating system.
#
# [*group*]
#   Group that is to own the mount point.  Defaults to 'root'.
#
# [*mode*]
#   File system mode of the mount point.  Defaults to '0755'.
#
# [*options*]
#   Mount options as they should appear in the fstab.  Defaults to 'defaults'.
#
# [*owner*]
#   User that is to own the mount point.  Defaults to 'root'.
#
# [*point*]
#   The absolute path to where the file system is to be mounted.
#
#   This directory This may be used in place of "namevar" if it's beneficial to give namevar
#   an arbitrary value.
#
# [*pass*]
#   The pass in which the mount is checked.  Defaults to 3.
#
# [*selrole*]
#   The SELinux role component of the context applied to the mount point.
#   Defaults to 'object_r'.
#
# [*seltype*]
#   The SELinux type component of the context applied to the mount point.
#   Defaults to 'default_t'.
#
# [*seluser*]
#   The SELinux user component of the context applied to the mount point.
#   Defaults to 'system_u'.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2012-2017 John Florian


define filesystem::mount (
        String[1] $backing,
        Boolean $atboot=true,
        Enum['defined', 'present', 'unmounted', 'absent', 'mounted'] $ensure='mounted',
        String[1] $fstype='auto',
        String[1] $group='root',
        Boolean $manage_mount_point=true,
        String[1] $mode='0755',
        String[1] $options='defaults',
        String[1] $owner='root',
        Integer[0] $pass=3,
        String[1] $point=$title,
        String[1] $selrole='object_r',
        String[1] $seltype='default_t',
        String[1] $seluser='system_u',
    ) {

    validate_absolute_path($point)

    ::filesystem::mount::point { $point:
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        seluser => $seluser,
        selrole => $selrole,
        seltype => $seltype,
    } ->

    mount { $point:
        ensure  => $ensure,
        atboot  => $atboot,
        device  => $backing,
        fstype  => $fstype,
        options => $options,
        pass    => $pass,
    }

}
