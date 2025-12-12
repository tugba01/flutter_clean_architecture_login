import 'package:flutter_test/flutter_test.dart';

//1. entity (user modelim)
class User {
  final String id;
  final String name;
  const User({required this.id, required this.name});

  @override
  bool operator ==(Object other) => other is User && other.id == id;
  @override
  int get hashCode => id.hashCode;
}

//2.repository interface (soyut sınıf - clean arch gereği)
abstract class AuthRepository {
  Future<User> login(String email, String password);
}

//3.usecase (test ettiğimiz asıl iş mantığı katmanı)
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(String email, String password) async {
    return await repository.login(email, password);
  }
}

//test ortamı (mock data)

//4.mock repository (gerçek API yerine sahte veri dönen sınıfım)
class MockAuthRepository implements AuthRepository {
  @override
  Future<User> login(String email, String password) async {
    //doğru şifre girilirse kullanıcıyı döndürür
    if (email == "test@mail.com" && password == "1234") {
      return const User(id: "1", name: "Demo User");
    }
    //yanlış şifrede hata fırlatıyo
    throw Exception("Invalid credentials");
  }
}

//testlerin çalıştığı ana kısım
void main() {
  late LoginUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    //her testten önce nesneleri oluşturuyor
    mockRepository = MockAuthRepository();
    usecase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase TDD Testleri', () {
    //başarılı giriş (happy path)
    test(
      'Kullanıcı doğru bilgilerle girdiğinde User nesnesi dönmeli',
      () async {
        //act (eylem)
        final result = await usecase.call("test@mail.com", "1234");

        //assert (kontrol)
        expect(result.name, "Demo User");
        expect(result.id, "1");
      },
    );

    //hatalı Giriş (unhappy path)
    test('Hatalı şifre girildiğinde hata (Exception) fırlatmalı', () async {
      //act ve assert
      expect(
        () => usecase.call("test@mail.com", "yanlis_sifre"),
        throwsA(isA<Exception>()),
      );
    });
  });
}
