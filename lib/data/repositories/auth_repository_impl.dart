import '../../domain/entities/user.dart'; //user entity’si kullanılıyor
import '../../domain/repositories/auth_repository.dart'; //repository arayüzünü içe aktarıyoruz
import '../datasources/auth_remote_data_source.dart'; //veri kaynağını içe aktarıyoruz

class AuthRepositoryImpl implements AuthRepository {
  //domain’deki authrepository arayüzünün gerçek uygulaması
  final AuthRemoteDataSource
  remote; //remote dataource referansı (API veya internet isteği gibi)

  AuthRepositoryImpl(this.remote); //constructor ile datasource enjekte ediliyor

  @override
  Future<User> login(String email, String password) {
    //authrepository arayüzündeki login metodunu uyguluyoruz
    return remote.login(
      email,
      password,
    ); //istek doğrudan remotedataSource'a yönlendirilir
  }
}
