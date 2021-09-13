///서비스는 데이터를 가져오는 곳이고, 여기서 연우형이 만든 것이 진행될 것이고.
///Create network services to fetch API. 여기서 restAPI를 받는 것인지? 정확하게 이해할 필요
///pubspec.yaml http: any 추가 버전 any 하는 이유조차 정확하게 이해해야 할 필요
///
/// 주소만 받아오면 된다!!!
/// restAPI 정확하게 뭘 받아오는지 결정하고
/// 얘가 엉뚱한 거 안오고 작동 잘하게!
import 'package:http/http.dart' as http;

class Service{
  Future<List<PicsumModel>> fetchPicturesAPI() async {
    ///주소를 가져오는 부분.
    String url = "https://www.naver.com";
    final response = await http.get(url.parse(url)); ///주소에서 데이터를 받아오는 부분?
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listResult = json.map((e) => PicSumModel.fromJson(e)).toList();
      return listResult;
    }
    else
      throw Exception('Error fetching pictures');

  }
}