import csv

print('supply path for notenblatt')

# Path to your CSV file
csv_file = input()

def calculate_marks(csv_file):
    try:
        with open(csv_file, newline='') as file:
            reader = csv.reader(file)
            headers = next(reader)  # Skip the header row

            # Read and store the "Max" row for max scores
            max_row = next(reader)
            max_scores = [float(value) for value in max_row[1:]]  # Convert to float for calculations
            max_total_score = sum(max_scores)

            print("Name, Total Score, Mark")

            for row in reader:
                # Calculate total score for each student based on "Max" scores
                total_score = 0
                for i in range(1, len(row)):
                    value = row[i]
                    if value == "":
                        value = 0
                    total_score += float(value)

                mark = round(total_score / max_total_score * 5 + 1, 1)  # Calculate mark

                # Print name, total score, and mark
                print(f"{row[0]}, {total_score}, {mark}")

            print(f"max score: {max_total_score}")

    except FileNotFoundError:
        print(f"File {csv_file} not found.")
    except Exception as e:
        print("An error occurred:", e)


# Call the function with the path to your CSV file
calculate_marks(csv_file)
