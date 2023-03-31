#!/usr/bin/perl
#
# fasta-extractor.pl
#
# Author: Vikas Sharma
# This script extracts open reading frames (ORFs) from a genomic fasta file based on the coordinates specified
# in an ID list file. The script takes two input files, genomic_fasta-file and id_list-file, and generates the
# corresponding ORF sequences based on the specified coordinates.
#
# Usage: perl fasta-extractor.pl
#
# Input:
#   genomic_fasta-file: a fasta file containing genomic sequences, each starting with a header line that begins
#                       with > followed by the sequence identifier. The sequence itself follows on the next line.
#   id_list-file: a tab-delimited file containing the following columns: sequence identifier, start position,
#                 end position, and frame (+ or -). Each row represents the coordinates of an ORF to be extracted.
#
# Output: The script generates the ORF sequences in FASTA format and prints them to the standard output.
#
# Test Files:
#   The script comes with two test files, genomic_fasta-file and id_list-file, which can be used to test the
#   functionality of the script.
#
# Example Usage: perl fasta-extractor.pl

$file_id = "id_list-file"; # Input file containing the IDs and coordinates
open(FH_id, $file_id);

@arr_id = <FH_id>;

$file_seq = "genomic_fasta-file"; # Input file containing the genomic sequences
open(FH_seq, $file_seq);

@arr_seq = <FH_seq>;

foreach $line_id (@arr_id) {
	chomp $line_id;
	if ($line_id =~ /(\w+)\t(\d+)\t(\d+)\t(\S+)/) {
		my $id = $1;
		my $start = $2;
		my $end = $3;
		my $frame = $4;

		# If start is greater than end, swap them
		if ($start > $end) {
			my $temp = $end;
			$end = $start;
			$start = $temp;
		}

		my $seq;
		my $seq_comp;
		my $seq_rc;
		my $i = 1;

		foreach $line_seq (@arr_seq) {
			chomp $line_seq;
			# If the line contains the sequence header, store the current sequence ID and skip it
			if ($line_seq =~ /^>(.*)/) {
				$current_seq_id = $1;
				next;
			}

			# If the current sequence ID matches the ID in the id_list-file and the start and end coordinates are within the sequence boundaries, extract the ORF
			if ($current_seq_id eq $id && $start >= 1 && $end <= length($line_seq)) {
				$seq = substr($line_seq, $start-1, $end-$start+1);

				# Generate the complementary sequence
				$seq_comp = $seq;
				$seq_comp =~ tr/ACGTacgt/TGCAtgca/;

				# Generate the reverse complementary sequence
				$seq_rc = reverse $seq_comp;

				# Print the ORF sequence to the terminal
				if ($frame eq '+') {
					print(">ORF$i\n$seq\n");
				}
				else {
					print(">ORF$i\n$seq_rc\n");
				}
				$i++;
			}
		}
	}
}

# Close the input files
close(FH_id);
close(FH_seq);
