import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

Future<String?> getUserId() async {
  try {
    // 현재 로그인된 사용자 정보 가져오기
    User user = await UserApi.instance.me();
    return user.id.toString();
  } catch (e) {
    print('사용자 ID 가져오기 실패: $e');
    return null;
  }
}
