import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question('Việt Nam có đường biên giới với Campuchia.', true),
    Question('Thủ đô của Việt Nam là Thành phố Hồ Chí Minh.', false),
    Question('Mặt trời mọc ở hướng Tây và lặn ở hướng Đông.', false),
    Question('Sông Mê Kông chảy qua lãnh thổ Việt Nam trước khi đổ ra Biển Đông.', true),
    Question('Cá voi là một loài thú có vú sống dưới nước chứ không phải loài cá.', true),
    Question('Đỉnh Fansipan là đỉnh núi cao nhất bán đảo Đông Dương.', true),
    Question('Nước sôi ở nhiệt độ 100°C trong điều kiện áp suất khí quyển tiêu chuẩn.', true),
    Question('Đà Lạt là thành phố trực thuộc khu vực Đồng bằng Sông Cửu Long.', false),
    Question('Vịnh Hạ Long đã từng được UNESCO công nhận là Di sản Thiên nhiên Thế giới.', true),
    Question('Vạn Lý Trường Thành có thể nhìn thấy rõ từ Mặt Trăng bằng mắt thường.', false),
    Question('Việt Nam có đường bờ biển dài hơn 3.260 km.', true),
    Question('Con người có 4 nhóm máu chính là A, B, AB và O.', true),
    Question('Kim tự tháp Giza nằm ở Hy Lạp.', false),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    return _questionNumber >= _questionBank.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }

  int getTotalQuestions() {
    return _questionBank.length;
  }

  int getCurrentQuestionNumber() {
    return _questionNumber + 1;
  }
}
