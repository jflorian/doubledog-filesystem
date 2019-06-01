#
# == Define: filesystem::mount
#
# Manages a filesystem mount configuration.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-filesystem Puppet module.
# Copyright 2012-2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


define filesystem::mount (
        String[1]                   $backing,
        Boolean                     $atboot=true,
        Filesystem::Mount::Ensure   $ensure='mounted',
        String[1]                   $fstype='auto',
        String[1]                   $group='root',
        Boolean                     $manage_mount_point=true,
        String[1]                   $mode='0755',
        String[1]                   $options='defaults',
        String[1]                   $owner='root',
        Integer[0]                  $pass=3,
        Stdlib::Absolutepath        $point=$title,
        String[1]                   $selrole='object_r',
        String[1]                   $seltype='default_t',
        String[1]                   $seluser='system_u',
    ) {

    if $manage_mount_point {
        filesystem::mount::point { $point:
            owner   => $owner,
            group   => $group,
            mode    => $mode,
            seluser => $seluser,
            selrole => $selrole,
            seltype => $seltype,
            before  => Mount[$point],
        }
    }

    mount { $point:
        ensure  => $ensure,
        atboot  => $atboot,
        device  => $backing,
        fstype  => $fstype,
        options => $options,
        pass    => $pass,
    }

}
