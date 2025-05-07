// File: lib/components/widgets/custom_drawer.dart

import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Function(int) onNavigate;
  final bool isLoggedIn;
  final int currentPageIndex;

  const CustomDrawer({
    Key? key,
    required this.onNavigate,
    required this.isLoggedIn,
    required this.currentPageIndex,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _drawerAnimation;
  
  // Drawer width percentage of screen width
  final double _drawerWidth = 0.7;

  @override
  void initState() {
    super.initState();
    
    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    
    _drawerAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
    );
    
    // Start animation when drawer is initialized
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Close drawer with animation
  Future<void> closeDrawer() async {
    await _animationController.reverse();
  }

  // Build drawer item
  Widget _buildDrawerItem(
    IconData icon, 
    String title, 
    int index, 
    ColorScheme colorScheme
  ) {
    final bool isSelected = widget.currentPageIndex == index;
    
    return ListTile(
      leading: Icon(
        icon, 
        color: isSelected ? colorScheme.primary : colorScheme.onSurface,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      onTap: () {
        widget.onNavigate(index);
      },
      tileColor: isSelected ? colorScheme.primaryContainer.withOpacity(0.3) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24.0, 
        vertical: 8.0
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    
    return AnimatedBuilder(
      animation: _drawerAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_drawerAnimation.value * size.width * _drawerWidth, 0),
          child: Container(
            width: size.width * _drawerWidth,
            height: size.height,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'REMINOTE',
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Ghi chú của bạn, mọi lúc mọi nơi',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _buildDrawerItem(Icons.note_alt_outlined, 'Ghi chú', 0, colorScheme),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _buildDrawerItem(Icons.watch_later_outlined, 'Thói quen', 1, colorScheme),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _buildDrawerItem(Icons.contact_page_outlined, 'Liên hệ', 2, colorScheme),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _buildDrawerItem(Icons.settings_outlined, 'Cài đặt', 3, colorScheme),
                ),
                const Spacer(),
                Divider(color: colorScheme.onSurface.withOpacity(0.1)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: widget.isLoggedIn
                      ? ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Đăng xuất'),
                          onTap: () {
                            // Add logout functionality
                          },
                        )
                      : ListTile(
                          leading: const Icon(Icons.login),
                          title: const Text('Đăng nhập'),
                          onTap: () {
                            // Add login functionality
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}