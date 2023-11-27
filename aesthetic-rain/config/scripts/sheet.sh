#!/usr/bin/python3
# IMPORT #
import csv
import os
import sys

# VARIABLES #
COLUMNS_TO_KEEP = ["Transaction Type", "Order Id", "Quantity", "Ship To State", "Invoice Amount", "Tax Exclusive Gross", "Total Tax Amount", "Cgst Tax", "Sgst Tax", "Igst Tax", "Shipping Amount", "Shipping Amount Basis", "Shipping Cgst Tax", "Shipping Sgst Tax", "Shipping Igst Tax"]
COLUMNS_TO_ADD = ["Invoice Amount", "Tax Exclusive Gross", "Total Tax Amount", "Cgst Tax", "Sgst Tax", "Igst Tax", "Shipping Amount", "Shipping Amount Basis", "Shipping Cgst Tax", "Shipping Sgst Tax", "Shipping Igst Tax"]

# FUNCS #
def print_data(data, headings="", *args):
    if headings:
        for value in headings:
            print(value, end="\t")
        print()
    for row in data:
        for value in row:
            print(value, end="\t")
        print()
    
    for arg in args:
        print(arg)


def get_data(file):
    assert os.path.isfile(file), f"\"{file}\" is not a file."
    
    with open(file) as f:
        data = list(csv.reader(f))
    return data[0], data[1::]


def get_column(name, headings, data):
    assert (name in headings), f"Column \"{name}\" not found."

    index = headings.index(name)
    return [item[index] for item in data], index


def remove_rows(column_name, values_to_remove, headings, data):
    assert (column_name in headings), f"Column \"{column_name}\" not found."
    
    column, index = get_column(column_name, headings, data)
    new_data = []
    for row in data:
        if row[index] not in values_to_remove:
            new_data.append(row)
    return new_data


def remove_column(column_name, headings, data):
    assert (column_name in headings), f"Column \"{column_name}\" not found."
    
    index = headings.index(column_name)
    for row in data:
        row.pop(index)
    headings.pop(index)
    return headings, data


def remove_duplicates(column_name, headings, data):
    assert (column_name in headings), f"Column \"{column_name}\" not found."
    
    column, index = get_column(column_name, headings, data)
    values_to_remove = []
    
    for i in range(len(column)):
        for j in range(i+1, len(column)):
            if column[i] == column[j]:
                values_to_remove.append(column[i])
    
    return remove_rows(column_name, values_to_remove, headings, data)


def add_total_row(headings, data):
    new_row = ["" for x in range(len(headings))]
    new_row[0] = "Total"
    for heading in headings:
        if heading in COLUMNS_TO_ADD:
            index = headings.index(heading)
            sum = 0
            for row in data:
                sum += eval(row[index])
            new_row[index] = sum
    data.append(new_row)
    return data


if __name__ == "__main__":
    filename = sys.argv[1]
    if filename in ["--help", "-h", ""]:
        print("Usage: sheet <filename>")
        sys.exit(0)
    headings, data = get_data(filename)
    
    print("Removing duplicate values...")
    data = remove_duplicates("Order Id", headings, data)
    print("Removing cancelled, refunded, and replaced items...")
    data = remove_rows("Transaction Type", ["Cancel", "Refund", "FreeReplacement"], headings, data)
    headings_copy = list(headings)
    
    print("Removing useless columns...")
    for heading in headings_copy:
        if heading not in COLUMNS_TO_KEEP:
            headings, data = remove_column(heading, headings, data)
    
    add_total_row(headings, data)
    
    data.insert(0, headings)
    with open(f"{filename}-FORMATTED.csv", "w") as f:
        w = csv.writer(f)
        w.writerows(data)
    
    print("✓ Done!")
