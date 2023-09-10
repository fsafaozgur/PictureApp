
# PictureApp Uygulaması

## Giriş
Proje kapsamında; FireBase servisinin kütüphaneleri kullanılarak bir fotoğraf paylaşım uygulaması MVVM tasarım kalıbı ile tasarlanmıştır. 

## Hedef
Proje ile birlikte; FireBase servisleri kullanılarak kullanıcı kayıt, kullanıcı girişi, fotoğraf ve yorumdan oluşan kullanıcı iletilerinin web tabanlı kayıt edilmesi ve kullanıcıya bir arayüz ile sunulması işlemlerinin MVVM tasarım kalıbı ile nasıl tasarlanacağının ortaya konulması amaçlanmıştır. 

## Uygulama Kullanımı
Uygulama ilk olarak Firebase Authentication ile kullanıcı kaydı ve giriş işlemi ile başlamakta, uygulama içerisinden çıkış yapılmadığı sürece kullanıcı oturumu açık tutulmaktadır.

Giriş yapan kullanıcı, Upload bölümünden resim yükleyebilmekte, bu resim  Firebase Storage ile kayıt edilerek indirme linki alınmakta ve kullanıcı resmi kaydederken resim için yapmış olduğu yorum ile birlikte tüm bilgiler Firebase FireStore kullanılarak veritabanına kaydedilmektedir.

Kaydedilen fotoğraf ile bu fotoğrafa ait paylaşan bilgisi ve fotoğraf yorumu Feed sayfasında görüntülenebilmektedir. 
