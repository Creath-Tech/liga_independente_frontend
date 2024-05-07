class AuthService {
  Future<bool> signIn(String username, String password) async {
    return (username == "admin" && password == "123") ? true : false;
  }
}
