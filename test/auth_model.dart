import 'auth_model.dart';
import 'auth_model.dart';

class Auth {
  final String H;
  final String M;
  final List<A> a;
  final int I;

  Auth({required this.H, required this.M, required this.a, required this.I});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['H'] = H;
    data['M'] = M;
    data['A'] = a.map((v) => v.toJson()).toList();
    data['I'] = I;
    return data;
  }
}

class A {
  final String userLogin;
  final String userPassword;
  final String connectionId;
  final String allowedToBrodcastEvents;

  A(
      {required this.userLogin,
      required this.userPassword,
      required this.connectionId,
      required this.allowedToBrodcastEvents});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserLogin'] = userLogin;
    data['UserPassword'] = userPassword;
    data['ConnectionId'] = connectionId;
    data['AllowedToBrodcastEvents'] = allowedToBrodcastEvents;
    return data;
  }
}
