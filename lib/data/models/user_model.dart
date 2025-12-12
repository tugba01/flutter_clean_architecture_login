import '../../domain/entities/user.dart'; //domain katmanındaki user entity’sini içe aktarıyoruz

class UserModel extends User {
  //usermodel, user sınıfından miras alır
  //model genelde JSON’dan veri çekmek için kullanılır
  UserModel({required String id, required String email})
    : super(
        id: id,
        email: email,
      ); //usermodel oluşturulurken veriler user entity’sine aktarılır
}
