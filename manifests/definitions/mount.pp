# modules/filesystem/manifests/definitions/mount.pp
#
# Synopsis:
#       Mount a physical filesystem.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            mount name (path is implied)
#       atboot          true            mounted at boot?
#       ensure          present         mounted/present/unmounted/absent
#       fstype          ext4            file system type
#       source                          origin of file system
#
# Requires:
#       Class['filesystem']
#
# Example usage:
#
#       include filesystem
#
#       filesystem::mount { 'data_pool':
#           source  => '/dev/sda7',
#       }


define filesystem::mount ($atboot=true, $ensure='mounted', $fstype='ext4',
                          $source) {

    $mount_point = "${filesystem::base::storage}/${name}"

    file { "${mount_point}":
        ensure  => directory,
        group   => 'root',
        mode    => '0755',
        owner   => 'root',
    }

    mount { "${mount_point}":
        atboot  => $atboot,
        # Make sure physical mounts are in place before attempting any
        # auto-mounts or NFS exporting of the same.
        before  => [
            Class['autofs'],
            Class['nfs::server'],
        ],
        device  => "${source}",
        ensure  => $ensure,
        fstype  => "${fstype}",
        require => File["${mount_point}"],
    }

}
