import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.sp,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.black, size: 45.sp),
          onPressed: onSearchTap ?? () {},
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
