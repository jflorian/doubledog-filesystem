#
# == Define: filesystem::mount::point
#
# Manages a filesystem mount point.
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


define filesystem::mount::point (
        Ddolib::File::Ensure    $ensure='present',
        String[1]               $group='root',
        String[1]               $mode='0755',
        String[1]               $owner='root',
        Stdlib::Absolutepath    $point=$title,
        String[1]               $selrole='object_r',
        String[1]               $seltype='default_t',
        String[1]               $seluser='system_u',
    ) {

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
