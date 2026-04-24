import 'dart:ui';
import 'package:flutter/material.dart';
import 'lecturer_detail_page.dart';
import '../../main_mahasiswa/navbar_mahasiswa.dart';

class LecturersPage extends StatefulWidget {
  const LecturersPage({
    super.key,
    this.initialDepartment,
  });

  final LecturerDepartment? initialDepartment;

  @override
  State<LecturersPage> createState() => _LecturersPageState();
}

class _LecturersPageState extends State<LecturersPage> {
  final TextEditingController _searchController = TextEditingController();

  late LecturerDepartment? _selectedDepartment;
  LecturerViewType _selectedView = LecturerViewType.standard;

  bool _showFilterDropdown = false;
  bool _showViewDropdown = false;

  final List<LecturerModel> _allLecturers = const [
    LecturerModel(
      id: '1',
      name: 'Aruna Fajar',
      department: LecturerDepartment.informatics,
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 2,
      nid: '0000000001',
    ),
    LecturerModel(
      id: '2',
      name: 'Dimas Pratama',
      department: LecturerDepartment.informatics,
      imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 1,
      nid: '0000000002',
    ),
    LecturerModel(
      id: '3',
      name: 'Salsa Mahendra',
      department: LecturerDepartment.informatics,
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 3,
      nid: '0000000003',
    ),
    LecturerModel(
      id: '4',
      name: 'Aruna Fajar',
      department: LecturerDepartment.business,
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 2,
      nid: '0000000004',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDepartment = widget.initialDepartment;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<LecturerModel> get _filteredLecturers {
    final query = _searchController.text.trim().toLowerCase();
    return _allLecturers.where((lecturer) {
      final matchesDepartment = _selectedDepartment == null ? true : lecturer.department == _selectedDepartment;
      final matchesSearch = query.isEmpty ? true : lecturer.name.toLowerCase().contains(query);
      return matchesDepartment && matchesSearch;
    }).toList();
  }

  int get _activeFilterCount => _selectedDepartment != null ? 1 : 0;

  int _getCrossAxisCount(double width) {
    if (_selectedView == LecturerViewType.extraLarge) return 1;
    if (_selectedView == LecturerViewType.large) return width < 700 ? 1 : 2;
    if (width < 430) return 2;
    if (width < 900) return 3;
    return 4;
  }

  double _getGridItemHeight(double width) {
    if (_selectedView == LecturerViewType.extraLarge) return 100;
    return 240;
  }

  bool get _isOverlayVisible => _showFilterDropdown || _showViewDropdown;

  void _toggleFilterDropdown() {
    setState(() {
      _showFilterDropdown = !_showFilterDropdown;
      if (_showFilterDropdown) _showViewDropdown = false;
    });
  }

  void _toggleViewDropdown() {
    setState(() {
      _showViewDropdown = !_showViewDropdown;
      if (_showViewDropdown) _showFilterDropdown = false;
    });
  }

  void _closeAllDropdowns() => setState(() { _showFilterDropdown = false; _showViewDropdown = false; });

  void _selectDepartment(LecturerDepartment department) => setState(() { _selectedDepartment = department; _showFilterDropdown = false; });

  void _selectView(LecturerViewType viewType) => setState(() { _selectedView = viewType; _showViewDropdown = false; });

  @override
  Widget build(BuildContext context) {
    final lecturers = _filteredLecturers;

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F6),
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 18, 14, 0),
                    child: Column(
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 26),
                        _buildTopControls(),
                        const SizedBox(height: 18),
                        Expanded(
                          child: lecturers.isEmpty ? _buildEmptyState() : _buildLecturerGrid(lecturers),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_isOverlayVisible) ...[
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeAllDropdowns,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(color: Colors.black.withOpacity(0.1)),
                  ),
                ),
              ),
              Positioned(
                top: 155,
                left: 14,
                right: 14,
                child: _showFilterDropdown ? _buildFilterDropdown() : _buildViewDropdown(),
              ),
            ],
          ],
        ),
      ),
      // 2. Menambahkan NavbarMahasiswa di sini agar tetap muncul
      bottomNavigationBar: NavbarMahasiswa(
        currentIndex: 0,
        onTap: (index) {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2D3238), size: 22),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Text(
            'Lecturers',
            style: TextStyle(color: Color(0xFF2D3238), fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget _buildTopControls() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black.withOpacity(0.1), width: 1)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, size: 20, color: Color(0xFF2D3238)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Search name',
                        hintStyle: TextStyle(color: Color(0xFF9BA3AF), fontSize: 14),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildControlTab(
            flex: 2,
            icon: Icons.tune_rounded,
            label: 'Filters',
            onTap: _toggleFilterDropdown,
            showBadge: _activeFilterCount > 0,
            hasBorder: true,
          ),
          _buildControlTab(
            flex: 2,
            icon: Icons.view_agenda_rounded,
            label: 'View',
            onTap: _toggleViewDropdown,
          ),
        ],
      ),
    );
  }

  Widget _buildControlTab({
    required int flex,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool showBadge = false,
    bool hasBorder = false,
  }) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: hasBorder ? Border(right: BorderSide(color: Colors.black.withOpacity(0.1), width: 1)) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: const Color(0xFF2D3238)),
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(color: Color(0xFF5A6269), fontSize: 13, fontWeight: FontWeight.w600)),
              if (showBadge) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Color(0xFF0D4AA3), shape: BoxShape.circle),
                  child: Text('$_activeFilterCount', style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLecturerGrid(List<LecturerModel> lecturers) {
    final screenWidth = MediaQuery.of(context).size.width;
    final gridWidth = screenWidth - 28;

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: lecturers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(gridWidth),
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        mainAxisExtent: _getGridItemHeight(gridWidth),
      ),
      itemBuilder: (context, index) => _LecturerCard(
        lecturer: lecturers[index],
        viewType: _selectedView,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LecturerDetailPage(lecturer: lecturers[index])),
          ).then((_) => setState(() {}));
        },
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return _buildBaseDropdown(
      children: LecturerDepartment.values.map((dept) => _DropdownRadioTile(
        title: dept.label,
        isSelected: _selectedDepartment == dept,
        onTap: () => _selectDepartment(dept),
      )).toList(),
    );
  }

  Widget _buildViewDropdown() {
    return _buildBaseDropdown(
      children: LecturerViewType.values.map((view) => _DropdownRadioTile(
        title: view.label,
        isSelected: _selectedView == view,
        onTap: () => _selectView(view),
      )).toList(),
    );
  }

  Widget _buildBaseDropdown({required List<Widget> children}) {
    return Material(
      elevation: 8,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(16)),
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }

  Widget _buildEmptyState() => const Center(child: Text('No lecturers found.', style: TextStyle(color: Color(0xFF5A6269), fontSize: 16)));
}

