# Create an dnsmasq dhcp option (--dhcp-option).
class dnsmasq::dhcpoption (
  Hash $hash = undef,
  $option = undef ,
  $content = undef ,
  $tag = undef,
) {

  include dnsmasq
  if $hash != undef {
    hash.each | String $option, String $content  | {
      concat::fragment { "dnsmasq-dhcpoption-${option}":
        order   => '03',
        target  => 'dnsmasq.conf',
        content => template('dnsmasq/dhcpoption.erb'),
      }
    }
  }
  # $tag_real = $tag ? {
  #   undef   => '',
  #   default => "tag:${tag},",
  # }


  # concat::fragment { "dnsmasq-dhcpoption-${option}":
  #   order   => '03',
  #   target  => 'dnsmasq.conf',
  #   content => template('dnsmasq/dhcpoption.erb'),
  # }

}
