# Library-HolidaysFuncLib

**Function Library for Holidays and Special Dates**

This library provides holiday and special day functions for various regions in the Western world. There are three primary types of functions available in this library:

1. **Holiday Date Functions**: These functions return the date of a specific holiday for a given year. Each function requires two parameters:
   - **iYear**: An integer representing the year.
   - **sISO_Short**: A 2-character string representing the country code.

   The return value is a date. 

   **Example**: To get Easter for the year 2025 in the US, you would use:
   ```
   Get EasterDay of ghoCalendarHolidays 2025 "US" to dDate
   ```

   The country code is necessary because some holidays are observed on different dates in various countries. While not all functions need the country code, it can be provided for consistency across all function calls. A list of all 2-character ISO Short codes can be found in the `cCalendarHolidays.pkg` file under the procedure "AddAllOfficialShort," or by accessing the `pAllISOCodes` struct array property.  The `WindowsLocaleISO_Short` function can be utilized to determine the Windows locale ISO Short 2-character code for the current machine.

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

4. **Working-day Functions**: For delivery dates, due dates and lead times. A working day is a day that is not a weekend day, not an official holiday in the country, and not a company closure day.
   - `IsWorkingDay dDate sISO_Short` returns True or False.
   - `AddWorkingDays dDate iDays sISO_Short` returns the date `iDays` working days later, or earlier when `iDays` is negative. The start date itself is not counted, as in Excel's `WORKDAY`: Friday + 1 is Monday.
   - `WorkingDaysBetween dStart dEnd sISO_Short` counts the working days from one date to the other, both days included, as Excel's `NETWORKDAYS` counts them. It is negative when the end date comes first.

   **Example**: The date ten working days after an order date, in Sweden:
   ```
   Get AddWorkingDays of ghoCalendarHolidays dOrderDate 10 "SE" to dDueDate
   ```

   Pass `""` as the country code to count weekends and closure days only. Three properties of `ghoCalendarHolidays` adjust the count:
   - `psWeekendMask`: the days off of the week, Monday to Sunday, with 1 for a day off. The default `"0000011"` is Saturday and Sunday; `"0000110"` is Friday and Saturday.
   - `padClosedDays`: a list of dates the company is closed, such as a Christmas week. For a rule rather than a list, augment the `IsClosedDay` function.
   - `piHolidayRegion`: for a country whose holidays differ by region. In the UK the default is England and Wales; `BrittishHolidays.pkg` defines `CI_UKRegionScotland`, `CI_UKRegionNorthernIreland` and `CI_UKRegionAny`:
     ```
     Set piHolidayRegion of ghoCalendarHolidays to CI_UKRegionScotland
     ```

   Only official holidays count: a special day such as Christmas Eve in Sweden is a working day unless it is listed in `padClosedDays`.

  The global handle `ghoCalendarHolidays` provides access to all functions, while the `cCalendarHolidays` class contains helper date functions related to the holiday function library, encapsulated in the `oCalendarHolidays.pkg` object. This object also holds the code for all country packages found in `CountryPackages.pkg`.

## Unit tests

`AppSrc\UnitTests.src` is the unit-test program of the library, built on
[DFUnit](https://github.com/NilsSve/Library-DFUnit). Run `setup.bat` once: it clones DFUnit beside this folder
(`..\DFUnit`). Then open `HolidaysFuncLibDev26.0.sws` (or `25.0` / `24.0`) and build `UnitTests.src`. The
`HolidaysFuncLib<version>.sws` files and the DataFlex 26 package, which other workspaces use the library
through, do not know DFUnit.

The tests are in `AppSrc\o<Subject>-Tests.pkg`, one file per subject, and `AppSrc\oUnit_Tests.pkg` lists them.
The first file checks holiday dates against the calendar - Easter in known years and the days it moves, Advent,
the US holidays fixed by weekday, the Swedish Midsummer - and the date helpers `IsLeapYear`, the ISO week at
New Year and `Ordinal`. `Programs\UnitTests64.exe -c` runs them on the console (exit code 0 when all passed).

For demonstration of how to use this library, please refer to the `HolidayFuncLibDemo` repository.


