# Create an dnsmasq stub zone for caching upstream name resolvers
# (--dhcp-range).
class dnsmasq::dhcp (
  String $dhcp_start = 192.168.0.100,
  String $dhcp_end = 192.168.0.255,
  String $netmask = 255.255.255.0,
  String $lease_time = 12h,
  $tag = undef,
  $set = undef,
  $mode = undef,
) {
  $set_real = $set ? {
    undef   => '',
    default => "set:${set},",
  }
  $tag_real = $tag ? {
    undef   => '',
    default => "tag:${tag},",
  }
  $mode_real = $mode ? {
    undef => '',
    default => "${mode},"
  }

  include dnsmasq

  concat::fragment { "dnsmasq-dhcprange-${name}":
    order   => '01',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/dhcp.erb'),
  }

}
