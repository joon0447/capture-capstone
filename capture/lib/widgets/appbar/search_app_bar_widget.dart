import 'package:flutter/material.dart';

class SearchAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSearchTap;

  const SearchAppBarWidget({
    super.key,
    required this.title,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black, size: 22),
          onPressed: onSearchTap ?? () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
