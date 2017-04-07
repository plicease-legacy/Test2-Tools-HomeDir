package Test2::Tools::HomeDir;

use strict;
use warnings;
use base qw( Exporter );
use File::Temp qw( tempdir );
use File::Spec;
use constant _platform_env => [
  $^O =~ /^(MSWin32|cygwin)$/ ? qw( USERPROFILE HOMEDRIVE HOMEPATH HOME ) : qw( HOME )
];

die "Please contact author for support" if $^O eq 'msys';

our @EXPORT = qw( real_home scope_home mock_home );

# ABSTRACT: Test with a temporary faux home directory
# VERSION

=head1 SYNOPSIS

 use Test2::Tools::HomeDir;

=head1 DESCRIPTION

TODO

=head1 FUNCTIONS

=head2 scope_home

=cut

our $home;

sub scope_home (&)
{
  my($code) = @_;
  local $ENV{HOME} = $ENV{HOME};
  local $home = $home;
  $code->();
}

=head2 mock_home

 mock_home;

Creates a new mock home directory.  Sets appropriate environment variables for the platform
that you are running on.

=cut

sub mock_home
{
  $home = File::Temp->newdir;
  
  if($^O eq 'MSWin32')
  {
    $ENV{USERPROFILE} = "$home";
    ($ENV{HOMEDRIVE}, $ENV{HOMEPATH}) = File::Spec->splitpath("$home");
    $ENV{HOME} = "$home" if defined $ENV{HOME};
  }
  elsif($^O eq 'cygwin')
  {
    require File::Spec::Win32;
    ($ENV{HOMEDRIVE}, $ENV{HOMEPATH}) = File::Spec->splitpath(Cygwin::posix_to_win_path("$home"));
    $ENV{HOME} = "$home";
  }
  else
  {
    $ENV{HOME} = "$home";
  }
  
  return;
}

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

*CORE::GLOBAL::getpwuid = sub {

  return CORE::getpwuid(@_) unless $home;

  my @list = getpwuid(@_);
  $list[7] = "$home";
  @list;

};

=head1 SEE ALSO

=over 4

=item L<File::HomeDir::Test>

=back

=cut

1;
