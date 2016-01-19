# modules/filesystem/manifests/mount/point.pp
#
# == Define: filesystem::mount::point
#
# Manages a filesystem mount point.
#
# This will ensure that the named directory exists.  Any parent directories
# must be managed separately.
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
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*group*]
#   Group that is to own the mount point.  Defaults to 'root'.
#
# [*mode*]
#   File system mode of the mount point.  Defaults to '0755'.
#
# [*owner*]
#   User that is to own the mount point.  Defaults to 'root'.
#
# [*point*]
#   The absolute path in the file system to the mount point.
#
#   This may be used in place of "namevar" if it's beneficial to give namevar
#   an arbitrary value.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2012-2016 John Florian


define filesystem::mount::point (
        $ensure='present',
        $group='root',
        $mode='0755',
        $owner='root',
        $point=$title,
        $seluser='system_u',
        $selrole='object_r',
        $seltype='default_t',
    ) {

    validate_absolute_path($point)

    validate_re($ensure, '^(present|absent)$',
        "${title}: 'ensure' must be one of 'present' or 'absent'"
    )

    $dir_ensure = $ensure ? {
        'absent' => $ensure,
        default  => 'directory',
    }

    file { $point:
        ensure  => $dir_ensure,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        seluser => $seluser,
        selrole => $selrole,
        seltype => $seltype,
    }

}
