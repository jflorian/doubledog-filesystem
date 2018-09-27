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
# Copyright 2012-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


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
