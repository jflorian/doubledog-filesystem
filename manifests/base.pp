# modules/filesystem/manifests/base.pp
#
# Synopsis:
#       Configures the base filesystem on a host.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       NONE
#
# Requires:
#       NONE


class filesystem::base {

    # Stage => first

    # Set class defaults.
    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seluser => 'system_u',
        selrole => 'object_r',
    }

    # $exports is the standard location for bind mounting of file systems,
    # to be shared via NFS.
    $exports = '/exports'
    file { "${exports}":
        ensure  => directory,
        seltype => 'nfs_t',
    }

    # /mnt is the standard location for dynamic mounting of file systems,
    # typically via NFS.
    file { '/mnt':
        ensure  => directory,
    }

    file { '/opt':
        seltype => 'usr_t',
    }

    # $storage is the standard location for static mounting of file systems
    # from physical storage such as LVM.
    $storage = '/storage'
    file { "${storage}":
        ensure  => directory,
    }

}
