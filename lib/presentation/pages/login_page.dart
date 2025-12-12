import 'package:flutter/material.dart'; //flutter'ın temel UI bileşenleri

import 'package:flutter_bloc/flutter_bloc.dart'; //cubit/bloc state yönetimi paketi
import 'package:google_fonts/google_fonts.dart'; //google fonts ile özel font kullanabilmek için
import '../cubit/login_cubit.dart'; //logincubit ve loginstate sınıflarını içe aktarıyoruz

//tilt sticker(animasyonlu)
class TiltSticker extends StatefulWidget {
  //ekranda hafifçe sağa sola dönme animasyonu yapan sticker widget
  final String asset; //sticker olarak kullanılacak resmin asset yolu
  final double width; //sticker genişliği
  final double top; //üstten konumu
  final double left; //soldan konumu

  const TiltSticker({
    super.key,
    required this.asset,
    required this.width,
    required this.top,
    required this.left,
  });

  @override
  State<TiltSticker> createState() => _TiltStickerState();
}

class _TiltStickerState extends State<TiltSticker>
    with SingleTickerProviderStateMixin {
  //tek animasyon kontrolü için mixin
  late AnimationController _controller; //tek animasyon kontrolü için mixin
  late Animation<double> _tilt; //sticker’ın dönüş animasyonu

  @override
  void initState() {
    super.initState();
    //animasyon kontrolcüsü: 3 saniyelik döngü, tersine dönerek tekrar eder
    _controller = AnimationController(
      vsync:
          this, //performans için gerekli; animasyonu bu widget senkronize eder
      duration: const Duration(
        seconds: 3,
      ), //3 saniyede bir sağa sola dönen animasyon
    )..repeat(reverse: true); //sağa sola dönüş animasyonu sürekli tekrar eder

    _tilt = Tween<double>(begin: -0.15, end: 0.15).animate(
      //tween: -0.15 ile 0.15 radyan arasında dönüş hareketi
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ), //tween: -0.15 ile 0.15 radyan arasında dönüş hareketi
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _tilt, //animasyon her değiştiğinde widget yeniden çizilir
      builder: (_, child) {
        return Positioned(
          //sticker’ı sayfadaki tam koordinatlarına yerleştiriyoruz
          top: widget.top,
          left: widget.left,
          child: Transform.rotate(
            angle: _tilt.value, //o anki animasyon değerine göre dönüş miktarı
            alignment:
                Alignment.bottomCenter, //dönüş ekseni sticker'ın alt tarafı
            child: child!,
          ),
        );
      },
      child: Image.asset(
        widget.asset,
        width: widget.width,
      ), //asıl sticker görüntüsü
    );
  }

  @override
  void dispose() {
    _controller
        .dispose(); //bellek sızıntılarını önlemek için controller yok edilmelidir
    super.dispose();
  }
}

//login page
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailCtrl = TextEditingController();
  final passCtrl =
      TextEditingController(); //email ve şifre alanı için controller’lar.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //üstte pastel renkli özel fontlu başlık (AppBar)
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8), //hafif transparan beyaz
        elevation: 0, //gölgeli görünümü kaldırır

        title: Text(
          "Clean Architecture Login", //sayfa başlığı
          style: GoogleFonts.pacifico(
            fontSize: 28,
            color: Colors.purple.shade700,
          ),
        ),
      ),

      //pastel gradient arka planı
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            //sayfa arka planı pastel renk gradyanı yukarıdan aşağıya
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 155, 100, 175), //pastel lila
              Color.fromARGB(255, 225, 139, 186), //pastel pembe
            ],
          ),
        ),

        //ana stack
        //stickerlar + formu üst üste bindirmek için Stack kullanılır
        child: Stack(
          children: [
            //animasyonlu stickerlar
            TiltSticker(
              asset: "assets/stickers/a.png",
              width: 130,
              top: -25,
              left: 170,
            ),

            TiltSticker(
              asset: "assets/stickers/b.png",
              width: 120,
              top: 100,
              left: 10,
            ),

            TiltSticker(
              asset: "assets/stickers/c.png",
              width: 90,
              top: 560,
              left: 300,
            ),

            TiltSticker(
              asset: "assets/stickers/d.png",
              width: 130,
              top: 460,
              left: 20,
            ),

            TiltSticker(
              asset: "assets/stickers/e.png",
              width: 100,
              top: 30,
              left: 600,
            ),

            TiltSticker(
              asset: "assets/stickers/f.png",
              width: 100,
              top: 100,
              left: 400,
            ),

            TiltSticker(
              asset: "assets/stickers/g.png",
              width: 100,
              top: 500,
              left: 600,
            ),

            //ortalanmış giriş formu
            Center(
              child: Container(
                padding: const EdgeInsets.all(24), //iç boşluk
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                ), //kenarlardan boşluk
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.85,
                  ), //hafif transparan kutu.
                  borderRadius: BorderRadius.circular(20), //köşeler yuvarlak
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.shade300.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, //gerektiği kadar yer kaplasın
                  children: [
                    TextField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: passCtrl,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true, //şifre gizli gösterilir
                    ),

                    const SizedBox(height: 20),

                    //bloc (cubit) ile durum yönetimi
                    BlocConsumer<LoginCubit, LoginState>(
                      //state değiştiğinde ui'a tepki vermek için listener kullanılır
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          //giriş başarılı ise snackbar gösterilir
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Hoş geldin ${state.user.email}"),
                            ),
                          );
                        }
                        if (state is LoginFailure) {
                          //hata durumunda hata mesajı gösterilir
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Hata: ${state.message}")),
                          );
                        }
                      },
                      builder: (context, state) {
                        //builder: ui'ın hangi state'e göre nasıl görüneceğini belirler
                        if (state is LoginLoading) {
                          //yüklenme sırasında buton yerine daire animasyonu gelir
                          return const CircularProgressIndicator();
                        }

                        return ElevatedButton(
                          //normal durumda görünen giriş butonu
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              216,
                              219,
                              222,
                            ),
                            foregroundColor: const Color.fromARGB(
                              255,
                              129,
                              67,
                              120,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 24,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            //cubit'in login fonksiyonu çağrılır
                            context.read<LoginCubit>().login(
                              emailCtrl.text,
                              passCtrl.text,
                            );
                          },
                          child: const Text("Giriş Yap"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
