# Create an dnsmasq dhcp option (--dhcp-option).
class dnsmasq::dhcpoption (
  Hash $hash = undef,
  $option = undef ,
  $content = undef ,
  $tag = undef,
) {

  if $hash != undef {
    hash.each | $option, $content  | {
      concat::fragment { "dnsmasq-dhcpoption-${option}":
        order   => '03',
        target  => 'dnsmasq.conf',
        content => template('dnsmasq/dhcpoption.erb'),
      }
    }
  }
  $tag_real = $tag ? {
    undef   => '',
    default => "tag:${tag},",
  }

  include dnsmasq

  concat::fragment { "dnsmasq-dhcpoption-${option}":
    order   => '03',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/dhcpoption.erb'),
  }

}
