import 'package:flutter/material.dart';
import 'mentoring_request_store.dart';
import 'lecturers_page.dart';

class LecturerDetailPage extends StatefulWidget {
  const LecturerDetailPage({
    super.key,
    required this.lecturer,
  });

  final LecturerModel lecturer;

  @override
  State<LecturerDetailPage> createState() => _LecturerDetailPageState();
}

class _LecturerDetailPageState extends State<LecturerDetailPage> {
  bool get _isRequested =>
      MentoringRequestStore.isRequested(widget.lecturer.id);

  void _requestCounseling() {
    MentoringRequestStore.request(
      RequestedLecturer(
        id: widget.lecturer.id,
        name: widget.lecturer.displayName,
        major: widget.lecturer.department.label,
        imageUrl: widget.lecturer.imageUrl,
        nid: widget.lecturer.nid,
        guidanceQuotaLeft: widget.lecturer.quotaLeft,
      ),
    );

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Counseling request sent.'),
      ),
    );
  }

  void _cancelRequest() {
    MentoringRequestStore.cancel();

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Counseling request canceled.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lecturer = widget.lecturer;

    return Scaffold(
      backgroundColor: const Color(0xFF363C45),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 18, 14, 0),
                child: Column(
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 26),
                    _buildDetailCard(lecturer),
                  ],
                ),
              ),
            ),
            _buildBottomNav(context),
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
              'Lecturer Detail',
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

  Widget _buildDetailCard(LecturerModel lecturer) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 390;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 22, 14, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFD9DDE2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: AspectRatio(
              aspectRatio: 1.25,
              child: Image.network(
                lecturer.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 22),
          _buildInfoRow('Name', lecturer.displayName, isCompact),
          const SizedBox(height: 12),
          _buildInfoRow('NID', lecturer.nid, isCompact),
          const SizedBox(height: 12),
          _buildInfoRow('Major', lecturer.department.label, isCompact),
          const SizedBox(height: 12),
          _buildQuotaRow(lecturer.quotaLeft, isCompact),
          const SizedBox(height: 24),
          _isRequested
              ? _buildRequestedActionRow()
              : _buildRequestButton(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isCompact) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isCompact ? 58 : 72,
          child: Text(
            '$label  :',
            style: const TextStyle(
              color: Color(0xFF111111),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF111111),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuotaRow(int quota, bool isCompact) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Number of guidance left :',
            style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFFBDBDBD),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$quota',
            style: const TextStyle(
              color: Color(0xFF111111),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: _requestCounseling,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D4AA3),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Request Counseling',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildRequestedActionRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: const Color(0xFF88A5D1),
                disabledForegroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Requested',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: _cancelRequest,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFD19A00),
                side: const BorderSide(
                  color: Color(0xFFD19A00),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
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
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
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