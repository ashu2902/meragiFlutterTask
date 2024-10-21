import '../models/user.dart';

class AuthController {
  Future<User> login(String email, String password) async {
    // Simulating API call here
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'meragi@events.com' && password == 'password') {
      return User(email: email);
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
