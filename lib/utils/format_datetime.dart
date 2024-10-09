import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatDateTime{
  static DateTime selectedDate = DateTime.now();

  static DateFormat dateFormat(FormatType format){
    return DateFormat(formatType(format));
  }

  // todo lấy số ngày kế tiếp
  static DateTime nextDay(int day){
    var date = new DateTime.now();
    var now =DateTime(date.year,date.month,date.day+day);
    //var now1 =DateTime.now().add(Duration(days: day_next));// todo cách 2
    return now;
  }
  // todo lấy số tháng kế tiếp
  static DateTime nextMonth(int mount){
    var date = new DateTime.now();
    var now =DateTime(date.year, date.month+mount,date.day);
    return now;
  }
  // todo lấy số năm kế tiếp
  static DateTime nextYear(int year){
    var date = new DateTime.now();
    var now =DateTime(date.year+year, date.month,date.day);
    return now;
  }
  static DateTime dateTimeNow(){// todo ,
    var date = new DateTime.now();
    var now =DateTime(date.year, date.month,date.day,date.hour,date.minute,date.second);
    return now;
  }
  static DateTime toDateTimeFromString(String date,FormatType output){// todo ,
    try{

      return dateFormat(output).parse(date);
    }on Exception catch (_){
      print('eee');
      return DateTime.now();
    }
  }

  //TODO GET STRING
  // todo always use
  static String strFormatType(String dateInput,FormatType output){
    try{

      return dateFormat(output).format(DateTime.parse(dateInput));
    }on Exception catch (_){
      return dateInput;
    }
  }
  static String strFormatTypeInOut(String dateInput,FormatType input,FormatType output){
    try{
      DateTime dateTime = dateFormat(input).parse(dateInput);
      return dateFormat(output).format(dateTime);
    }on Exception catch (_){
      return '';
    }
  }
  // todo always use
  static String strFromDateTime(DateTime dateInput,FormatType output){
    try{
      return dateFormat(output).format(dateInput);
    }on Exception catch (_){
      return '';
    }
  }
  static String strDateFormat(String dateInput,DateFormat output){
    try{
      return output.format(DateTime.parse(dateInput));
    }on Exception catch (_){
      return '';
    }
  }
  static String strDateFormatInOut(String dateInput,DateFormat input,DateFormat output){
    try{
      DateTime dateTime = input.parse(dateInput);
      return output.format(dateTime);
    }on Exception catch (_){
      return '';
    }
  }
  // todo String  hôm nay
  static String strTodayFormatType(FormatType output){
    var now =  DateTime.now();
    return dateFormat(output).format(now);
  }
  static String strTodayFormat(DateFormat output){
    var now =  DateTime.now();
    return output.format(now);
  }


}

enum FormatType {
  dd,
  mm,
  yyyy,
  hh,
  hhMM,
  hhMMss,

  DDMMYYYY,
  DDMMYYYY_,

  MMYYYY,
  MMYYYY_,

  ddMM,

  YYYYMM,
  YYYYMM_,

  YYYYMMDD,
  YYYYMMDD_,

  DDMMYYYY_HHmm,
  DDMMYYYY_HHmmss,
  DDMMYYYY_HHmmss1,

  DDMMYYYY_HHmm_,
  DDMMYYYY_HHmmss_,
  DDMMYYYY_HHmmss_1,

  YYYYMMDDHHmm,
  YYYYMMDDHHmm1,
  YYYYMMDDHHmm_,

  YYYYMMDDHHmmss,
  YYYYMMDDHHmmss_,
  YYYYMMDD_HHmmss,
  YYYYMMDD_HHmmss_,

  YYYYMMDD_T_HHmmss,


}
String formatType(FormatType format){
  switch (format) {
    case FormatType.dd:
      return 'dd';
    case FormatType.mm:
      return 'MM';
    case FormatType.yyyy:
      return 'yyyy';
    case FormatType.ddMM:
      return 'dd/MM';
    case FormatType.hh:
      return 'hh';
    case FormatType.hhMM:
      return 'HH:mm';
    case FormatType.hhMMss:
      return 'HH:mm:ss';

    case FormatType.MMYYYY:
      return 'MM/yyyy';
    case FormatType.MMYYYY_:
      return 'MM-yyyy';

    case FormatType.YYYYMM:
      return 'yyyy/MM';
    case FormatType.YYYYMM_:
      return 'yyyy-MM';

    case FormatType.DDMMYYYY:
      return 'dd/MM/yyyy';
    case FormatType.DDMMYYYY_:
      return 'dd-MM-yyyy';

    case FormatType.DDMMYYYY_HHmmss:
      return 'dd/MM/yyyy - HH:mm:ss';
    case FormatType.DDMMYYYY_HHmmss1:
      return 'dd/MM/yyyy HH:mm:ss';

    case FormatType.DDMMYYYY_HHmmss_:
      return 'dd-MM-yyyy - HH:mm:ss';
    case FormatType.DDMMYYYY_HHmmss_1:
      return 'dd-MM-yyyy HH:mm:ss';

    case FormatType.DDMMYYYY_HHmm:
      return 'dd/MM/yyyy - HH:mm';
    case FormatType.DDMMYYYY_HHmm_:
      return 'dd-MM-yyyy - HH:mm';

    case FormatType.YYYYMMDD:
      return 'yyyy/MM/dd';
    case FormatType.YYYYMMDD_:
      return 'yyyy-MM-dd';

    case FormatType.YYYYMMDDHHmm:
      return 'yyyy/MM/dd - HH:mm';
    case FormatType.YYYYMMDDHHmm1:
      return 'yyyy/MM/dd HH:mm';
    case FormatType.YYYYMMDDHHmm_:
      return 'yyyy-MM-dd - HH:mm';

    case FormatType.YYYYMMDDHHmmss:
      return 'yyyy/MM/dd - HH:mm:ss';
    case FormatType.YYYYMMDD_HHmmss:
      return 'yyyy/MM/dd HH:mm:ss';

    case FormatType.YYYYMMDDHHmmss_:
      return 'yyyy-MM-dd - HH:mm:ss';
    case FormatType.YYYYMMDD_HHmmss_:
      return 'yyyy-MM-dd HH:mm:ss';

    case FormatType.YYYYMMDD_T_HHmmss:
      return 'yyyy-MM-ddTHH:mm:ss';

    default:
      return '';
  }


}