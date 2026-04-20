import 'package:flutter/material.dart';

class DashboardDosenPage extends StatefulWidget {
  const DashboardDosenPage({super.key});

  @override
  State<DashboardDosenPage> createState() => _DashboardDosenPageState();
}

class _DashboardDosenPageState extends State<DashboardDosenPage> {
  int selectedIndex = 0;

  final List<_CounselingRequest> dummyRequests = const [
    _CounselingRequest(
      name: 'Aruna Fajar Prayoga',
      status: 'Pending',
      avatarText: 'A',
    ),
    _CounselingRequest(
      name: 'Eleanor Pena',
      status: 'Pending',
      avatarText: 'E',
    ),
    _CounselingRequest(
      name: 'Ralph Edwards',
      status: 'Pending',
      avatarText: 'R',
    ),
  ];

  void _showUnavailableFeature(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fitur $featureName belum tersedia.'),
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 1) {
      _showUnavailableFeature('schedule');
    } else if (index == 2) {
      _showUnavailableFeature('students');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363C45),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildCounselingCard(),
              const SizedBox(height: 18),
              const Spacer(),
              _buildBottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Aruna Fajar!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Welcome to TAssist',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.9),
              width: 2,
            ),
            color: Colors.white,
          ),
          child: const Icon(
            Icons.person,
            size: 34,
            color: Color(0xFF0D4AA3),
          ),
        ),
      ],
    );
  }

  Widget _buildCounselingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFD9DDE2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Icon(
                Icons.mail_rounded,
                color: Color(0xFF111111),
                size: 22,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Counseling Request',
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < dummyRequests.length; i++) ...[
            _RequestCard(request: dummyRequests[i]),
            if (i != dummyRequests.length - 1) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 72,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFBFC5CB).withOpacity(0.72),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: _NavItem(
              isSelected: selectedIndex == 0,
              icon: Icons.home_rounded,
              label: 'home',
              onTap: () => _onNavTap(0),
            ),
          ),
          Expanded(
            child: _NavItem(
              isSelected: selectedIndex == 1,
              icon: Icons.more_time_rounded,
              label: selectedIndex == 1 ? 'schedule' : '',
              iconSize: 25,
              onTap: () => _onNavTap(1),
            ),
          ),
          Expanded(
            child: _NavItem(
              isSelected: selectedIndex == 2,
              icon: Icons.groups_rounded,
              label: selectedIndex == 2 ? 'students' : '',
              iconSize: 25,
              onTap: () => _onNavTap(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final _CounselingRequest request;

  const _RequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0D4AA3),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Text(
              request.avatarText,
              style: const TextStyle(
                color: Color(0xFF0D4AA3),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${request.name}\n',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: request.status,
                    style: const TextStyle(
                      color: Color(0xFFFFC107),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
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
}

class _NavItem extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final double iconSize;

  const _NavItem({
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconSize = 25,
  });

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
                size: iconSize,
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

class _CounselingRequest {
  final String name;
  final String status;
  final String avatarText;

  const _CounselingRequest({
    required this.name,
    required this.status,
    required this.avatarText,
  });
}