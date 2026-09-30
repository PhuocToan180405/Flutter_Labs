import 'story.dart';

class StoryBrain {
  int _storyNumber = 0;

  final List<Story> _storyData = [
    Story(
      storyTitle:
          'Xe của bạn bị xẹp lốp trên một con đường vắng. Bạn quyết định đi nhờ xe. Một chiếc xe tải màu gỉ sét dừng lại bên cạnh bạn. Một người đàn ông với đôi mắt vô hồn mở cửa xe và hỏi: "Cần đi nhờ không?"',
      choice1: 'Đồng ý đi nhờ. Cảm ơn vì sự giúp đỡ!',
      choice2:
          'Khoan đã, tốt hơn là tôi nên hỏi anh ta trước xem anh ta có phải là kẻ giết người không.',
      nextStory1: 2,
      nextStory2: 1,
    ),
    Story(
      storyTitle: 'Anh ta từ từ gật đầu, không hề bối rối trước câu hỏi.',
      choice1: 'Ít nhất thì anh ta cũng thật thà. Tôi sẽ lên xe.',
      choice2: 'Khoan đã, tôi biết cách tự thay lốp xe mà.',
      nextStory1: 2,
      nextStory2: 3,
    ),
    Story(
      storyTitle:
          'Khi xe bắt đầu lăn bánh, người lạ mặt kể về mối quan hệ của anh ta với mẹ mình. Anh ta ngày càng tức giận hơn. Anh ta bảo bạn mở ngăn đựng đồ phía trước. Bên trong bạn thấy một con dao dính máu, hai ngón tay bị đứt và một cuốn băng cassette của Elton John. Anh ta với tay về phía ngăn đựng đồ.',
      choice1: 'Tôi rất thích Elton John! Đưa cho anh ta cuốn băng cassette.',
      choice2: 'Một là anh ta, hai là tôi! Bạn rút lấy con dao và tấn công anh ta.',
      nextStory1: 5,
      nextStory2: 4,
    ),
    Story(
      storyTitle:
          'Cái gì? Thật là hèn nhát! Bạn có biết tai nạn giao thông là nguyên nhân tử vong do tai nạn đứng hàng thứ hai đối với hầu hết các nhóm tuổi trưởng thành không?',
      choice1: 'Bắt đầu lại',
      choice2: '',
      nextStory1: 0,
      nextStory2: 0,
    ),
    Story(
      storyTitle:
          'Khi chiếc xe đâm xuyên qua lan can và lao thẳng xuống vách đá lởm chởm bên dưới, bạn mới nhận ra rằng tấn công tài xế khi họ đang lái xe chở mình là một quyết định tồi tệ.',
      choice1: 'Bắt đầu lại',
      choice2: '',
      nextStory1: 0,
      nextStory2: 0,
    ),
    Story(
      storyTitle:
          'Bạn trở nên thân thiết với kẻ giết người trong khi cùng nghêu ngao giai điệu bài hát "Can you feel the love tonight". Anh ta thả bạn xuống thị trấn tiếp theo. Trước khi bạn rời đi, anh ta hỏi bạn có biết nơi nào lý tưởng để phi tang xác không. Bạn đáp: "Thử ra bến tàu xem".',
      choice1: 'Bắt đầu lại',
      choice2: '',
      nextStory1: 0,
      nextStory2: 0,
    ),
  ];

  String getStory() {
    return _storyData[_storyNumber].storyTitle;
  }

  String getChoice1() {
    return _storyData[_storyNumber].choice1;
  }

  String getChoice2() {
    return _storyData[_storyNumber].choice2;
  }

  void nextStory(int choiceNumber) {
    if (isFinished()) {
      restart();
    } else if (choiceNumber == 1) {
      _storyNumber = _storyData[_storyNumber].nextStory1;
    } else if (choiceNumber == 2) {
      _storyNumber = _storyData[_storyNumber].nextStory2;
    }
  }

  void restart() {
    _storyNumber = 0;
  }

  bool buttonShouldBeVisible() {
    return _storyData[_storyNumber].choice2.isNotEmpty;
  }

  bool isFinished() {
    return _storyNumber >= 3;
  }

  int getStoryNumber() {
    return _storyNumber;
  }
}
