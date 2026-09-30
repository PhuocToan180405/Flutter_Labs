import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const DiceApp());
}

/// [DiceApp] là widget gốc của ứng dụng (StatelessWidget).
/// Không lưu trữ trạng thái có thể thay đổi trong quá trình chạy.
class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice App - Lab 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
        ),
        useMaterial3: true,
      ),
      home: const DicePage(),
    );
  }
}

/// [DicePage] là StatefulWidget để quản lý trạng thái các mặt xúc xắc.
/// Khi người dùng tương tác (nhấn nút hoặc chạm vào xúc xắc),
/// trạng thái sẽ thay đổi và giao diện được vẽ lại nhờ `setState()`.
class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  // Biến lưu giá trị hiện tại của 2 xúc xắc (từ 1 đến 6)
  // Khởi tạo 6 và 4 như hình minh họa mẫu của Lab
  int leftDiceNumber = 6;
  int rightDiceNumber = 4;

  // Đối tượng Random để sinh số ngẫu nhiên
  final Random _random = Random();

  /// Hàm lắc xúc xắc: sinh số ngẫu nhiên từ 1 đến 6 và cập nhật giao diện
  void rollDice() {
    setState(() {
      // nextInt(6) sinh số từ 0 đến 5, cộng 1 để được giá trị từ 1 đến 6
      leftDiceNumber = _random.nextInt(6) + 1;
      rightDiceNumber = _random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalScore = leftDiceNumber + rightDiceNumber;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Dice',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Khung hiển thị tổng điểm
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.deepOrange.shade200),
                  ),
                  child: Text(
                    'Tổng điểm: $totalScore',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Hàng chứa 2 xúc xắc
                Row(
                  children: [
                    // Xúc xắc bên trái
                    Expanded(
                      child: GestureDetector(
                        onTap: rollDice,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/dice$leftDiceNumber.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    // Xúc xắc bên phải
                    Expanded(
                      child: GestureDetector(
                        onTap: rollDice,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/dice$rightDiceNumber.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Text(
                  'Chạm vào xúc xắc hoặc nhấn nút bên dưới để lắc',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 32),

                // Nút bấm lắc xúc xắc (ElevatedButton theo yêu cầu)
                ElevatedButton.icon(
                  onPressed: rollDice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                  ),
                  icon: const Icon(Icons.casino, size: 26),
                  label: const Text(
                    'Lắc xúc xắc',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
