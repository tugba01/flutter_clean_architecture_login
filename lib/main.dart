import 'package:flutter/material.dart'; //flutter UI temel bileşenleri
import 'package:flutter_bloc/flutter_bloc.dart'; //bLoc(cubit) paketi

import 'data/datasources/auth_remote_data_source.dart'; //uzaktaki veri kaynağı (API simülasyonu)
import 'data/repositories/auth_repository_impl.dart'; //repository implementasyonu
import 'domain/usecases/login_usecase.dart'; //iş mantığı (usecase).
import 'presentation/cubit/login_cubit.dart'; //logincubit ve loginstate.
import 'presentation/pages/login_page.dart'; //uygulamanın ana ekranı olan loginpage

void main() {
  final remote = AuthRemoteDataSource(); //remote veri kaynağını oluşturduk
  final repo = AuthRepositoryImpl(
    remote,
  ); //remote'u repository'e verdik (dependency injection)
  final usecase = LoginUseCase(repo); //repository'i usecase'e verdik

  runApp(
    MyApp(usecase: usecase),
  ); //uygulama usecase ile çalışacak şekilde başlatıldı
}

class MyApp extends StatelessWidget {
  final LoginUseCase usecase; //myApp, LoginUseCase’i parametre olarak alır
  //myapp içindeki widget’ların usecase'e erişebilmesi için

  const MyApp({super.key, required this.usecase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //sağ üst köşedeki debug yazısını kaldırır
      home: BlocProvider(
        //tüm uygulamada logincubit erişilebilir olsun diye blocprovider kullanıyoruz
        //logincubit'i widget ağacına sağlıyoruz (state yönetimi için)
        create: (_) => LoginCubit(usecase), //cubit, usecase ile oluşturulur
        child: LoginPage(), //loginPage cubit'e erişebilir hale gelir
      ),
    );
  }
}
