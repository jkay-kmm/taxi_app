
class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Nhanh Chóng',
      image: 'images/onbording1.png',
      discription: "Nhanh chóng, tiện lợi – Hành trình trong tầm tay! "
  ),
  UnbordingContent(
      title: 'Chất Lượng',
      image: 'images/onbording2.png',
      discription: "Chất lượng hàng đầu, trải nghiệm xứng tầm!"
  ),
  UnbordingContent(
      title: 'Tiện Ích',
      image: 'images/onbording3.png',
      discription: "Tiện lợi tối đa, trải nghiệm tối ưu!"
  ),
];