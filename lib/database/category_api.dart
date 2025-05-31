import 'dart:async';
import 'dart:convert';
import 'package:capture/constants/url.dart';
import 'package:capture/database/like.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  static List<dynamic> allData = [];

  /// 모든 모자 데이터를 가져오는 함수
  static Future<List<dynamic>> getAllData() async {
    try {
      final url = '${UrlConstants.currentUrl}/api/products/all';
      final response = await http.get(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('서버 연결 시간 초과');
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // responseDto 안의 products 값만 추출
        final products = responseData['responseDto']['products'];
        allData = products;
        return products;
      } else {
        throw Exception('모든 데이터 로드 실패: ${response.statusCode}');
      }
    } on TimeoutException {
      print('서버 연결 시간 초과');
      return []; // 빈 리스트 반환
    } catch (e) {
      print('오류 상세: $e');
      return []; // 빈 리스트 반환
    }
  }

  /// 특정 평점 이상의 모자 데이터를 가져오는 함수
  static Future<List<dynamic>> getRateData({required double rate}) async {
    try {
      if (allData.isEmpty) {
        await getAllData(); // 데이터가 없으면 먼저 로드
      }

      // rate 값이 매개변수 rate 이상인 데이터만 필터링
      List<dynamic> filteredData = allData.where((product) {
        // product에 rate 필드가 있고, 해당 값이 매개변수 rate 이상인지 확인
        return product['rate'] != null && product['rate'] >= rate;
      }).toList();

      return filteredData;
    } catch (e) {
      print('평점 필터링 오류: $e');
      return []; // 오류 발생 시 빈 리스트 반환
    }
  }

  /// 특정 기능의 모자 데이터를 가져오는 함수
  static Future<List<dynamic>> getUseData({required String use}) async {
    try {
      if (allData.isEmpty) {
        await getAllData(); // 데이터가 없으면 먼저 로드
      }

      // use 값이 매개변수 use와 일치하는 데이터만 필터링
      List<dynamic> filteredData = allData.where((product) {
        // product에 use 필드가 있고, 해당 값이 매개변수 use와 일치하는지 확인
        return product['use'] != null && product['use'] == use;
      }).toList();

      return filteredData;
    } catch (e) {
      print('카테고리 필터링 오류: $e');
      return []; // 오류 발생 시 빈 리스트 반환
    }
  }

  //좋아요 된 모자 데이터를 가져오는 함수
  static Future<List<dynamic>> getLikedData({required String userId}) async {
    try {
      if (allData.isEmpty) {
        await getAllData(); // 데이터가 없으면 먼저 로드
      }

      // 사용자의 찜 목록 가져오기
      final likedIds = await Like.getLikeList(userId);

      // 찜한 상품 ID와 일치하는 데이터만 필터링
      List<dynamic> filteredData = allData.where((product) {
        return likedIds.contains(product['_id'].toString());
      }).toList();

      return filteredData;
    } catch (e) {
      print('찜한 상품 필터링 오류: $e');
      return []; // 오류 발생 시 빈 리스트 반환
    }
  }
}
