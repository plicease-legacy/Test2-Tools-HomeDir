use Test2::Tools::HomeDir;
use Test2::Bundle::Extended;

subtest 'real home directory' => sub {

  my $dir = real_home();
  
  ok $dir, 'dir is a true value';
  note "dir = $dir";

};

sub note_locations
{
  my($prefix) = @_;
  note "$prefix: $_=@{[ defined $ENV{$_} ? $ENV{$_} : 'undef' ]}" for qw( HOME USERPROFILE USERDRIVE USERPATH );
  note "$prefix: \$Test2::Tools::HomeDir::home=@{[ defined $Test2::Tools::HomeDir::home ? $Test2::Tools::HomeDir::home : 'undef' ]}";
  
}

subtest 'mock_home' => sub {

  my $mock_home;
  my $env_name = $^O eq 'MSWin32' ? 'USERPROFILE' : 'HOME';

  scope_home {
    mock_home;

    $mock_home = $ENV{$env_name};
    
    ok -d $mock_home, "mock home is a directory";
    
    note_locations('IN  SCOPE');
    
  };

  my $real_home = $ENV{$env_name};

  isnt $real_home, $mock_home, 'mock home is different from real home';

  note_locations('OUT SCOPE');

};

done_testing;
