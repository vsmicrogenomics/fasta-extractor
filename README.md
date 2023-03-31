This Perl script fasta-extractor.pl is designed to extract open reading frames (ORFs) from a genomic fasta file based on the coordinates specified in an ID list file. The script takes two input files, genomic_fasta-file and id_list-file, and generates the corresponding ORF sequences based on the specified coordinates.

genomic_fasta-file is a fasta file containing genomic sequences, each starting with a header line that begins with > followed by the sequence identifier. The sequence itself follows on the next line.

id_list-file is a tab-delimited file containing the following columns: sequence identifier, start position, end position, and frame (+ or -). Each row represents the coordinates of an ORF to be extracted.

The script reads the id_list-file line by line and extracts the corresponding sequences from the genomic_fasta-file using the start and end positions specified in the id_list-file. It then generates the complementary and reverse complementary sequences, depending on the frame, and prints them to the standard output in FASTA format.

Test Files:

The script comes with two test files, genomic_fasta-file and id_list-file, which can be used to test the functionality of the script.

genomic_fasta-file contains two short genomic sequences, seq1 and seq2, with lengths of 30 and 15 nucleotides, respectively.

id_list-file contains two lines, each specifying the coordinates of an ORF to be extracted from the genomic_fasta-file.

Example Usage:

perl fasta-extractor.pl

The script generates the ORF sequences in FASTA format and prints them to the standard output.

If you are using the fasta-extractor.pl script, please cite it as follows: Sharma, V. (2023). fasta-extractor.pl [Perl script]. Retrieved from https://github.com/vsmicrogenomics/fasta-extractor
