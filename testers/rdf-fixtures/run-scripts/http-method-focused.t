=pod

=encoding utf-8

=head1 PURPOSE

Testing HTTP interface functionality of a Solid server

=head1 ENVIRONMENT

=head2 C<SOLID_FIXTURE_PATH>

Set the path to where the Turtle files with fixture tables are. Defaults to C</opt/fixture-tables/>.

=head2 C<SOLID_REMOTE_BASE>

B<Required> Sets the base URL to resolve URLs in the Turtle fixture tables against.

=head1 AUTHOR

Kjetil Kjernsmo E<lt>kjetilk@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is Copyright (c) 2020 by Inrupt Inc.

This is free software, licensed under:

  The MIT (X11) License


=cut


use strict;
use warnings;

use Test::More;
use Test::FITesque;
use Test::FITesque::Test;

BEGIN {
  $ENV{PERL_NET_HTTPS_SSL_SOCKET_CLASS} = 'IO::Socket::SSL';
}


my $path = $ENV{SOLID_FIXTURE_PATH} || '/opt/fixture-tables/';

use Test::FITesque::RDF;

my @files = qw(
					 operations_post_with_slug.ttl
					 operations_put_resource.ttl
					 operations_put_container.ttl
				 );


BAIL_OUT("Set SOLID_REMOTE_BASE to the URL of the base of the server you are testing") unless $ENV{SOLID_REMOTE_BASE};


my $suite = Test::FITesque::Suite->new;

foreach my $file (@files) {
  note("Reading tests from $path$file");
  $suite->add(Test::FITesque::RDF->new(source => $path . $file, base_uri => $ENV{SOLID_REMOTE_BASE})->suite);
}

$suite->run_tests;

done_testing;
  

