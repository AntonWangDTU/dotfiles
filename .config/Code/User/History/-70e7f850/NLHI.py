#!/bin/python3

import sys
import re

# Dictionary to map DNA bases to their complements, including 'n'
complement_map = {
    'a': 't',
    't': 'a',
    'c': 'g',
    'g': 'c',
    'N': 'N',  # Handling ambiguous base 'n' or 'N'
    'n': 'n'   # If lowercase 'n' exists
}

def complement_dna(sequence):
    """Return the complement of a DNA sequence."""
    return ''.join(complement_map.get(base, base) for base in sequence)

def count_bases(sequence):
    """Count occurrences of each base (A, T, C, G, N) in the sequence."""
    counts = {
        'A': 0,
        'T': 0,
        'C': 0,
        'G': 0,
        'N': 0
    }
    for base in sequence:
        base_upper = base.upper()  # Make sure to handle both uppercase and lowercase bases
        if base_upper in counts:
            counts[base_upper] += 1
    return counts

def process_fasta(input_fasta):
    """Process input FASTA file and return a list of headers, complementary sequences, and base counts."""
    headers = []
    sequences = []
    base_counts = []
    current_sequence = []

    for line in input_fasta:
        line = line.strip()

        if line.startswith('>'):
            if current_sequence:
                sequences.append(''.join(current_sequence))
                current_sequence = []
            headers.append(line)
        else:
            current_sequence.append(line)

    if current_sequence:
        sequences.append(''.join(current_sequence))

    # Generate complement sequences and count bases
    complement_sequences = [complement_dna(seq) for seq in sequences]
    base_counts = [count_bases(seq) for seq in sequences]

    return headers, complement_sequences, base_counts

def write_fasta(headers, sequences, base_counts, output_fasta):
    """Write headers (with base counts) and sequences to the output FASTA file."""
    for header, sequence, counts in zip(headers, sequences, base_counts):
        # Append base counts to the header
        count_str = f"A:{counts['A']} T:{counts['T']} C:{counts['C']} G:{counts['G']} N:{counts['N']}"
        output_fasta.write(f"{header} {count_str}\n")
        # Split sequence into lines of 60 characters as per FASTA format
        for i in range(0, len(sequence), 60):
            output_fasta.write(sequence[i:i+60] + "\n")

if __name__ == "__main__":
    # Check if input and output file paths are provided
    if len(sys.argv) != 3:
        print("Usage: python complement_dna.py <input_fasta> <output_fasta>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    # Open input and output files
    with open(input_file, 'r') as input_fasta, open(output_file, 'w') as output_fasta:
        headers, complement_sequences, base_counts = process_fasta(input_fasta)
        write_fasta(headers, complement_sequences, base_counts, output_fasta)

    print(f"Complement DNA sequences with base counts have been written to {output_file}")
