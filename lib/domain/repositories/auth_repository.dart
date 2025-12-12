import '../entities/user.dart'; //user entity’sini içe aktarıyoruz

abstract class AuthRepository {
  //authentication işlemleri için soyutlama (interface)
  Future<User> login(String email, String password); //giriş yapma fonksiyonu
  //domain katmanı sadece bu arayüzü tanır, data katmanının detaylarını bilmez
}
