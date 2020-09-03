class DateConverter {
  String intToStrMonth(int intMonth) {
    String strMonth = "Jan";
    if (intMonth == 1) strMonth = "Jan";
    if (intMonth == 2) strMonth = "Feb";
    if (intMonth == 3) strMonth = "Mar";
    if (intMonth == 4) strMonth = "Apr";
    if (intMonth == 5) strMonth = "May";
    if (intMonth == 6) strMonth = "Jun";
    if (intMonth == 7) strMonth = "Jul";
    if (intMonth == 8) strMonth = "Aug";
    if (intMonth == 9) strMonth = "Sep";
    if (intMonth == 10) strMonth = "Oct";
    if (intMonth == 11) strMonth = "Nov";
    if (intMonth == 12) strMonth = "Dec";
    return strMonth;
  }

  String dateToStrDate(DateTime date) {
    String year = date.year.toString();
    String month = intToStrMonth(date.month);
    String day = date.day.toString();

    String fullDate = day + " " + month + " " + year;
    return fullDate;
  }
}
