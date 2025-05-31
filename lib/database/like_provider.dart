import 'dart:convert';
import 'package:capture/database/category_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:capture/constants/url.dart';

class LikeProvider with ChangeNotifier {
  List<String> _likeList = [];

  List<String> get likeList => _likeList;
  Future<void> updateLikeList(String userId) async {
    try {
      final url = '${UrlConstants.currentUrl}/api/like/getList';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> likeData = data['likeList'] ?? [];
        _likeList = likeData.map((id) => id.toString()).toList();
        print('provider likeList: $_likeList');
        notifyListeners();
      } else {
        throw Exception('찜 목록 조회 실패');
      }
    } catch (e) {
      print('찜 목록 업데이트 오류: $e');
      _likeList = [];
      notifyListeners();
    }
  }

  Future<void> addLike(String productId, String userId) async {
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
        _likeList.add(productId);
      }
      if (response.statusCode != 200) {
        throw Exception('찜하기 추가 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('찜하기 추가 중 오류 발생: $e');
    }
    notifyListeners();
  }

  Future<void> deleteLike(String productId, String userId) async {
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

      _likeList.remove(productId);
      if (response.statusCode != 200) {
        throw Exception('찜하기 삭제 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('찜하기 삭제 중 오류 발생: $e');
    }
    notifyListeners();
  }
}
