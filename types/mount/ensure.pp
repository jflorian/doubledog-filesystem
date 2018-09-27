#
# == Type: filesystem::mount::ensure
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-filesystem Puppet module.
# Copyright 2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


type Filesystem::Mount::Ensure = Variant[
    Boolean,
    Enum[
        'absent',
        'defined',
        'mounted',
        'present',
        'unmounted',
    ],
]
