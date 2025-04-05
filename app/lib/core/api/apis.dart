
import '../util/constants.dart';

enum Apis implements AppConstants {
  login("auth/login"),
  register("auth/register"),
  booking("booking"),
  massage("massage"),
  history("booking/user/{id}")
  ;

  @override
  final String value;

  const Apis(this.value);

  String path({Map<String, dynamic>? params}) {
    String result = value;

    if (params != null) {
      params.forEach((key, value) {
        result = result.replaceAll('{$key}', value.toString());
      });
    }

    return result;
  }
}
