import 'dart:convert';
import 'package:nata_food/model/resep.api.dart';
import 'package:http/http.dart' as http;
import 'package:nata_food/model/resep.dart';

class ResepApi {
// const unirest = require('unirest');

// const req = unirest('GET', 'https://yummly2.p.rapidapi.com/feeds/list');

// req.query({
  // limit: '24',
  // start: '0'
// });

// req.headers({
// 	'X-RapidAPI-Key': '6c85665dacmsh67d211a15f84013p19e8bajsnb1961b896ceb',
// 	'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
// });

  static Future<List<Resep>> getResep() async {
    var uri = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": '0', "size": '20', "tags": 'under_30_minutes'});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": '6c85665dacmsh67d211a15f84013p19e8bajsnb1961b896ceb',
      "x-rapidapi-host": 'tasty.p.rapidapi.com'
    });

    Map data = jsonDecode(response.body);

    List _temp = [];

    for (var i in data['results']) {
      _temp.add(i);
    }

    return Resep.resepFromSnapshot(_temp);
  }
}
