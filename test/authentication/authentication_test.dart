import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:millima/data/services/authentication/authentication_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'authentication_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late AuthenticationService authenticationService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    authenticationService = AuthenticationService();
  });

  test('should logout successfully', () async {
    final response = Response(
      data: {'success': true},
      statusCode: 200,
      requestOptions: RequestOptions(path: '/logout'),
    );

    when(mockDio.post('/logout')).thenAnswer((_) async => response);

    expect(() => authenticationService.logout(), returnsNormally);
  });
}