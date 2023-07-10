import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class DataService {
  Future<List<Map<String, dynamic>>> getData(DateTime dateMin, DateTime dateMax) async {
  String station = "00206458";
  String type = "hours";
  int unixTimestampMin = dateMin.millisecondsSinceEpoch ~/ 1000;
  int unixTimestampMax = dateMax.millisecondsSinceEpoch ~/ 1000;

  String apiRoute =
      '/data/$station/$type/from/$unixTimestampMin/to/$unixTimestampMax';
  final configText = await rootBundle.loadString('api_config.txt');
  final configLines = configText.split('\n');
  final publicKey = configLines[0].trim();
  final privateKey = configLines[1].trim();
  final apiURI = configLines[2].trim();

  String contentToSign = 'GET$apiRoute$publicKey';
  var key = utf8.encode(privateKey);
  var bytesG = utf8.encode(contentToSign);
  var hmacSha256 = Hmac(sha256, key);
  var digest = hmacSha256.convert(bytesG);
  var signature = digest.toString();

  String authorizationString = "hmac $publicKey:$signature";

  try {
    final response = await http.get(Uri.parse(apiURI + apiRoute), headers: {
      'Content-Type': 'application/json',
      'Authorization': authorizationString,
    });

    final json = jsonDecode(response.body);
    List<dynamic> data = json['data'];
    List<Map<String, dynamic>> output = [];

    List<String> desiredNames = [
      'Time',
      'Température ',
      'Point de rosée',
      'Rayonnement solaire',
      'Déficit de Pression de vapeur',
      'Humidité Relative ',
      'Précipitations',
      'Humectation foliaire',
      'Vitesse du vent',
      'Vitesse du vent max',
      'Direction du vent',
      'Panneau solaire',
      'Batterie',
      'DeltaT',
      'ETP quotidien'
    ];

    // Create a map to store the index of each desired name
    Map<String, int> nameIndices = {};
    for (int i = 0; i < desiredNames.length; i++) {
      nameIndices[desiredNames[i]] = i;
    }

    DateTime currentTime = dateMin;
    List<String> timeValues = [];
    while (currentTime.isBefore(dateMax)) {
      String timeString = DateFormat('dd/MM/yyyy HH:mm').format(currentTime);
      timeValues.add(timeString);
      currentTime = currentTime.add(Duration(hours: 1));
    }
    Map<String, dynamic> timeColumn = {
      'name': 'Time',
      'values': timeValues,
    };
    output.add(timeColumn);

    for (var item in data) {
      String name = item['name'];
      if (desiredNames.contains(name)) {
        if (item['aggr'] != null) {
          List<dynamic> aggr = item['aggr'];

          for (var aggrString in aggr) {
            String newName = name + '[' + aggrString.toString() + "] ";
            List<dynamic> values = item['values'][aggrString];

            Map<String, dynamic> result = {
              'name': newName,
              'values': values,
            };

            output.add(result);
          }
        } else {
          List<dynamic> values = item['values']['result'];
          Map<String, dynamic> result = {
            'name': name,
            'values': values,
          };

          output.add(result);
        }
      }
    }

    // Sort the output list based on the desired names' indices
    output.sort((a, b) {
      final nameA = a['name'].split('[')[0]; // Extract the original name
      final nameB = b['name'].split('[')[0]; // Extract the original name
      final indexA = nameIndices[nameA];
      final indexB = nameIndices[nameB];
      if (indexA == null && indexB == null) {
        return 0;
      } else if (indexA == null) {
        return 1;
      } else if (indexB == null) {
        return -1;
      }
      return indexA.compareTo(indexB);
    });

    print(output);
    return output;
  } catch (error) {
    print("An error occurred: $error");
    return [];
  }
}
}
