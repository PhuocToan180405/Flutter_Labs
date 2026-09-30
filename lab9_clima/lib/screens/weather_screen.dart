import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/weather_model.dart';
import '../services/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _searchController = TextEditingController();

  WeatherData? _weatherData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocationWeather();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Lấy thời tiết từ vị trí GPS
  Future<void> _fetchCurrentLocationWeather() async {
    setState(() {
      _isLoading = true;
    });

    WeatherData data = await _weatherService.getLocationWeather();

    if (mounted) {
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    }
  }

  /// Tìm kiếm thời tiết theo tên thành phố
  Future<void> _searchCityWeather() async {
    String city = _searchController.text.trim();
    if (city.isEmpty) return;

    // Đóng bàn phím ảo
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    WeatherData data = await _weatherService.getCityWeather(city);

    if (mounted) {
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tiêu đề App
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Weather App',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Nút lấy lại vị trí GPS
                      IconButton(
                        icon: const Icon(
                          Icons.my_location,
                          size: 20,
                          color: Color(0xFF2196F3),
                        ),
                        tooltip: 'Vị trí hiện tại',
                        onPressed: _fetchCurrentLocationWeather,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Thanh tìm kiếm thành phố
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: const Color(0xFFCBD5E1),
                              width: 1.2,
                            ),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1E293B),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter city name (e.g.,...',
                              hintStyle: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xFF64748B),
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 13,
                              ),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        size: 18,
                                        color: Color(0xFF94A3B8),
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {});
                                      },
                                    )
                                  : null,
                            ),
                            onChanged: (_) => setState(() {}),
                            onSubmitted: (_) => _searchCityWeather(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Nút Search
                      ElevatedButton(
                        onPressed: _searchCityWeather,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Search',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Nội dung thời tiết hoặc hiệu ứng tải
                  if (_isLoading)
                    Container(
                      height: 400,
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinKitFadingCircle(
                            color: Color(0xFF2196F3),
                            size: 50.0,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Đang tải dữ liệu thời tiết...',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (_weatherData != null)
                    _buildWeatherContent(_weatherData!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Widget hiển thị toàn bộ nội dung thông tin thời tiết
  Widget _buildWeatherContent(WeatherData data) {
    return Column(
      children: [
        // Vị trí (Tên thành phố, Quốc gia)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Color(0xFF2196F3),
              size: 24,
            ),
            const SizedBox(width: 6),
            Text(
              '${data.cityName}, ${data.country}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Giờ địa phương
        Text(
          data.localTimeString,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 18),

        // Thẻ nền chứa chi tiết thời tiết chính
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F6FB),
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
          child: Column(
            children: [
              // Biểu tượng thời tiết
              data.buildWeatherIcon(size: 78),
              const SizedBox(height: 10),

              // Mô tả trạng thái thời tiết (ví dụ: overcast clouds, few clouds)
              Text(
                data.description,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 10),

              // Nhiệt độ hiện tại
              Text(
                '${data.temp}°C',
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 2),

              // Cảm giác như
              Text(
                'Feels like ${data.feelsLike}°C',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 22),

              // 4 ô thông số chi tiết (Grid 2x2)
              Row(
                children: [
                  Expanded(
                    child: _buildDetailCard(
                      icon: Icons.water_drop,
                      iconColor: const Color(0xFF2196F3),
                      title: 'Humidity',
                      value: '${data.humidity}%',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDetailCard(
                      icon: Icons.air,
                      iconColor: const Color(0xFF00ACC1),
                      title: 'Wind Speed',
                      value: '${data.windSpeed} m/s',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailCard(
                      icon: Icons.device_thermostat,
                      iconColor: const Color(0xFF2196F3),
                      title: 'Min Temp',
                      value: '${data.tempMin}°C',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDetailCard(
                      icon: Icons.device_thermostat,
                      iconColor: const Color(0xFF2196F3),
                      title: 'Max Temp',
                      value: '${data.tempMax}°C',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Widget hiển thị thẻ thông số con (Độ ẩm, Tốc độ gió, Nhiệt độ Min/Max)
  Widget _buildDetailCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 26,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
