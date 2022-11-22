import csv
import subprocess

output_folder_name = "outputs/"
input_folder_name = "inputs/"
import os

def generate_file(template, id, user):
    filename = f"{output_folder_name}{f'interview_call_letter_{id}.tex'}"
    print('FILENAME = ' + filename)
    with open(filename, 'w') as latex_file:
        latex = template.replace(r'\VAR{USER}', user)
        latex_file.write(latex)
    print(f'Generated {filename}')
    # os.system(f'pdflatex -output_directory={output_folder_name} {filename}')
    os.system(f'pdflatex {filename}')

    # subprocess.run(['pdflatex', '-pdf', filename])

with open(input_folder_name+'template.tex') as template_file:
    global latex_code
    latex_code = template_file.read()
    print (latex_code)

with open(input_folder_name+'input.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}')
            line_count += 1
        else:
            generate_file(latex_code, row[0], row[1])
            line_count += 1
    print(f'Processed {line_count} lines.')
