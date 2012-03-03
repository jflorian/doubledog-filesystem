# modules/filesystem/manifests/classes/base.pp
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
#
# Example usage:
#
#       include filesystem::base

class filesystem::base {

    # Set class defaults.
    File {
        group   => 'root',
        mode    => '0755',
        owner   => 'root',
    }

    # /exports is the standard location for bind mounting of file systems,
    # to be shared via NFS.
    file { '/exports':
        ensure  => directory,
    }

    # /mnt is the standard location for dynamic mounting of file systems,
    # typically via NFS.
    file { '/mnt':
        ensure  => directory,
    }

    # /storage is the standard location for static mounting of file systems
    # from physical storage such as LVM.
    file { '/storage':
        ensure  => directory,
    }

}
