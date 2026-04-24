import 'package:flutter/material.dart';
import 'navbar_mahasiswa.dart';
import '../lecturer_selection/view/lecturer_selection_dashboard_page.dart';

class MainMahasiswaPage extends StatefulWidget {
  const MainMahasiswaPage({super.key});

  @override
  State<MainMahasiswaPage> createState() => _MainMahasiswaPageState();
}

class _MainMahasiswaPageState extends State<MainMahasiswaPage> {
  int _currentIndex = 0;

  // Daftar halaman untuk tiap tab
  final List<Widget> _pages = [
    const LecturerSelectionDashboardPage(), // Tab 0
    const Scaffold(backgroundColor: Color(0xFFEEF2F6), body: Center(child: Text("kamu belum ada dosen pembimbing, fitur ini belum tersedia", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)))), // Tab 1
    const Scaffold(backgroundColor: Color(0xFFEEF2F6), body: Center(child: Text("kamu belum ada dosen pembimbing, fitur ini belum tersedia", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)))), // Tab 2
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack menjaga keadaan/state halaman agar tidak reset saat pindah tab
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavbarMahasiswa(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      extendBody: true, // Membuat body bisa muncul di belakang navbar transparan
    );
  }
}