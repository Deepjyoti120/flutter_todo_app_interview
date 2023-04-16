class DesignUtils {
  static bool isSameDateTime(DateTime dateTime,DateTime currentdateTime ) {
    bool isSameDate = currentdateTime.year == dateTime.year &&
        currentdateTime.month == dateTime.month &&
        currentdateTime.day == dateTime.day;
    return isSameDate;
  }
}
