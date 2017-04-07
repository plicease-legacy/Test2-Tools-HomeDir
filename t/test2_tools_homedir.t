use Test2::Tools::HomeDir;
use Test2::Bundle::Extended;

subtest 'real home directory' => sub {

  my $dir = real_home();
  
  ok $dir, 'dir is a true value';
  note "dir = $dir";

};

done_testing;
