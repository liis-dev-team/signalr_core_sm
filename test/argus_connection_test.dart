import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:test/scaffolding.dart';

import 'auth_model.dart';
import 'first_response_model.dart';

void main() {
  test('login to argus server', () async {
    // Build our app and trigger a frame.

    final url = '93.171.134.34:8070';
    final basePath = '/signalr/negotiate';
    final headers = {
      'Accept-Encoding': 'gzip, deflate',
      'Accept-Language': 'ru-RU,ru;q=0.9',
      'Origin': 'http://testapi.streletz.ru:8080',
      'Access-Control-Allow-Origin': 'http://testapi.streletz.ru:8080'
    };

    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    Uint8List cert =
        await File('test_resource/childcert56311_5.pem').readAsBytes();
    securityContext.setTrustedCertificatesBytes(cert);
    HttpClient client = HttpClient(context: await securityContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);

    final Uri firstRequest = Uri.http(url, basePath, {
      'clientProtocol': '1.5',
      'connectionData': "[{'name': 'commonhub'}]",
      '_': '${DateTime.now().millisecondsSinceEpoch}'
    });
    final response = await ioClient.get(firstRequest, headers: headers);

    FirstResponseModel firstResponseModel =
        FirstResponseModel.fromMap(json.decode(response.body));
    print('response.body');
    print(response.body);

    final connection = HubConnectionBuilder()
        .withUrl(
            'http://93.171.134.34:8070/signalr',
            HttpConnectionOptions(
              customHeaders: headers,
              client: ioClient,
              transport: HttpTransportType.webSockets,
              skipNegotiation: true,
              accessTokenFactory: () =>
                  Future.value(firstResponseModel.connectionToken),
              logging: (level, message) => print(message),
            ))
        .withConnectionData('commonhub')
        .build();

    await connection.start();

    final Uri secondRequest = Uri.http(url, basePath, {
      'clientProtocol': '1.5',
      'transport': 'webSockets',
      'connectionToken': firstResponseModel.connectionToken,
      'connectionData': "[{'name': 'commonhub'}]",
      '_': '${DateTime.now().millisecondsSinceEpoch}'
    });
    final secondResponse = await ioClient.get(secondRequest, headers: headers);

    Auth a = Auth(
        H: 'commonhub',
        M: 'authenticateAndGetClientData',
        I: 0,
        a: [A(
            userLogin: 'web1',
            userPassword: 'IntegralWeb1',
            connectionId: firstResponseModel.connectionId,
            allowedToBrodcastEvents: 'null')]);

    connection.invoke('authenticateAndGetClientData', [a]);

    print('secondResponse.body');
    print(secondResponse.body);

    Future.delayed(Duration(seconds: 20));
  });
}
