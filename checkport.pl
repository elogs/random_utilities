#!/usr/bin/perl -w
# ./checkport.pl host port [tcp, udp]
# ex: ./checkport.pl 172.26.111.14 3366 tcp

use strict;
use IO::Socket;

my $desthost = shift or die "Usage: $0 host port protocol\n";
my $destport = shift or die "Usage: $0 host port protocol\n";
my $protocol = shift or die "Usage: $0 host port protocol\n";

gethostbyname($desthost) || die "Invalid host given\n";

my $handle = IO::Socket::INET->new(
		PeerAddr => $desthost,
		PeerPort => $destport,
		Proto    => $protocol)
	or die "cannot connect to $desthost:$destport: $!\n";
close $handle;
print "Success!\n"
