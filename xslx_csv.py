import xlrd
import csv
import glob
import pandas as pd

excel_files = glob.glob('./raw_data/*xlsx*')

def replaceMultiple(mainString, toBeReplaces, newString):
	for elem in toBeReplaces :
		if elem in mainString :
			mainString = mainString.replace(elem, newString)
    
    return  mainString


for excel_file in excel_files:
    print("Converting '{}'".format(excel_file))
    try:
        df = pd.read_excel(excel_file)
        temp_nm = replaceMultiple(excel_file, ['.', '-', '(', ')', '/'], ' ')
        temp_nm = temp_nm.split(' ')[:-1]
        file_nm = filter(None, temp_nm)
        output = '_'.join(file_nm) + '.csv'
        df.to_csv('./raw_data/' + output)    
    except KeyError:
        print("  Failed to convert")

