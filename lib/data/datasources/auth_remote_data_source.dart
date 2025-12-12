import '../models/user_model.dart'; //usermodel sınıfını kullanabilmek için model klasörünü içe aktarıyoruz

class AuthRemoteDataSource {
  //uzaktaki (API vb.) bir veri kaynağını simüle eden sınıf
  Future<UserModel> login(String email, String password) async {
    //login fonksiyonu email ve şifre alır ve usermodel döndürür
    await Future.delayed(
      const Duration(seconds: 1),
    ); //gerçek bir API isteği gibi gecikme ekliyoruz

    if (email == "test@mail.com" && password == "1234") {
      //eğer email ve şifre doğruysa başarılı giriş simüle edilir
      return UserModel(
        id: "1",
        email: email,
      ); //doğru girişte bir usermodel nesnesi döneriz
    } else {
      throw Exception("Hatalı Giriş."); //hatalı girişte istisna fırlatılır
    }
  }
}
