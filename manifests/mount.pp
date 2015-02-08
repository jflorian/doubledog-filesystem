# modules/filesystem/manifests/mount.pp
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
#       Class['doubledog::subsys::filesystem']
#
# Example usage:
#
#       include 'doubledog::subsys::filesystem'
#
#       filesystem::mount { 'data_pool':
#           source  => '/dev/sda7',
#       }


define filesystem::mount ($atboot=true, $ensure='mounted', $fstype='ext4',
                          $options='defaults', $owner='root', $group='root',
                          $source) {

    $mount_point = "${doubledog::subsys::filesystem::storage}/${name}"

    file { "${mount_point}":
        ensure  => directory,
        group   => "${owner}",
        mode    => '0755',
        owner   => "${group}",
        replace => false,
        require => Class['doubledog::subsys::filesystem'],
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
