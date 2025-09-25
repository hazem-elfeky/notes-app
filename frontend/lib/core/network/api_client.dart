import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

class ApiClient {
  final http.Client client;

  ApiClient(this.client);

  Future<Either<Failure, Map<String, dynamic>>> postData(
    String url,
    Map<String, String> body,
  ) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse);
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } on SocketException {
      return Left(NetworkFailure('No internet connection'));
    } on FormatException {
      return Left(ServerFailure('Invalid response format'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> postDataWithFile(
    String url,
    Map<String, String> fields, {
    Map<String, String>? files,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add fields
      request.fields.addAll(fields);

      // Add files if provided
      if (files != null) {
        for (var entry in files.entries) {
          var file = await http.MultipartFile.fromPath(entry.key, entry.value);
          request.files.add(file);
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse);
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } on SocketException {
      return Left(NetworkFailure('No internet connection'));
    } on FormatException {
      return Left(ServerFailure('Invalid response format'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
