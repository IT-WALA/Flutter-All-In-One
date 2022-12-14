import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/modules/common_widgets/common_widgets.dart';
import 'package:flutter_all_in_one/modules/http/get_request_model.dart';
import 'package:flutter_all_in_one/modules/http/post_request_model.dart';
import 'package:flutter_all_in_one/modules/http/post_response_model.dart';
import 'package:flutter_all_in_one/modules/toast/toast_screen.dart';
import 'package:http/http.dart' as http;

class HttpRequestScreen extends StatefulWidget {
  const HttpRequestScreen({Key? key}) : super(key: key);

  @override
  State<HttpRequestScreen> createState() => _HttpRequestScreenState();
}

class _HttpRequestScreenState extends State<HttpRequestScreen> {
  bool _is_progress_indicator_visible = false;
  String _result = "";
  final String _url_get = "https://simplifiedcoding.net/demos/marvel";
  final String _url_post = "https://reqres.in/api/users";
  var getRequestData = <GetRequestModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "HTTP REQUEST"),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _is_progress_indicator_visible = true;
                          getRequest();
                        });
                      },
                      child: const Text("GET Request"),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        _is_progress_indicator_visible = true;
                        postRequest();
                      },
                      child: const Text("POST Request"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(_result),
              Visibility(
                visible: _is_progress_indicator_visible,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getRequest() async {
    final response = await http.get(Uri.parse(_url_get));

    setState(() {
      _is_progress_indicator_visible = false;
    });

    if (response.statusCode == 200) {
      List decodedJson = jsonDecode(response.body);
      int length = decodedJson.length;

      for (int i = 0; i < length; i++) {
        getRequestData.add(GetRequestModel.fromJson(decodedJson[i]));
      }
    } else {
      showToast("Server Error!");
    }

    setState(() {
      _result = getRequestData[0].toString();
    });
  }

  void postRequest() async {
    PostRequestModel postRequestModel = PostRequestModel("Vaibhav");
    var json = jsonEncode(postRequestModel);
    debugPrint("JSON: $json");
    final response = await http.post(
      Uri.parse(_url_post),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      _is_progress_indicator_visible = false;
    });

    if (response.statusCode == 201) {
      debugPrint("Result: ${response.body}");
      PostResponseModel model =
          PostResponseModel.fromJson(jsonDecode(response.body));
      debugPrint("Data: $model");

      setState(() {
        _result = "Result: ${model.name}, ${model.createdAt}";
      });
    } else {
      showToast("Server Error!");
    }
  }
}
