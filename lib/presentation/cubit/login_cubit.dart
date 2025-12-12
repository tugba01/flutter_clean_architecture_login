import 'package:flutter_bloc/flutter_bloc.dart'; //bLoc kütüphanesi import ediliyor
import '../../domain/usecases/login_usecase.dart'; //usecase'i içe aktarıyoruz
import '../../domain/entities/user.dart'; //user entity’si import ediliyor

//state sınıfları
abstract class LoginState {} //bütün login state’lerinin ortak atası

class LoginInitial extends LoginState {} //ilk açılış durumu

class LoginLoading extends LoginState {} //giriş yapılıyor durumu

class LoginSuccess extends LoginState {
  //başarılı giriş sonrası dönen kullanıcı bilgisi
  final User user;
  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  //hata mesajı
  final String message;
  LoginFailure(this.message);
}

//cubit sınıfı

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase; //login işlemini yapacak useCase referansı
  LoginCubit(this.loginUseCase)
    : super(LoginInitial()); //başlangıç state: LoginInitial

  Future<void> login(String email, String password) async {
    emit(LoginLoading()); //işlem başlarken loading state yollanır

    try {
      final user = await loginUseCase(
        email,
        password,
      ); //usecase çağrılır ve kullanıcı bilgisi alınır
      emit(LoginSuccess(user)); //başarı durumu yayınlanır
    } catch (e) {
      emit(
        LoginFailure(e.toString()),
      ); //hata durumunda loginfailure emit edilir
    }
  }
}
