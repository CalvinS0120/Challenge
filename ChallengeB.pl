#! /usr/bin/perl
# Calvin Seol
# Biol 430
# Challenge B

use strict;
use warnings;

# Overview
# Script accepts a file within the same directory
# Returns comma-delimited, 5-column table
#	Column 1: Protein Length
#	Column 2: Starting AA
#	Column 3: 1st Common AA
#	Column 4: 2nd Common AA
#	Column 5: 3rd Common AA
# Each sequence is printed in individual rows
#	
#	Header: Protein Length, Starting AA, 1st Common AA, 2nd Common AA, 3rd Common AA
#
# General approach:
#	1. Open the file for reading and loop through it line by line
#	2. Print the column header lines for the table
# 	3. Store the header and sequence for each fasta entry
#	4. After each new header:
#		i. Count protein sequence length
#		ii. Determine first AA character in the sequence
#		iii. Count how many instances of each unique AA character
#		iv. Skip non-letter residues
#		v. Determine 1st, 2nd, and 3rd most common AA characters in each sequence
#		vi. Print the values for the sequence in its own row
#	5. Clear the sequence variable and store the new header
#	6. Repeat steps 4-5 until the end of the file
#	7. After the entire file has been read, do the same thing for the last sequence and print


# Read file from STDIN
my $infile = "$ARGV[0]";

#Initialize header and sequence
my $seq = "";
my $header = "";

# Open the file or interrupt
open (my $File, "<", "$infile") or die "Can't open file $infile!";

# Print column header lines for the table
print "Protein Length, Starting AA, 1st Common AA, 2nd Common AA, 3rd Common AA\n";

# Loop over file line by line
while (my $line = <$File>) {
	# Remove the line ending
	chomp $line;
	# Test if this is a header line
	if ($line =~ m/^>/) {
		# Header line exists and sequence is stored
		if ($seq ne "") {
			
			# Capitalizes the entire sequence so no lower cases are printed
			$seq = uc($seq);
			
			# Counts protein sequence length and assigns variable
			my $length = length $seq;
			
			# Determine first AA character in each sequence and assign variable
			my $firstAA = substr($seq, 0, 1);
			
			# Determine the 3 most common AA characters and assign each a variable		
			# Initializes hash to store amino acid counts
			my %aaCount;
			
			# Splits sequences to differentiate each amino acid residue
			my @aaChunked = split(//, "$seq");
			
			# Loops through sequence and counts instance of each unique Amino Acid
			# Skips non-letter residues, such as "/" or "-""
			foreach my $AA (@aaChunked) {
				if ($AA =~ /[ABCDEFGHIJKLMNOPQRSTUVWXYZ]/) {
					$aaCount{$AA}++;
				} else {
					next}
			}
			
			# Initializes array for numerically sorted AA list
			# Sorts sequence in descending numerical order
			my @sorted_AA = sort { $aaCount{$b} <=> $aaCount{$a} } keys(%aaCount);
			
			# Initializes most common, second most common, and third most common to
			# separate variables
			# Redundant code but added for clarity
			my $firstCommonAA = $sorted_AA[0];
			my $secondCommonAA = $sorted_AA[1];
			my $thirdCommonAA = $sorted_AA[2];
									
			# Prints values for the sequence
			print "$length, $firstAA, $firstCommonAA, $secondCommonAA, $thirdCommonAA\n";
			
			$seq = "";
		}
		$header = "$line"
	} else {
		$seq = "$seq" . lc("$line")
	}
	
}

# Last sequence

# Capitalize sequence again so no lower cases are printed
$seq = uc($seq);

# Counts protein sequence length and assigns variable
my $length = length $seq;

# Determine first AA character of the last sequence and assign variable
my $firstAA = substr($seq, 0, 1);

# Determine 3 most common AA characters for the last sequence and assign each a variable
# Initializes hash to store amino acid counts
my %aaCount;
			
# Splits sequences to differentiate each amino acid residue			
my @aaChunked = split(//, "$seq");

# Loops through sequence and counts instance of each unique Amino Acid	
# Skips non-letter residues, such as "/" or "-""		
foreach my $AA (@aaChunked) {
	if ($AA =~ /[ABCDEFGHIJKLMNOPQRSTUVWXYZ]/) {
		$aaCount{$AA}++;
	} else {
		next}
}

# Initializes array for numerically sorted AA list
# Sorts sequence in descending numerical order			
my @sorted_AA = sort { $aaCount{$b} <=> $aaCount{$a} } keys(%aaCount);

# Initializes most common, second most common, and third most common to separate variables
# Redundant code but added for clarity			
my $firstCommonAA = $sorted_AA[0];
my $secondCommonAA = $sorted_AA[1];
my $thirdCommonAA = $sorted_AA[2];

# Prints the values for the last sequence
print "$length, $firstAA, $firstCommonAA, $secondCommonAA, $thirdCommonAA\n";