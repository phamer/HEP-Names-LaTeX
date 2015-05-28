use strict;
use warnings;

package HEP::Names::LaTeX;
$HEP::Names::LaTeX::VERSION = '0.01';
# ABSTRACT: formats particle names as used in eg L<HEP::MCNS> to LaTeX


use Exporter qw( import );

our @EXPORT = qw( hepname_to_latex );


sub hepname_to_latex
{
	return '' unless @_;

	foreach my $name ( @_ ) {
		my $orig = $name;

		my ( $charge, $has_apo ) = ( '', '' );
		# this probably should be done better :)
		my $is_anti = $name =~ s/^anti-//;
		# charge is at last position (plus *)
		$charge = $1 if $name =~ s/(\**[0+-]+$)//;
		$has_apo = $name =~ s/'//;
		my $subscript = $1 if $name =~ s/_(.*)$//;

		my $total_charge = $has_apo ? '\''.$charge : $charge;
		#$total_charge = undef unless length( $total_charge )

		# escape greek names
		$name =~ s/(psi|upsilon|gamma|tau|rho|pi|mu|eta|nu|omega)/\\$1/gi;

		# ad put it together
		$name = "\\bar{$name}" if $is_anti;
		$name = $name."_{$subscript}" if $subscript;
		$name = $name."^{$total_charge}" if length($total_charge);
		$name = "\$".$name."\$";
	}

	return @_;
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

HEP::Names::LaTeX - formats particle names as used in eg L<HEP::MCNS> to LaTeX

=head1 VERSION

version 0.01

=head1 SYNOPSIS

	use HEP::Names::LaTeX qw( hepname_to_latex );
	use HEP::MCNS qw( particle_name );
	my $bplus_name_latex = hepname_to_latex( $bplus_name );
	my $bzero_name_latex = hepname_to_latex( particle_name( 511 ) );

=head1 DESCRIPTION

Converts particle names, eg as produced in L<HEP::MCNS> to LaTeX.
For now only one raw particle name format is implemented, namely that of L<HEP::MCNS>.

=head1 FUNCTIONS

=head2 hepname_to_latex

takes particle names and formats to LaTeX

=head1 AUTHOR

Philipp Hamer <philha@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Philipp Hamer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
