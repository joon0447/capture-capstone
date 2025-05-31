import 'dart:convert';
import 'package:capture/constants/url.dart';
import 'package:capture/database/category_api.dart';
import 'package:http/http.dart' as http;

class Like {
  static List<dynamic> likeList = [];

  static Future<void> addLike(String productId, String userId) async {
    try {
      final url = '${UrlConstants.currentUrl}/api/like/add';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'product_id': productId,
          'user_id': userId,
        }),
      );
      final product = CategoryApi.allData.firstWhere(
        (product) => product['_id'].toString() == productId,
        orElse: () => null,
      );

      if (product != null) {
        likeList.add(productId);
      }
      if (response.statusCode != 200) {
        throw Exception('찜하기 추가 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('찜하기 추가 중 오류 발생: $e');
    }
  }

  static Future<void> deleteLike(String productId, String userId) async {
    try {
      final url = '${UrlConstants.currentUrl}/api/like/remove';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'product_id': productId,
          'user_id': userId,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('찜하기 삭제 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('찜하기 삭제 중 오류 발생: $e');
    }
  }

  static Future<bool> getLike(String productId, String userId) async {
    try {
      final url = '${UrlConstants.currentUrl}/api/like/get';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'product_id': productId,
          'user_id': userId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['isLiked'] ?? false;
      } else {
        throw Exception('찜하기 상태 확인 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('찜하기 상태 확인 중 오류 발생: $e');
      return false;
    }
  }

  // 찜한 제품 ID 반환
  static Future<List<String>> getLikeList(String userId) async {
    try {
      final url = '${UrlConstants.currentUrl}/api/like/getList';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> likeList = data['likeList'] ?? [];
        return likeList.map((item) => item.toString()).toList();
      } else {
        throw Exception('찜 목록 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('찜 목록 조회 중 오류 발생: $e');
      return [];
    }
  }

  static Future<void> updateLikeList(String userId) async {
    try {
      // 사용자의 찜 목록 ID 가져오기
      final likedIds = await getLikeList(userId);

      // CategoryApi의 allData가 비어있으면 데이터 로드
      if (CategoryApi.allData.isEmpty) {
        await CategoryApi.getAllData();
      }

      // 찜한 상품 ID와 일치하는 데이터만 필터링
      likeList = CategoryApi.allData
          .where((product) => likedIds.contains(product['_id'].toString()))
          .map((product) => product['_id'].toString())
          .toList();

      print('찜 목록 업데이트 완료: $likeList');
    } catch (e) {
      print('찜 목록 업데이트 중 오류 발생: $e');
      likeList = [];
    }
  }
}
