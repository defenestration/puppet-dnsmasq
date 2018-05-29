# Create an dnsmasq dhcp option (--dhcp-option).
class dnsmasq::dhcpoption (
  $option = undef ,
  $content = undef ,
  $tag = undef,
) {
  $tag_real = $tag ? {
    undef   => '',
    default => "tag:${tag},",
  }

  include dnsmasq

  concat::fragment { "dnsmasq-dhcpoption-${name}":
    order   => '03',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/dhcpoption.erb'),
  }

}
