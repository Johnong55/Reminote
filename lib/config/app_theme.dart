import 'package:flutter/material.dart';

// --- Minimalist Light Theme ---
final ThemeData minimalistLightMode = ThemeData(
  brightness: Brightness.light,
  // Sử dụng màu trắng hoặc rất nhạt làm nền chính
  scaffoldBackgroundColor: Colors.white,
  // Bảng màu cho chế độ sáng
  colorScheme: ColorScheme.light(
    // Màu chính: Một màu xám đậm hoặc đen để tạo sự tương phản mạnh
    primary: Colors.grey.shade900,
    // Màu phụ/nhấn: Một màu xám nhạt hơn hoặc cùng màu chính để giữ sự đơn giản
    secondary: Colors.grey.shade700,
    // Màu nền chung (thường giống scaffoldBackgroundColor)
    background: Colors.white,
    // Màu nền cho các thành phần như Card, Dialog
    surface: Colors.grey.shade50, // Một màu trắng ngà hoặc xám rất nhạt
    // Màu chữ/icon trên màu chính
    onPrimary: Colors.white,
    // Màu chữ/icon trên màu phụ
    onSecondary: Colors.white,
    // Màu chữ/icon trên nền chung
    onBackground: Colors.black,
    // Màu chữ/icon trên surface
    onSurface: Colors.black,
    // Màu báo lỗi (có thể giữ màu đỏ để dễ nhận biết)
    error: Colors.redAccent,
    // Màu chữ/icon trên màu báo lỗi
    onError: Colors.white,
  ),
  // Tùy chỉnh thêm các thành phần khác nếu muốn
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white, // AppBar nền trắng
    foregroundColor: Colors.black, // Chữ và icon màu đen
    elevation: 0, // Không có bóng đổ để phẳng hơn
    scrolledUnderElevation: 0.5, // Một chút bóng đổ nhẹ khi cuộn
    surfaceTintColor: Colors.transparent, // Tránh AppBar đổi màu khi cuộn dưới
  ),
  cardTheme: CardTheme(
    elevation: 1, // Bóng đổ rất nhẹ cho Card
    color: Colors.grey.shade50, // Màu nền Card giống surface
    surfaceTintColor: Colors.transparent, // Tránh Card bị ám màu primary
  ),
  // Có thể tùy chỉnh thêm TextTheme, ButtonTheme,...
);

// --- Minimalist Dark Theme ---
final ThemeData minimalistDarkMode = ThemeData(
  brightness: Brightness.dark,
  // Sử dụng màu đen hoặc xám rất đậm làm nền chính
  scaffoldBackgroundColor: const Color(0xFF121212), // Màu đen chuẩn Material Design
  // Bảng màu cho chế độ tối
  colorScheme: ColorScheme.dark(
    // Màu chính: Một màu xám nhạt hoặc trắng để tương phản trên nền tối
    primary: Colors.grey.shade300,
    // Màu phụ/nhấn: Một màu xám đậm hơn một chút
    secondary: Colors.grey.shade500,
    // Màu nền chung
    background: const Color(0xFF121212),
    // Màu nền cho các thành phần như Card, Dialog
    surface: const Color(0xFF1E1E1E), // Màu xám đậm hơn nền một chút
    // Màu chữ/icon trên màu chính
    onPrimary: Colors.black, // Đảm bảo đủ tương phản
    // Màu chữ/icon trên màu phụ
    onSecondary: Colors.black,
    // Màu chữ/icon trên nền chung
    onBackground: Colors.white,
    // Màu chữ/icon trên surface
    onSurface: Colors.white,
    // Màu báo lỗi (có thể dùng màu đỏ nhạt hơn)
    error: Colors.redAccent.shade100,
    // Màu chữ/icon trên màu báo lỗi
    onError: Colors.black,
  ),
  // Tùy chỉnh thêm các thành phần khác
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF1E1E1E), // AppBar nền tối (giống surface)
    foregroundColor: Colors.white, // Chữ và icon màu trắng
    elevation: 0, // Không có bóng đổ
    scrolledUnderElevation: 0.5, // Bóng đổ nhẹ khi cuộn
    surfaceTintColor: Colors.transparent,
  ),
  cardTheme: CardTheme(
    elevation: 1, // Bóng đổ rất nhẹ
    color: const Color(0xFF1E1E1E), // Màu nền Card giống surface
    surfaceTintColor: Colors.transparent,
  ),
  // Có thể tùy chỉnh thêm TextTheme, ButtonTheme,...
);