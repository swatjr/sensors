from __future__ import unicode_literals
import os
import traceback
import tanium
from collections import Counter
from datetime import datetime

def sensor_main():
    givenString = "comply.assessment"
    data = []

    with open(
        f"C:/Program Files (X86)/Tanium/Tanium Client/Logs/extensions0.txt", "r"
    ) as filedata:
        # Collect all relevant lines containing the givenString
        for line in filedata:
            if givenString in line:
                data.append(line[0:10])
    
        # Convert date strings to datetime objects
        date_objects = [datetime.strptime(date, "%Y-%m-%d").date() for date in data]
        date_count = Counter(date_objects)
        
        # Collect results into a list
        result_lines = []
        for date, count in date_count.items():
            result_lines.append(f"{date}:{count}")
        
        # Join the results into a single string and return
        return "\n".join(result_lines)

if __name__ == "__main__":
    try:
        result = sensor_main()

        print(result, flush=True)
        tanium.results.add(result)

    except Exception as error:
        tanium.results.add(f"TSE Error: {error}")
