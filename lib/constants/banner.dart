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
        return '자연을 닮은 모자\n당신의 트래킹 파트너';
      case 2:
        return '햇빛은 가리고\n스윙에만 집중하세요';
      default:
        return '';
    }
  }
}
