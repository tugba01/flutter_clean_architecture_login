--Flutter Clean Architecture & TDD Projesi--
Bu proje, ölçeklenebilir proje mimarilerini öğrenmek ve **Clean Architecture** (Temiz Mimari) yapısını uygulamalı olarak göstermek amacıyla geliştirilmiştir.

Uygulama temel olarak bir giriş (Login) senaryosunu içerir. Geliştirme sürecinde **TDD (Test-Driven Development)** yaklaşımı izlenmiş, yani kodlardan önce testler yazılmıştır.

## Projenin Amacı
Spagetti kod yapısından kaçınarak; veri, iş mantığı ve arayüz katmanlarını birbirinden ayırmaktır. Böylece proje büyüse bile yönetilebilir ve test edilebilir kalması hedeflenmiştir.

## Kullanılan Yapılar
Projede aşağıdaki teknolojiler ve mimari prensipler kullanıldı:

- **Mimari:** Clean Architecture (Data, Domain, Presentation katmanları).
- **State Management:** Flutter Bloc (Cubit) yapısı.
- **Tasarım:** Responsive tasarım için `Stack` ve `Positioned` widget'ları kullanıldı. Arayüzde özel animasyonlu stickerlar bulunuyor.
- **Test:** UseCase katmanı için Unit Testler yazıldı.

## Klasör Yapısı
Proje klasörleri Clean Architecture mantığına göre şu şekilde ayrılmıştır:

- `lib/domain`: Uygulamanın iş kuralları (Entity ve UseCase'ler) burada.
- `lib/data`: Veri kaynağı (Datasource) ve Repository işlemleri.
- `lib/presentation`: Ekranlar (Pages) ve State yönetimi (Cubit).
- `test/`: TDD kapsamında yazılan test dosyaları.

## Projeyi Çalıştırma

Projeyi bilgisayarınızda çalıştırmak için terminale sırasıyla şu komutları yazabilirsiniz:

1. Kütüphaneleri yükleyin:
''' flutter pub get
2. Uygulamayı başlatın:
''' flutter run

## Testleri Kontrol Etme
Yazdığım testlerin başarılı olup olmadığını görmek için terminalde şu komutu çalıştırabilirsiniz:
''' flutter test
