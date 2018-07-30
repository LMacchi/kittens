# There's a new cat in your node
#
# @summary Defined resource to create a cat in your node
#
# @example
#   kitties::cat { 'namevar': 
#     ensure => present,
#     group  => 'cats',
#   }
define kitties::cat(
  Enum['present','absent'] $ensure = 'absent',
  String                   $group  = 'cat',
) {

#  if $group.is_a(String) {
#    notice ('Var group is the right type')
#  }

  user { $title:
    ensure     => $ensure,
    gid        => $group,
    managehome => true,
    home       => "/opt/cats/${title}",
    comment    => "Cat ${title} in ${facts['hostname']}",
  }

  if $ensure == 'present' {

    file { "/opt/cats/${title}/cat.txt":
      ensure  => file,
      owner   => $title,
      group   => $group,
      content => "I am ${title} and I am a good kitty",
    }
  }
}
