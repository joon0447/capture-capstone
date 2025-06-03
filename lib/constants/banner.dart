class ImagePaths {
  // 배너 이미지
  static const List<String> bannerImages = [
    'assets/images/home-banner-1.png',
    'assets/images/home-banner-2.png',
    'assets/images/home-banner-3.png',
  ];

  //배너 텍스트
  static String bannerText(int index) {
    switch (index) {
      case 0:
        return '수많은 스타일, \n다양한 캡 모자를 만나보세요!';
      case 1:
        return '앱에서 확인하는\n나에게 딱 맞는 모자';
      case 2:
        return '바람처럼 가볍게,\n여름을 쓰다';
      default:
        return '';
    }
  }
}
