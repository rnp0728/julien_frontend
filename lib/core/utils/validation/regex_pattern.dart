class RegExPattern {
  static String emailPattern =
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
  static String emailPtrn = r'^[\w-]+@([\w-]+\.)+[\w-]+$';

  static String phonePattern =
      r'(^(?:[+0]9)?[0-9]{10,12}$)';

  static String filePattern =
      r'(?<file>[\w/.]+)\s(?<line>\d+):(?<column>\d+)\s';

  static String datePattern =
      r'(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[0-2])-(19|20)\d{2}';
}
