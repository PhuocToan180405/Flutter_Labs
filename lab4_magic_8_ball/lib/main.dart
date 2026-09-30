import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// [MyApp] là Widget gốc của ứng dụng (StatelessWidget).
/// Widget này không lưu giữ trạng thái thay đổi trong suốt vòng đời của ứng dụng.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic 8 Ball - Lab 4',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9C27B0),
        ),
      ),
      home: const BallPage(),
    );
  }
}

/// [BallPage] là StatefulWidget để quản lý trạng thái của quả cầu tiên tri.
/// Khi người dùng tương tác (nhấn vào quả cầu hoặc nhấn nút),
/// giá trị `ballNumber` thay đổi và `setState()` được kích hoạt để vẽ lại giao diện.
class BallPage extends StatefulWidget {
  const BallPage({super.key});

  @override
  State<BallPage> createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  // Biến lưu trữ số thứ tự hình ảnh quả cầu hiện tại (từ 1 đến 5).
  // Khởi tạo mặc định bằng 1 (hoặc 4 để hiển thị "THE ANSWER IS YES" như hình mẫu Lab).
  int ballNumber = 1;

  // Đối tượng Random từ thư viện 'dart:math' để tạo số ngẫu nhiên
  final Random _random = Random();

  /// Hàm lắc quả cầu: Sinh số ngẫu nhiên từ 1 đến 5 và cập nhật giao diện
  void _askQuestion() {
    setState(() {
      // nextInt(5) sinh số từ 0 đến 4, cộng 1 để ra kết quả từ 1 đến 5
      ballNumber = _random.nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5), // Nền màu tím nhạt dịu mắt
      appBar: AppBar(
        backgroundColor: const Color(0xFFCE93D8), // Màu tím pastel giống ảnh mẫu
        elevation: 2.0,
        centerTitle: false,
        title: const Text(
          'Ask Me Anything',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị hình ảnh quả cầu tiên tri từ assets/
            // Cho phép người dùng chạm trực tiếp vào quả cầu để nhận câu trả lời
            GestureDetector(
              onTap: _askQuestion,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                constraints: const BoxConstraints(
                  maxWidth: 320,
                  maxHeight: 320,
                ),
                child: Image.asset(
                  'assets/ball$ballNumber.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            // Nút bấm nhận câu trả lời theo yêu cầu thực hiện của Lab
            ElevatedButton.icon(
              onPressed: _askQuestion,
              icon: const Icon(Icons.touch_app),
              label: const Text(
                'Nhận câu trả lời',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBA68C8),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 14.0,
                ),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
