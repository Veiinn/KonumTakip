import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'tr_TR': {
          'Email': 'E-Posta',
        },
        'en_US': {
          'Türkçe':'Turkish',
          'İngilizce':'English',
          'Dil Değiştir':'Change language',
          'E-Posta': 'Email',
          'Şifre': 'Password',
          'Şifremi Unuttum': 'Forgot My Password',
          'Hesap Oluştur':'create Account',
          'KAMYONET\nKURYE\'YE\nHOŞGELDİN !':'WELCOME\nTO\nKAMYONET\nKURYE !',
          'İsim':'Name',
          'Soyad':'Surname',
          'Telefon':'Phone',
          'Zaten Hesabım Var':'Already Have an Account',
          'Bilgileri Eksiksiz Doldurunuz':'Fill in the Information Completely',
        }
      };
}
