import 'package:flutter/material.dart';
import '../../views/report/report_screen.dart';
import '../../views/history/report_history_screen.dart';
import '../../views/profile/profile_screen.dart';
import '../../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // create widget so we can refer to _onTabTapped
  // index [0,1,2,3] = [home, report, history, profile]
  int _currentIndex = 0;
  List<Widget> get _pages => [
    _buildHomePage(),
    const ReportScreen(),
    const ReportHistoryScreen(),
    const ProfileScreen(),
  ];
  // with a click go to each tab
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Show the selected page
  // when a tab is clicked it shows the current tab
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  // create simple home page design,
  //small welcome page
  //A button to take you to report tab
  Widget _buildHomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to SIRS',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _onTabTapped(1),
            label: const Text('Report a problem'),
          ),
        ],
      ),
    );
  }
}
