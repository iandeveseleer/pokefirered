import re
import json

# Define the file path
file_path = 'trainer_class_names.h'

# Initialize an empty list to hold the species data
species_data = []

# Regular expression to match the required pattern
pattern = re.compile(r'\[\s*(TRAINER_CLASS_\w+)\s*\]\s*=\s*_?\("([^"]+)"\)')

# Read the file
with open(file_path, 'r') as file:
    for line in file:
        match = pattern.search(line)
        if match:
            species_id = match.group(1)  # Extract species ID (e.g., TRAINER_CLASS_NONE)
            english_name = match.group(2)  # Extract the English name

            # Create a JSON object
            species_entry = {
                'trainerClassId': species_id.replace('TRAINER_CLASS_', ''),  # Remove TRAINER_CLASS_ prefix
                'english': english_name,
                'french': english_name  # Assuming the same name for French; modify if needed
            }

            # Append to the list
            species_data.append(species_entry)

# Convert the list to JSON
json_output = json.dumps(species_data, indent=4)

# Print or save the JSON output
print(json_output)
# Optionally save to a file
with open('trainers_names.json', 'w') as json_file:
    json_file.write(json_output)
