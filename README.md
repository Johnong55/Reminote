# 📝 REMINOTE

**Ghi chú & Nhắc nhở thông minh**

REMINOTE giúp bạn ghi chú nhanh chóng và quản lý nhắc nhở hiệu quả, giúp bạn không bỏ lỡ bất kỳ công việc quan trọng nào!

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)

## 🌟 Tính năng chính

- ✅ **Ghi chú đơn giản**: Tạo và chỉnh sửa ghi chú với hỗ trợ định dạng văn bản
- ✅ **Nhắc nhở thông minh**: Đặt nhắc nhở để không quên việc quan trọng
- ✅ **Giao diện thân thiện**: Thiết kế hiện đại, dễ sử dụng
- ✅ **Đồng bộ dữ liệu**: An toàn và đáng tin cậy trên nhiều thiết bị
- 🔍 **Tìm kiếm nhanh**: Tìm kiếm ghi chú một cách dễ dàng
- 🏷️ **Phân loại**: Tổ chức ghi chú theo danh mục
- 🌙 **Chế độ tối**: Hỗ trợ giao diện sáng/tối

## 📱 Screenshots

*Thêm screenshots của ứng dụng tại đây*

## 🚀 Bắt đầu

### Yêu cầu hệ thống

- Flutter SDK: `>=3.0.0 <4.0.0`
- Dart SDK: `>=3.0.0 <4.0.0`
- Android Studio / VS Code
- Android SDK (cho Android) hoặc Xcode (cho iOS)

### Cài đặt

1. **Clone repository**
   ```bash
   git clone https://github.com/Johnong55/Reminote.git
   cd Reminote
   ```

2. **Cài đặt dependencies**
   ```bash
   flutter pub get
   ```

3. **Chạy ứng dụng**
   ```bash
   flutter run
   ```

### Build cho production

#### Android
```bash
flutter build apk --release
# hoặc
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

## 🏗️ Cấu trúc dự án

```
lib/
├── core/                   # Core functionality
│   ├── constants/         # App constants
│   ├── utils/            # Utility functions
│   └── themes/           # App themes
├── data/                  # Data layer
│   ├── models/           # Data models
│   ├── repositories/     # Repository implementations
│   └── datasources/      # Local/Remote data sources
├── domain/               # Business logic layer
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository contracts
│   └── usecases/         # Business use cases
├── presentation/         # UI layer
│   ├── pages/           # App screens
│   ├── widgets/         # Reusable widgets
│   └── providers/       # State management
└── main.dart            # Entry point
```

## 🔧 Công nghệ sử dụng

- **Framework**: Flutter
- **Ngôn ngữ**: Dart
- **Database**: SQLite (sqflite)
- **State Management**: Provider / Riverpod
- **Local Storage**: SharedPreferences
- **Notifications**: flutter_local_notifications
- **Date/Time**: intl package

## 📦 Dependencies chính

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  provider: ^6.1.0
  shared_preferences: ^2.2.0
  flutter_local_notifications: ^16.0.0
  intl: ^0.19.0
  path: ^1.8.3
```

## 🎯 Roadmap

- [ ] **v1.1**: Thêm tính năng xuất/nhập dữ liệu
- [ ] **v1.2**: Hỗ trợ hình ảnh trong ghi chú
- [ ] **v1.3**: Đồng bộ cloud (Google Drive, iCloud)
- [ ] **v1.4**: Widget cho màn hình chính
- [ ] **v1.5**: Chia sẻ ghi chú

## 🤝 Đóng góp

Chúng tôi hoan nghênh mọi đóng góp! Để đóng góp:

1. Fork repository
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Mở Pull Request

### Coding Guidelines

- Tuân thủ [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Viết test cho các tính năng mới
- Đảm bảo code coverage >= 80%
- Sử dụng meaningful commit messages

## 🐛 Báo lỗi

Nếu bạn gặp lỗi, vui lòng:

1. Kiểm tra [Issues](https://github.com/Johnong55/Reminote/issues) hiện có
2. Tạo issue mới với thông tin chi tiết:
   - Mô tả lỗi
   - Các bước tái tạo
   - Screenshots (nếu có)
   - Thông tin thiết bị

## 📄 License

Dự án này được phân phối dưới giấy phép MIT. Xem file [LICENSE](LICENSE) để biết thêm chi tiết.

## 👨‍💻 Tác giả

**Johnong55**
- GitHub: [@Johnong55](https://github.com/Johnong55)

## 🙏 Lời cảm ơn

- Flutter team cho framework tuyệt vời
- Material Design cho design system
- Cộng đồng Flutter Việt Nam

## 📞 Liên hệ

Nếu bạn có câu hỏi hoặc đề xuất, hãy liên hệ:

- 📧 Email: trijohn124@gmail.com   
-    Facebook: facebook.com/tri.ong.946179

---

⭐ **Nếu dự án này hữu ích, hãy cho chúng tôi một star!** ⭐
