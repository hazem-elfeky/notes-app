import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:notesapp/core/class/statusrequest.dart';
import 'package:notesapp/core/functions/checkinternet.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    if (await checkInternet()) {
      var response = await http.post(Uri.parse(linkurl), body: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> postDataWithFile(
    String linkurl,
    Map<String, String> data, {
    Map<String, String>? file,
  }) async {
    if (await checkInternet()) {
      try {
        var uri = Uri.parse(linkurl);
        var request = http.MultipartRequest("POST", uri);

        request.fields.addAll(data);

        if (file != null && file.containsKey("file")) {
          var multipartFile = await http.MultipartFile.fromPath(
            "file",
            file["file"]!,
          );
          request.files.add(multipartFile);
        }

        var response = await request.send();
        var responseData = await http.Response.fromStream(response);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(responseData.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } catch (e) {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
