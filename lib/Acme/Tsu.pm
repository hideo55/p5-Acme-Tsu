package Acme::Tsu;
use Acme::EyeDrops;

our $VERSION = '0.01';

my $signed   = "\t" x 8;
my $AKUMETSU
	= qq{02 11 058 11 02\n01 13 056 13 01\n01 13 056 13 01\n01 14 054 14 01\n15 054 15\n16 052 16\n17 050 17\n17 050 17\n01 17 048 17 01\n01 18 046 18 01\n02 18 044 18 02\n03 18 040 11 02 17 03\n04 18 02 11 035 11 02 17 04\n06 17 02 11 032 110 06\n07 111 028 111 07\n09 112 022 112 09\n011 113 016 114 010\n012 17 04 12 014 13 03 17 012\n013 17 05 12 04 12 05 11 06 14 01 11 013\n012 12 01 16 09 15 08 16 02 11 012\n013 138 013\n013 139 012\n012 141 011\n010 114 01 114 02 113 010\n09 17 05 12 09 11 09 12 05 16 09\n09 14 08 11 020 11 09 14 08\n010 12 010 11 04 110 04 11 011 12 09\n011 11 011 118 012 11 010\n026 113 025\n026 112 026\n026 12 09 12 025\n023 15 01 17 01 14 023\n025 115 024\n029 17 028\n031 13 030\n031 13 030\n032 11 031\n032 11 032};

sub garbled {
	$_[0] =~ /[0-9A-Za-z]/;
}

sub signed {
	$_[0] =~ /^$signed/;
}

open 0 or print "Can't AKUMETSU\n" and exit;
( my $source = join "", <0> ) =~ s/.*\s*use\s+Acme::Tsu\s*;\n//sm;

local $SIG{__WARN__} = \&garbled;
do {
	$source =~ s/^$signed|[^ \t]//;
	eval $source;
	exit;
} unless garbled $source && not signed $source;

my $akumetsu = Acme::EyeDrops::sightly(
	{   ShapeString => join(
			"\n",
			map {
				join( '',
					map { /^(\d)(\d+)$/; ( $1 ? '#' : q{ } ) x $2 } split /\s/,$_ )
				} split /\n/, $AKUMETSU
		),
		SourceString  => $source,
		Regex         => 1,
		InformHandler => sub { },
	}
);
open 0, ">$0" or print "Can't AKUMETSU\n" and exit;
print {0} "use Acme::Tsu;\n", "$signed\n", $akumetsu and exit;

'AKUMETSU';
__END__

=head1 NAME

Acme::Tsu - AKUMETSU

=head1 SYNOPSIS

  use Acme::Tsu;

=head1 DESCRIPTION

Acme::Tsu is AKUMETSU

=head1 AUTHOR

Hideaki Ohno E<lt>hide.o.j55 {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
