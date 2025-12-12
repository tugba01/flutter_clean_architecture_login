import '../entities/user.dart'; //user entity’sini içe aktarıyoruz
import '../repositories/auth_repository.dart'; //authrepository arayüzünü içe aktarıyoruz

class LoginUseCase {
  //kullanıcının giriş yapması işlemini gerçekleştiren usecase
  final AuthRepository
  repository; //usecase, repository üzerinden data katmanına erişir

  LoginUseCase(
    this.repository,
  ); //constructor ile repository bağımlılığı enjekte edilir

  Future<User> call(String email, String password) {
    //dart'ta usecase'lerde call operatörü sık kullanılır
    return repository.login(
      email,
      password,
    ); //repository’e login isteği gönderilir
  }
}
