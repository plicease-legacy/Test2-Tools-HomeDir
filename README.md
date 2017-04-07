# Test2::Tools::HomeDir [![Build Status](https://secure.travis-ci.org/plicease/Test2-Tools-HomeDir.png)](http://travis-ci.org/plicease/Test2-Tools-HomeDir)

Test with a temporary faux home directory

# SYNOPSIS

    use Test2::Tools::HomeDir;

# DESCRIPTION

TODO

# FUNCTIONS

## real\_home

    my $dir = real_home;

Returns, as far as we can tell, the real, unmocked home directory for the user.
Will ignore environment variables where possible.

# SEE ALSO

- [File::HomeDir::Test](https://metacpan.org/pod/File::HomeDir::Test)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
