import os
import matplotlib.pyplot as plt
import seaborn as sns

# Path to the directory containing .tsv files
pathtolook = "/QRISdata/Q7250/zero_only_seq"

# Initialize counters
total_sequences = 0
length_counts = {}

# Read each .tsv file in the directory
for filename in os.listdir(pathtolook):
    if filename.endswith(".tsv"):
        file_path = os.path.join(pathtolook, filename)
        
        # Read the file line by line
        with open(file_path, 'r') as file:
            for line in file:
                sequence = line.strip()
                seq_length = len(sequence)
                total_sequences += 1
                if seq_length in length_counts:
                    length_counts[seq_length] += 1
                else:
                    length_counts[seq_length] = 1

# Write the results to a file
output_file = "sequence_counts.txt"
with open(output_file, 'w') as out_file:
    out_file.write(f"Total number of sequences: {total_sequences}\n")
    for length, count in length_counts.items():
        out_file.write(f"Length {length}: {count} sequences\n")

# Print the total number of sequences (optional)
print(f"Results have been written to {output_file}")

# Create a bar plot
lengths = list(length_counts.keys())
counts = list(length_counts.values())

plt.figure(figsize=(10, 6))
sns.barplot(x=lengths, y=counts, palette="viridis")
plt.xlabel('Length of sequences (amino acids)')
plt.ylabel('Sequence count')
plt.title('Sequence Length Distribution')

# Save the bar plot
output_image = "sequence_length_distribution.png"
plt.savefig(output_image)

# Display the bar plot
plt.show()

# Print the path of the saved image (optional)
print(f"The histogram has been saved to {output_image}")
