# This is a hairy class
#
# @summary Give node access to several cats
#
# @example
#   class { 'kitties:
#     internet_cats => ['long_cat', 'nyan_cat', grumpy_cat']
#   }
#
class kitties (
  Optional[Array] $internet_cats = undef,
) {

  group { 'cat':
    ensure => present,
  }

  kitties::cat { ['caliente', 'oswin']:
    ensure => present,
  }

  file { '/opt/cats':
    ensure => directory,
  }

  unless $internet_cats =~ Undef {

    group { 'internet_cats':
      ensure => present,
    }

    kitties::cat { $internet_cats:
      ensure => present,
      group  => 'internet_cats',
    }
  }

}
