import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


void HandleDioException(DioException e) {
  debugPrint("DIO ERROR => ${e.type}, message: ${e.message}");

  if (e.response != null) {
    debugPrint("STATUS CODE => ${e.response?.statusCode}");
    debugPrint("RESPONSE DATA => ${e.response?.data}");
  }

  switch (e.type) {
  /* case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.connectionError:
    //  throw ErrorModel(message: "الرجاء التحقق من اتصال الإنترنت");
     throw "الرجاء التحقق من اتصال الإنترنت";
*/
    case DioExceptionType.connectionTimeout:
      throw "انتهى وقت الاتصال بالخادم. حاول مرة أخرى لاحقًا.";

    case DioExceptionType.sendTimeout:
      throw "الخادم لم يستجب بسرعة كافية. تأكد من الاتصال أو حاول لاحقًا.";

    case DioExceptionType.receiveTimeout:
      throw "الخادم لم يُرسل البيانات في الوقت المحدد.";

    case DioExceptionType.badCertificate:
      throw "حدثت مشكلة في شهادة الأمان الخاصة بالخادم.";

    case DioExceptionType.connectionError:
      throw "تعذر الاتصال بالخادم. تحقق من الإنترنت.";


    case DioExceptionType.cancel:
    //  throw ErrorModel(message: "تم إلغاء الطلب");
      throw "تم إلغاء الطلب";

    case DioExceptionType.unknown:
    // throw ErrorModel(message: "حدث خطأ غير معروف");
      throw "حدث خطأ غير معروف";

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final serverMessage = e.response?.data?['message'] ?? "خطأ غير معروف";

      if (statusCode == 401) {
        //   throw ErrorModel(message: "غير مصرح");
        throw "غير مصرح";
      }
      if (statusCode == 400) {
        //   throw ErrorModel(message: "غير مصرح");
        throw "البيانات  المدخلة غير صحيحة";
      }
      else if (statusCode == 404) {
        // throw ErrorModel(message: "العنصر غير موجود");
        throw "العنصر غير موجود";
      } else if (statusCode == 500) {
        //   throw ErrorModel(message: "خطأ في الخادم");
        throw "خطأ في الخادم";
      }

      //  throw ErrorModel(message: serverMessage);
      throw serverMessage;

    default:
    // throw ErrorModel(message: "حدث خطأ أثناء الاتصال");
      throw "حدث خطأ أثناء الاتصال";
  }
}
