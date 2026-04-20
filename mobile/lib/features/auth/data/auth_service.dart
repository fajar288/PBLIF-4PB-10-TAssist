class AuthService {
  static const String mahasiswaEmail = 'mahasiswa@gmail.com';
  static const String mahasiswaPassword = 'mahasiswa123';

  static const String dosenEmail = 'dosen@gmail.com';
  static const String dosenPassword = 'dosen123';

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final normalizedEmail = email.trim().toLowerCase();
    final normalizedPassword = password.trim();

    if (normalizedEmail.isEmpty || normalizedPassword.isEmpty) {
      return const AuthResult(
        isSuccess: false,
        message: 'Email dan password wajib diisi.',
      );
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(normalizedEmail)) {
      return const AuthResult(
        isSuccess: false,
        message: 'Format email tidak valid.',
      );
    }

    if (normalizedEmail == mahasiswaEmail &&
        normalizedPassword == mahasiswaPassword) {
      return const AuthResult(
        isSuccess: true,
        message: 'Login berhasil.',
        role: 'mahasiswa',
      );
    }

    if (normalizedEmail == dosenEmail &&
        normalizedPassword == dosenPassword) {
      return const AuthResult(
        isSuccess: true,
        message: 'Login berhasil.',
        role: 'dosen',
      );
    }

    return const AuthResult(
      isSuccess: false,
      message: 'Email atau password salah.',
    );
  }
}

class AuthResult {
  final bool isSuccess;
  final String message;
  final String? role;

  const AuthResult({
    required this.isSuccess,
    required this.message,
    this.role,
  });
}