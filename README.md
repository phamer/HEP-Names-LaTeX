# NAME

HEP::Names::LaTeX - formats plain names of high energy physics (HEP) particles to LaTeX

# VERSION

version 0.01

# SYNOPSIS

        use HEP::Names::LaTeX qw( particle_to_latex );
        use HEP::MCNS qw( particle_name );
        my $bplus_name_latex = particle_to_latex( $bplus_name );
        my $bzero_name_latex = particle_to_latex( particle_name( 511 ) );

# DESCRIPTION

Converts plain HEP particle names to nice LaTeX format.
For now only one raw particle name format is implemented, namely that of [HEP::MCNS](https://metacpan.org/pod/HEP::MCNS).

# FUNCTIONS

## particle\_to\_latex

takes particle names and formats to LaTeX

# AUTHOR

Philipp Hamer <philha@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Philipp Hamer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
