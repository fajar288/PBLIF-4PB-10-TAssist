import 'dart:ui';
import 'package:flutter/material.dart';
import 'lecturer_detail_page.dart';

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
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 2,
      nid: '0000000001',
    ),
    LecturerModel(
      id: '2',
      name: 'Dimas Pratama',
      department: LecturerDepartment.informatics,
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 1,
      nid: '0000000002',
    ),
    LecturerModel(
      id: '3',
      name: 'Salsa Mahendra',
      department: LecturerDepartment.informatics,
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 3,
      nid: '0000000003',
    ),
    LecturerModel(
      id: '4',
      name: 'Aruna Fajar',
      department: LecturerDepartment.business,
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 2,
      nid: '0000000004',
    ),
    LecturerModel(
      id: '5',
      name: 'Nadia Putri',
      department: LecturerDepartment.business,
      imageUrl:
          'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 1,
      nid: '0000000005',
    ),
    LecturerModel(
      id: '6',
      name: 'Reno Alfarizi',
      department: LecturerDepartment.business,
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 2,
      nid: '0000000006',
    ),
    LecturerModel(
      id: '7',
      name: 'Bagas Wicaksono',
      department: LecturerDepartment.electrical,
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 2,
      nid: '0000000007',
    ),
    LecturerModel(
      id: '8',
      name: 'Laras Pertiwi',
      department: LecturerDepartment.electrical,
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 2,
      nid: '0000000008',
    ),
    LecturerModel(
      id: '9',
      name: 'Fikri Ramadhan',
      department: LecturerDepartment.mechanical,
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 4,
      nid: '0000000009',
    ),
    LecturerModel(
      id: '10',
      name: 'Nabila Khansa',
      department: LecturerDepartment.mechanical,
      imageUrl:
          'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 1,
      nid: '0000000010',
    ),
    LecturerModel(
      id: '11',
      name: 'Rafi Aditya',
      department: LecturerDepartment.artsAndCulture,
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 2,
      nid: '0000000011',
    ),
    LecturerModel(
      id: '12',
      name: 'Shinta Aulia',
      department: LecturerDepartment.artsAndCulture,
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=600&q=80',
      quotaLeft: 2,
      nid: '0000000012',
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
      final matchesDepartment = _selectedDepartment == null
          ? true
          : lecturer.department == _selectedDepartment;

      final matchesSearch = query.isEmpty
          ? true
          : lecturer.name.toLowerCase().contains(query);

      return matchesDepartment && matchesSearch;
    }).toList();
  }

  int get _activeFilterCount {
    int count = 0;
    if (_selectedDepartment != null) count++;
    return count;
  }

  int _getCrossAxisCount(double width) {
    switch (_selectedView) {
      case LecturerViewType.extraLarge:
        return 1;
      case LecturerViewType.large:
        return width < 700 ? 1 : 2;
      case LecturerViewType.standard:
        if (width < 430) return 2;
        if (width < 900) return 3;
        return 4;
    }
  }

  double _getGridItemHeight(double width) {
    switch (_selectedView) {
      case LecturerViewType.extraLarge:
        return 96;
      case LecturerViewType.large:
        return width < 700 ? 250 : 235;
      case LecturerViewType.standard:
        if (width < 430) return 235;
        if (width < 900) return 220;
        return 215;
    }
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

  void _closeAllDropdowns() {
    setState(() {
      _showFilterDropdown = false;
      _showViewDropdown = false;
    });
  }

  void _selectDepartment(LecturerDepartment department) {
    setState(() {
      _selectedDepartment = department;
      _showFilterDropdown = false;
    });
  }

  void _selectView(LecturerViewType viewType) {
    setState(() {
      _selectedView = viewType;
      _showViewDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lecturers = _filteredLecturers;

    return Scaffold(
      backgroundColor: const Color(0xFF363C45),
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
                        const SizedBox(height: 14),
                        Expanded(
                          child: lecturers.isEmpty
                              ? _buildEmptyState()
                              : _buildLecturerGrid(lecturers),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildBottomNav(context),
              ],
            ),
            if (_isOverlayVisible) ...[
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeAllDropdowns,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 14,
                right: 14,
                child: _showFilterDropdown
                    ? _buildFilterDropdown()
                    : _buildViewDropdown(),
              ),
            ],
          ],
        ),
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
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          const Center(
            child: Text(
              'Lecturers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopControls() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFD9DDE2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Color(0xFF8B8B8B), width: 0.8),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search_rounded,
                    size: 22,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search name',
                        hintStyle: TextStyle(
                          color: Color(0xFF7A7A7A),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: _toggleFilterDropdown,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Color(0xFF8B8B8B),
                          width: 0.8,
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.tune_rounded, size: 18, color: Colors.black),
                        SizedBox(width: 6),
                        Text(
                          'Filters',
                          style: TextStyle(
                            color: Color(0xFF6D6D6D),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_activeFilterCount > 0)
                    Positioned(
                      right: 8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0D4AA3),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$_activeFilterCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: _toggleViewDropdown,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.view_agenda_rounded,
                    size: 18,
                    color: Colors.black,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'View',
                    style: TextStyle(
                      color: Color(0xFF6D6D6D),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    final departments = LecturerDepartment.values;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFD9DDE2),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.65),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final department in departments) ...[
              _DropdownRadioTile(
                title: department.label,
                isSelected: _selectedDepartment == department,
                onTap: () => _selectDepartment(department),
              ),
              if (department != departments.last) const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildViewDropdown() {
    final views = LecturerViewType.values;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFD9DDE2),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.65),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final viewType in views) ...[
              _DropdownRadioTile(
                title: viewType.label,
                isSelected: _selectedView == viewType,
                onTap: () => _selectView(viewType),
              ),
              if (viewType != views.last) const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLecturerGrid(List<LecturerModel> lecturers) {
    final screenWidth = MediaQuery.of(context).size.width;
    final gridWidth = screenWidth - 28;
    final crossAxisCount = _getCrossAxisCount(gridWidth);
    final itemHeight = _getGridItemHeight(gridWidth);

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 110),
      itemCount: lecturers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: itemHeight,
      ),
      itemBuilder: (context, index) {
        final lecturer = lecturers[index];
        return _LecturerCard(
          lecturer: lecturer,
          viewType: _selectedView,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LecturerDetailPage(
                  lecturer: lecturer,
                ),
              ),
            ).then((_) {
              setState(() {});
            });
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No lecturers found.',
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Container(
        height: 68,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFBFC5CB).withOpacity(0.72),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: _BottomNavItem(
                isSelected: true,
                icon: Icons.home_rounded,
                label: 'home',
                onTap: () => Navigator.pop(context),
              ),
            ),
            const Expanded(
              child: _BottomNavItem(
                isSelected: false,
                icon: Icons.more_time_rounded,
                label: '',
              ),
            ),
            const Expanded(
              child: _BottomNavItem(
                isSelected: false,
                icon: Icons.upload_rounded,
                label: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LecturerCard extends StatelessWidget {
  const _LecturerCard({
    required this.lecturer,
    required this.viewType,
    required this.onTap,
  });

  final LecturerModel lecturer;
  final LecturerViewType viewType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (viewType == LecturerViewType.extraLarge) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD9DDE2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    lecturer.imageUrl,
                    width: 74,
                    height: 74,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _LecturerCardText(lecturer: lecturer),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = viewType == LecturerViewType.large
            ? 140.0
            : constraints.maxWidth * 0.72;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: const Color(0xFFD9DDE2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: double.infinity,
                      height: imageHeight.clamp(82.0, 145.0),
                      child: Image.network(
                        lecturer.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _LecturerCardText(lecturer: lecturer),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LecturerCardText extends StatelessWidget {
  const _LecturerCardText({
    required this.lecturer,
  });

  final LecturerModel lecturer;

  @override
  Widget build(BuildContext context) {
    final secondLine = lecturer.department.shortLabelLine2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                lecturer.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Color(0xFFBDBDBD),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${lecturer.quotaLeft}',
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          lecturer.department.shortLabelLine1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF2E2E2E),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (secondLine.isNotEmpty)
          Text(
            secondLine,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF2E2E2E),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
    );
  }
}

class _DropdownRadioTile extends StatelessWidget {
  const _DropdownRadioTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF111111),
                width: 1.6,
              ),
            ),
            child: isSelected
                ? const Center(
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Color(0xFF111111),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF111111),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.isSelected,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final bool isSelected;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF0D4AA3);

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          width: isSelected ? 122 : 72,
          height: 52,
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: icon == Icons.more_time_rounded ? 28 : 25,
                color: isSelected ? Colors.white : Colors.black,
              ),
              if (label.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class LecturerModel {
  const LecturerModel({
    required this.id,
    required this.name,
    required this.department,
    required this.imageUrl,
    required this.quotaLeft,
    required this.nid,
  });

  final String id;
  final String name;
  final LecturerDepartment department;
  final String imageUrl;
  final int quotaLeft;
  final String nid;

  String get displayName => '$name, S.tu, V.wx';
}

enum LecturerDepartment {
  informatics,
  business,
  electrical,
  mechanical,
  artsAndCulture,
}

extension LecturerDepartmentX on LecturerDepartment {
  String get label {
    switch (this) {
      case LecturerDepartment.informatics:
        return 'Informatics Engineering';
      case LecturerDepartment.business:
        return 'Business Management';
      case LecturerDepartment.electrical:
        return 'Electrical Engineering';
      case LecturerDepartment.mechanical:
        return 'Machine Engineering';
      case LecturerDepartment.artsAndCulture:
        return 'Arts and Cultural';
    }
  }

  String get shortLabelLine1 {
    switch (this) {
      case LecturerDepartment.informatics:
        return 'Informatics';
      case LecturerDepartment.business:
        return 'Business';
      case LecturerDepartment.electrical:
        return 'Electrical';
      case LecturerDepartment.mechanical:
        return 'Machine';
      case LecturerDepartment.artsAndCulture:
        return 'Arts and Cultural';
    }
  }

  String get shortLabelLine2 {
    switch (this) {
      case LecturerDepartment.informatics:
        return 'Engineering';
      case LecturerDepartment.business:
        return 'Management';
      case LecturerDepartment.electrical:
        return 'Engineering';
      case LecturerDepartment.mechanical:
        return 'Engineering';
      case LecturerDepartment.artsAndCulture:
        return '';
    }
  }
}

enum LecturerViewType {
  extraLarge,
  large,
  standard,
}

extension LecturerViewTypeX on LecturerViewType {
  String get label {
    switch (this) {
      case LecturerViewType.extraLarge:
        return 'Extra Large List';
      case LecturerViewType.large:
        return 'Large List';
      case LecturerViewType.standard:
        return 'Standard List';
    }
  }
}