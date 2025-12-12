class User {
  //kullanıcıyı temsil eden en basit veri sınıfı (entity)
  final String id; //kullanıcının benzersiz id bilgisi
  final String email; //kullanıcının email adresi

  User({required this.id, required this.email}); //entity’nin constructor’ı
}
