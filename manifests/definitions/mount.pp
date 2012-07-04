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
#       Class['filesystem::base']
#
# Example usage:
#
#       include filesystem::base
#
#       filesystem::mount { 'data_pool':
#           source  => '/dev/sda7',
#       }


define filesystem::mount ($atboot=true, $ensure='mounted', $fstype='ext4',
                          $options='defaults', $owner='root', $group='root',
                          $source) {

    $mount_point = "${filesystem::base::storage}/${name}"

    file { "${mount_point}":
        ensure  => directory,
        group   => "${owner}",
        mode    => '0755',
        owner   => "${group}",
        replace => false,
        require => Class['filesystem::base'],
    }

    mount { "${mount_point}":
        atboot  => "${atboot}",
        device  => "${source}",
        ensure  => "${ensure}",
        fstype  => "${fstype}",
        options => "${options}",
        require => File["${mount_point}"],
    }

}