class _LecturerCard extends StatelessWidget {
  const _LecturerCard({required this.lecturer, required this.viewType, required this.onTap});
  final LecturerModel lecturer;
  final LecturerViewType viewType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(lecturer.imageUrl, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(lecturer.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF111111), fontSize: 14, fontWeight: FontWeight.w700)),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: const Color(0xFFE5E7EB), shape: BoxShape.circle),
                  child: Text('${lecturer.quotaLeft}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Text(lecturer.department.shortLabelLine1, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 11, fontWeight: FontWeight.w500)),
            Text(lecturer.department.shortLabelLine2, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 11, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _DropdownRadioTile extends StatelessWidget {
  const _DropdownRadioTile({required this.title, required this.isSelected, required this.onTap});
  final String title; final bool isSelected; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, size: 20, color: isSelected ? const Color(0xFF0D4AA3) : Colors.grey),
            const SizedBox(width: 12),
            Text(title, style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class LecturerModel {
  const LecturerModel({required this.id, required this.name, required this.department, required this.imageUrl, required this.quotaLeft, required this.nid});
  final String id; final String name; final LecturerDepartment department; final String imageUrl; final int quotaLeft; final String nid;

  String get displayName => '$name, S.tu, V.wx';
}

enum LecturerDepartment { informatics, business, electrical, mechanical, artsAndCulture }
extension LecturerDepartmentX on LecturerDepartment {
  String get label {
    switch (this) {
      case LecturerDepartment.informatics: return 'Informatics Engineering';
      case LecturerDepartment.business: return 'Business Management';
      case LecturerDepartment.electrical: return 'Electrical Engineering';
      case LecturerDepartment.mechanical: return 'Machine Engineering';
      case LecturerDepartment.artsAndCulture: return 'Arts and Cultural';
    }
  }
  String get shortLabelLine1 {
    switch (this) {
      case LecturerDepartment.informatics: return 'Informatics';
      case LecturerDepartment.business: return 'Business';
      case LecturerDepartment.electrical: return 'Electrical';
      case LecturerDepartment.mechanical: return 'Machine';
      case LecturerDepartment.artsAndCulture: return 'Arts and Cultural';
    }
  }
  String get shortLabelLine2 {
    switch (this) {
      case LecturerDepartment.informatics: return 'Engineering';
      case LecturerDepartment.business: return 'Management';
      case LecturerDepartment.electrical: return 'Engineering';
      case LecturerDepartment.mechanical: return 'Engineering';
      case LecturerDepartment.artsAndCulture: return '';
    }
  }
}

enum LecturerViewType { extraLarge, large, standard }
extension LecturerViewTypeX on LecturerViewType {
  String get label {
    switch (this) {
      case LecturerViewType.extraLarge: return 'Extra Large List';
      case LecturerViewType.large: return 'Large List';
      case LecturerViewType.standard: return 'Standard List';
    }
  }
}