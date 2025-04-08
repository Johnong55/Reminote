import 'package:flutter/material.dart';
import 'package:study_app/components/commons/bottom_nav.dart';
import 'package:study_app/screens/NoteHome.dart'; // Đảm bảo tên file đúng
import 'package:study_app/screens/ReminderHome.dart'; // Đảm bảo tên file đúng
// Import theme của bạn nếu cần truy cập trực tiếp, nhưng thường không cần trong widget con
// import 'package:study_app/config/app_theme.dart';

class Homepage extends StatefulWidget {
  // Đổi tên lớp cho đúng chuẩn Dart (nếu chưa đổi ở file khác)
  // const HomePage({super.key}); // Ví dụ đổi tên thành HomePage
  const Homepage({super.key});

  @override
  // State<HomePage> createState() => _HomePageState(); // Nếu đổi tên lớp
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int pageNum = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  // Đổi tên lớp widget cho đúng chuẩn Dart (nếu chưa đổi)
  // List<Widget> routes = [const NoteHomePage(), const ReminderPage()]; // Ví dụ đổi tên
  final List<Widget> routes = [const Notehome(), const Reminder()];

  @override
  void dispose() {
    _searchController.dispose(); // Đừng quên dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy colorScheme và textTheme từ theme hiện tại
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hintColor = Theme.of(context).hintColor;
    // AppBar theme tự động áp dụng màu nền và màu chữ/icon (foregroundColor)
    // nên không cần set màu thủ công cho từng icon/text trong AppBar nữa.

    return Scaffold(
      backgroundColor: colorScheme.background, // Đã dùng theme color -> Tốt
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (Widget child, Animation<double> animation) {
            // Thêm hiệu ứng chuyển động mượt hơn (tùy chọn)
            return FadeTransition(opacity: animation, child: child);
            // return ScaleTransition(scale: animation, child: child);
          },
          child: _isSearching
              ? AppBar(
                  key: const ValueKey('searchAppBar'), // Key cần thiết cho AnimatedSwitcher
                  // Màu icon sẽ được lấy từ AppBarTheme.foregroundColor
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back), // Bỏ màu hardcode
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                        _searchController.clear();
                        // Có thể thêm lệnh hủy focus bàn phím nếu cần
                        FocusScope.of(context).unfocus();
                      });
                    },
                  ),
                  title: TextField(
                    controller: _searchController,
                    autofocus: true,
                   
                    style: TextStyle(color: colorScheme.onPrimary), 
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm...',
                     
                      hintStyle: TextStyle(color: hintColor), 
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                       // TODO: Thêm logic lọc/tìm kiếm real-time nếu muốn
                       print('Đang tìm: $value');
                    },
                    onSubmitted: (value) {
                      // TODO: Xử lý khi nhấn enter/submit tìm kiếm
                      print('Tìm kiếm: $value');
                      FocusScope.of(context).unfocus(); // Ẩn bàn phím
                    },
                  ),
                  actions: [
                    // Có thể thêm nút Clear vào đây nếu muốn
                     IconButton(
                       icon: const Icon(Icons.clear), // Màu tự động theo theme
                       onPressed: () {
                          _searchController.clear();
                          // TODO: Cập nhật lại kết quả tìm kiếm (hiển thị tất cả)
                       },
                     ),
                  ],
                )
              : AppBar(
                  key: const ValueKey('normalAppBar'), 
                  title: Text(
                    'REMINOTE',
                    
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                  
                    ),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                 
                        color: colorScheme.surface.withOpacity(0.8), 
                        borderRadius: BorderRadius.circular(30), 
                      ),
                      child: IconButton(
                
                        icon: const Icon(Icons.search), 
                        tooltip: 'Tìm kiếm',
                        onPressed: () {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                       decoration: BoxDecoration(
                        color: colorScheme.surface.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                      
                        icon: const Icon(Icons.settings),
                        tooltip: 'Cài đặt',
                        onPressed: () {
                           Navigator.pushNamed(context, '/settings');
                          
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
      // Giả định myBottomNav đã được thiết kế để dùng theme colors
      bottomNavigationBar: myBottomNav(
       
        onTabChange: (index) {
          // Chỉ rebuild nếu index thay đổi
          if (pageNum != index) {
             setState(() {
               pageNum = index;
             });
          }
        },
      ),
      // Sử dụng IndexedStack để giữ trạng thái của các trang khi chuyển tab
      body: IndexedStack(
         index: pageNum,
         children: routes,
      ),
    
    );
  }
}