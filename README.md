# Library-HolidaysFuncLib

**Function Library for Holidays and Special Dates**

This library provides holiday and special day functions for various regions in the Western world. There are two primary types of functions available in this library:

1. **Holiday Date Functions**: These functions return the date of a specific holiday for a given year. Each function requires two parameters:
   - **iYear**: An integer representing the year.
   - **sISO_Short**: A 2-character string representing the country code.

   The return value is a date. 

   **Example**: To get Easter for the year 2025 in the US, you would use:
   ```
   Get EasterDay of ghoCalendarHolidays 2025 "US" to dDate
   ```

   The country code is necessary because some holidays are observed on different dates in various countries. While not all functions need the country code, it can be provided for consistency across all function calls. A list of all 2-character ISO Short codes can be found in the `cCalendarHolidays.pkg` file under the procedure "AddAllOfficialShort," or by accessing the `pAllISOCodes` struct array property.

2. **Holiday Name Function**: This function returns the name of a holiday or special day given a specific date. It requires three parameters:
   - A date (this can be the return value from the holiday date functions).
   - A 2-character string `sISO_Short` country code (as described above).
   - A ByRef boolean parameter that indicates whether the date is a holiday or bank day.

   This function also provides special days that may not be considered holidays, such as "Mother's Day." 

   **Example**: To get the holiday name on March 16, 2025, in the US, you would use:
   ```
   Get HolidayName of ghoCalendarHolidays 03/16/2025 "US" (&bIsHoliday) to sHolidayName
   ```

   The `HolidayName` function within this library calls an `HolidayName` function relevant to the corresponding ISO Short code for the country packages defined in the `CountryPackages.pkg` file. If your country is not represented in `CountryPackages.pkg`, you can create one by reviewing the existing packages and emailing it to support@rdctools.com.

3. **Reciprocal Function**: The library includes a reciprocal function to the holiday date functions, named `IsDateAHoliday`. It takes a date and an ISO Short code parameter, returning a boolean value of True or False to indicate whether the date corresponds to a recognized holiday. Additionally, it uses three ByRef parameters: 
   - Boolean `bIsHoliday`
   - String `sHolidayName`
   - String `sFunctionName`

   The `WindowsLocaleISO_Short` function can be utilized to determine the Windows locale ISO Short 2-character code for the current machine. The global handle `ghoCalendarHolidays` provides access to all functions, while the `cCalendarHolidays` class contains helper date functions related to the holiday function library, encapsulated in the `oCalendarHolidays.pkg` object. This object also holds the code for all country packages found in `CountryPackages.pkg`.

For demonstration of how to use this library, please refer to the `HolidayFuncLibDemo` repository.


