package Test2::Tools::HomeDir;

use strict;
use warnings;
use Path::Tiny ();
use base qw( Exporter );

our @EXPORT = qw( real_home );

# ABSTRACT: Test with a temporary faux home directory
# VERSION

=head1 SYNOPSIS

 use Test2::Tools::HomeDir;

=head1 DESCRIPTION

TODO

=head1 FUNCTIONS

=head2 real_home

 my $dir = real_home;

Returns, as far as we can tell, the real, unmocked home directory for the user.
Will ignore environment variables where possible.

=cut

sub real_home
{
  my $dir = eval { (CORE::getpwuid($<))[7] };
  return $dir if $dir;
  
  die "unable to determine real home directory";
}

=head1 SEE ALSO

=over 4

=item L<File::HomeDir::Test>

=back

=cut

1;
