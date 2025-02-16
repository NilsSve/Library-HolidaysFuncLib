# Library-HolidaysFuncLib

What is the function library for "Holidays and other special dates"?

The library consists of holiday & special day functions for most parts of the Western world.
There are two types of functions/usages of this library.
     
     1. First there are a series of functions that returns the date for a given holiday
        function, given a certain year.
        
        The library consists of a series of named holiday functions that all returns a date.
        The functions takes two parameters;
            a) An integer iYear
            b) A 2-character string sISO_Short country code 
        Returns: A date    
        Example: "Get EasterDay of ghoCalendarHolidays 2025 "US" to dDate"
        The country code is needed as some holidays falls on different dates in
        different countries.
        
        Not all of the functions needs the country code, but you can pass the
        country code for all functions calls, to have a unified calling interface.
        
        All 2-character sISO_Short codes can be seen near the bottom of the cCalendarHolidays.pkg
        file; "Procedure AddAllOfficialShort", or by getting the 'pAllISOCodes'
        struct array property.
     
     2. Secondly there is the 'IsHoliday' function that returns the name of a 
        holiday/special day, given a certain date.
        It take on three parameters;
            a) A date (could be return value from 1. above)
            b) A 2-character string sISO_Short country code. Same as in 1. above.
            c) A ByRef boolean parameter that will be true if the date is a holiday/bankday.
               Remember that there are also special days like e.g. "Mother's Day" that
               is not a holiday.
        Returns: A holiday name as a string, and sets the ByRef param to True/False.
        Example: "Get IsHoliday of ghoCalendarHolidays 03/16/2025 "US" (&bIsHoliday) to sHolidayName"
        The 'IsHoliday' function of this class in its turn, calls an 'IsHoliday' function for the
        passed ISO_Short value for the correct country packages found in CountryPackages.pkg file.
        The CountryPackages.pkg is included in the oCalendarHolidays function library object.
        
        Note: If your country does not exist in CountryPackages.pkg you are encouraged to
              create one by looking at the existing packages AND email the package
              to support@rdctools.com.
     
     The global handle ghoCalendarHolidays can be used to access all functions.
              
     The cCalendarHolidays class consist of helper date functions for the holiday
     function library: oCalendarHolidays.pkg (object). This object also contains
     the code for all country packages found in CountryPackages.pkg.

Use the HolidayFuncLibDemo repo to showcase how this library can be used.


