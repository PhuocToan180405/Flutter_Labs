import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const XylophoneApp());
}

/// [XylophoneApp] là Widget gốc của ứng dụng (StatelessWidget).
class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: XylophonePage(),
    );
  }
}

/// [XylophonePage] là StatefulWidget quản lý giao diện đàn Xylophone.
/// 7 phím đàn xếp liền kề nhau theo chiều dọc (không có khoảng cách đen ở giữa),
/// bo tròn ở hai đầu và tràn đều màn hình theo đúng mẫu thiết kế.
class XylophonePage extends StatefulWidget {
  const XylophonePage({super.key});

  @override
  State<XylophonePage> createState() => _XylophonePageState();
}

class _XylophonePageState extends State<XylophonePage> {
  /// Đối tượng AudioPlayer dùng chung để kiểm soát luồng âm thanh
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Cấu hình chế độ phát tối ưu cho âm thanh ngắn (nhạc cụ)
    _player.setPlayerMode(PlayerMode.lowLatency);
    _player.setVolume(0.85); // Đặt âm lượng 85% để tránh hiện tượng clipping/vỡ tiếng trên loa giả lập
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  /// Hàm phát âm thanh khi bấm phím
  /// - Sử dụng PlayerMode.lowLatency để nốt nhạc phát ngay lập tức
  /// - Tránh tạo hàng loạt instance mới gây tràn bộ đệm âm thanh (tạp âm/crackle)
  void playSound(int soundNumber) {
    _player.play(
      AssetSource('note$soundNumber.wav'),
      mode: PlayerMode.lowLatency,
      volume: 0.85,
    );
  }

  /// Hàm dựng từng phím đàn
  /// - [Expanded]: chia đều 7 phím theo chiều dọc
  /// - Không có padding vertical để các phím chạm nhau như ảnh mẫu
  /// - Bo tròn ở hai đầu bằng [RoundedRectangleBorder]
  Widget buildKey({required Color color, required int soundNumber}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white24,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () => playSound(soundNumber),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildKey(color: const Color(0xFFF44336), soundNumber: 1), // Đỏ
            buildKey(color: const Color(0xFFFF9800), soundNumber: 2), // Cam
            buildKey(color: const Color(0xFFFFEB3B), soundNumber: 3), // Vàng
            buildKey(color: const Color(0xFF4CAF50), soundNumber: 4), // Xanh lá
            buildKey(color: const Color(0xFF009688), soundNumber: 5), // Xanh ngọc / Teal
            buildKey(color: const Color(0xFF2196F3), soundNumber: 6), // Xanh dương
            buildKey(color: const Color(0xFF9C27B0), soundNumber: 7), // Tím
          ],
        ),
      ),
    );
  }
}
