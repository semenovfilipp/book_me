// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_me/ui/tabs/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:book_me/base/app_assets.dart';
import 'package:book_me/base/app_colors.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //Mokka
  String name = 'Сергей Прохоров';

  String id = '005412';

  //Mokka
  int _selectedIndex = 0;
  List _tabPages = [
    HomeTab(),
    Text('2', style: TextStyle(color: AppColors.baseFontColor)),
    Text('3', style: TextStyle(color: AppColors.baseFontColor)),
    Text('4', style: TextStyle(color: AppColors.baseFontColor)),
    Text('5', style: TextStyle(color: AppColors.baseFontColor)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundAppBarColor,
        actions: [
          Text(
            '$name\nID $id',
            style: TextStyle(color: AppColors.baseFontColor),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: AppAssets().getMainAvatar(),
          ),
        ],
      ),
      body: _tabPages[_selectedIndex],
      backgroundColor: AppColors.backgroundPageColor,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                backgroundColor: AppColors.backgroundPageColor,
                icon: AppAssets().getHomeIcon(),
                label: ''),
            BottomNavigationBarItem(
                backgroundColor: AppColors.backgroundPageColor,
                icon: AppAssets().getHomeRepairServiceIcon(),
                label: ''),
            BottomNavigationBarItem(
                backgroundColor: AppColors.backgroundPageColor,
                icon: AppAssets().getInfoOutlineIcon(),
                label: ''),
            BottomNavigationBarItem(
                backgroundColor: AppColors.backgroundPageColor,
                icon: AppAssets().getVectorIcon(),
                label: ''),
            BottomNavigationBarItem(icon: AppAssets().getMailIcon(), label: '')
          ]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
