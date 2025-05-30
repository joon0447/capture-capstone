import 'dart:convert';
import 'package:capture/constants/url.dart';
import 'package:http/http.dart' as http;

class Like {
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
        final List<dynamic> likeList = data['like_list'] ?? [];
        return likeList.map((item) => item.toString()).toList();
      } else {
        throw Exception('찜 목록 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('찜 목록 조회 중 오류 발생: $e');
      return [];
    }
  }
}
