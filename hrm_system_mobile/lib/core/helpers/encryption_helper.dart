
import 'package:encrypt/encrypt.dart';

///
/// [EncryptHelper]
///
class EncryptHelper {

  static final key = Key.fromLength(32);
  static final iv = IV.fromLength(8);
  static Encrypter? encrypter;
  static Encrypted? encrypted;

  /// It initializes the encryption method.
  /// 
  /// Args:
  ///   [dataToBeEncrypted] (String): The data that you want to encrypt.
  ///   [aesMethodKey] (Key): The key used to encrypt the data.
  ///   [aesIV] (IV): The initialization vector for the AES encryption method.
  ///   [aesMethod] (bool): If you want to use AES encryption, set this to true. Defaults to false
  static void init(String dataToBeEncrypted, {Key? aesMethodKey, IV? aesIV, bool aesMethod = false}) {
    encrypter = Encrypter(aesMethod ? AES(aesMethodKey!, mode: AESMode.cbc) : Salsa20(key));
    if (aesMethod) {
      encrypted = encrypter!.encrypt(dataToBeEncrypted, iv: aesIV);
    } else {
      encrypted = encrypter!.encrypt(dataToBeEncrypted, iv: iv);
    }
  }

  /// 
  /// It returns an encrypted string in base64 format.
  /// 
  static String getEncryptString() {
    return encrypted!.base64;
  } 

  /// It decrypts a string.
  /// 
  /// Args:
  ///   [encrypt] (String): The encrypted string
  ///   [aesMethodKey] (Key): The key used to encrypt the data.
  ///   [aesIV] (IV): The IV used in the encryption process.
  ///   [aesMethod] (bool): Whether to use AES encryption, default false. Defaults to false
  ///   [callBack] (Function(Key, IV)?): The callback function after the key and IV are generated.
  static String getDecryptString(String encrypt, {Key? aesMethodKey, IV? aesIV, bool aesMethod = false, Function(Key, IV)? callBack}) {
    Encrypter encrytper = encrypter ?? Encrypter(aesMethod ? AES(aesMethodKey!, mode: AESMode.cbc) : Salsa20(key));
    Encrypted encryptedValue = Encrypted.fromBase64(encrypt);
    if (aesMethod) {
      if (callBack != null) {
        callBack(aesMethodKey!, aesIV!);
      }
      return encrytper.decrypt(encryptedValue, iv: aesIV);
    } else {
      if (callBack != null) {
        callBack(aesMethodKey!, aesIV!);
      }
      return encrytper.decrypt(encryptedValue, iv: iv);
    }
  } 

}