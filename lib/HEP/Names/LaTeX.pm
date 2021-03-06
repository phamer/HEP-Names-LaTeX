use strict;
use warnings;

package HEP::Names::LaTeX;

# ABSTRACT: formats plain names of high energy physics (HEP) particles to LaTeX

=head1 SYNOPSIS

	use HEP::Names::LaTeX qw( particle_to_latex );
	use HEP::MCNS qw( particle_name );
	my $bplus_name_latex = particle_to_latex( $bplus_name );
	my $bzero_name_latex = particle_to_latex( particle_name( 511 ) );

=head1 DESCRIPTION

Converts plain HEP particle names to nice LaTeX format.
For now only one raw particle name format is implemented, namely that of L<HEP::MCNS>.

=cut

use Exporter qw( import );

our @EXPORT = qw( particle_to_latex );

=func particle_to_latex

takes particle names and formats to LaTeX

=cut

my $names_to_escape = qr(psi|upsilon|gamma|tau|rho|pi|mu|eta|nu|omega);

sub particle_to_latex
{
	return '' unless @_;

	# in case of string literal in argument, we cannot modify @_!
	my @names = @_;
	foreach my $name ( @names ) {

		my ( $charge, $has_apo ) = ( '', '' );
		# this probably should be done better :)
		my $is_anti = $name =~ s/^anti-//;
		# charge is at last position (plus *)
		$charge = $1 if $name =~ s/(\**[0+-]+$)//;
		$has_apo = $1 if $name =~ s/('+)//;
		my $subscript = $1 if $name =~ s/_(.*)$//;

		my $total_charge = $has_apo.$charge;
		#$total_charge = undef unless length( $total_charge )

		# escape greek names
		$name =~ s/($names_to_escape)/\\$1/gi;
		$subscript =~ s/($names_to_escape)/\\$1/gi if $subscript;

		# ad put it together
		$name = "\\bar{$name}" if $is_anti;
		$name = $name."_{$subscript}" if $subscript;
		$name = $name."^{$total_charge}" if length($total_charge);
		$name = "\$".$name."\$";
	}

	return wantarray ? @names : $names[0];
}


1;
