import 'package:chairil/domain/models/error_response.dart';

class ErrorHandlingResponse {
  final ErrorResponse errorResponse;
  final bool showMessage;

  ErrorHandlingResponse({required this.errorResponse, this.showMessage = true});

  Future checkErrror() async {
    // CoreFunction.logPrint("Error Code", errorResponse.code);
    switch (errorResponse.code) {
      case 400:
        // if (showMessage) Component.toastInfo(errors.detail ?? "");
        break;
      case 401:
        // Component.toastInfo("Anda sudah login di ponsel berbeda");
        // AppDatabase.deleteDatabase();
        // pushAndRemoveUntil(const LoginView());
        break;
      default:
      // Component.toastInfo(errors.detail ?? "");
    }
  }
}
