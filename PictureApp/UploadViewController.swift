//
//  UploadViewController.swift
//  PictureApp
//
//  Created by Safa on 29.08.2023.
//

import UIKit
import FirebaseStorage
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageCommentTextField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    
    override func viewDidLoad() {
        
        //Resim secilmedigi surece tus aktif olmayacak
        uploadButton.isEnabled = false
        
        //Resim secmek icin imageView uzerine basildiginda algilayacak GestureRecognizer
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSelect))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //Secim penceresi
    @objc func imageSelect(){
        let pickerContoller = UIImagePickerController()
        pickerContoller.delegate = self
        
        //Secilen resim uzernde oynama yapilmasin
        pickerContoller.allowsEditing = false
        
        //Resmin gelecegi kaynagi galeri olarak belirledik
        pickerContoller.sourceType = .photoLibrary
        
        //Resim secme ekrani aktif hale getirildi
        present(pickerContoller, animated: true)
    }
    
    
    //Secim yapildiginda calisacak kodlar
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Edite izin vermedigimiz icin orjinal fotoyu aldik
        imageView.image = info[.originalImage] as? UIImage
        
        //Resim scildigi icin artik Upload tusu aktif hale getiriliyor
        uploadButton.isEnabled = true
        
        //Secim ekrani ekrandan kaldiriliyor
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func uploadClicked(_ sender: Any) {
        
        //Storage a baglaniliyor
        let storage = Storage.storage()
        
        //Storagenin referansi aliniyor
        let storageReference = storage.reference()
        
        //Referans dan yararlanilarak bir alt dizine gidiliyor
        let mediaDirectory = storageReference.child("photo")
        
        //Secilerek imageView da gosterilen resmi sikistirarak Data turune ceviriyoruz
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            //Resimler karismasin diye benzersiz bir id uretiyoruz
            let uuid = UUID().uuidString
            
            //Dosya referansini kullanarak bir benzersiz id ile resmi isimlendiriyoruz
            let imageReference = mediaDirectory.child("\(uuid).jpg")
            
            //Referansini belirledigimiz dosya yolundaki dosyamizi veritabanina yukluyoruz
            imageReference.putData(data, metadata: nil) { storageMetaData, error in
                if error != nil {
                    self.errorMessage(title: "Error!", message: error?.localizedDescription ?? "Error Occured!")
                    
                } else {
                    
                    //Yukleme basarili ise FireStore ye kaydetmek icin indirme linkini aliyoruz
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            
                            //Linki FireStore ye String formatinda kaydedecegiz
                            let imageURL = url?.absoluteString
                            
                            //FireStore ye baglaniyoruz
                            let firestoraDatabase = Firestore.firestore()
                            
                            //Opsiyonel geldigi icin kayit oncesi opsiyonellikten cikartiyoruz
                            
                            //url degiskeni donusum esnasinda nullable oldugu icin, bos gelme ihtimaline karsi bir kontrol yapiyoruz
                            if let imageURL = imageURL {
                                
                                
                                // [String : Any] turunde kayit edecegimiz postu olusturuyoruz
                                let firestorePost = ["imageurl" : imageURL, "comments" : self.imageCommentTextField.text!, "email" : Auth.auth().currentUser?.email, "tarih" : FieldValue.serverTimestamp()] as [String : Any]
                                
                                //Olusturdugumuz post u FireStore ye ekliyoruz
                                firestoraDatabase.collection("Post").addDocument(data : firestorePost) { error in
                                    if error != nil {
                                        
                                        self.errorMessage(title: "Error!", message: error?.localizedDescription ?? "Error Ocrrured!")
                                    }else {
                                        
                                        //Ekleme basarili ise bir sonraki ekleme icin tum alanlari ilk bastaki konumuna getiriyoruz
                                        self.imageCommentTextField.text = ""
                                        self.imageView.image = UIImage(named: "image-select")
                                        
                                        //Son olarak Feed TabBar a gidiyoruz
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                                
                            }
                        }
                        
                        
                    }
                    
                    
                    
                }
            }
        }
        
        
    }
    
    
    func errorMessage (title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alertController.addAction(button)
        present(alertController, animated: true)
    }
    
    
}
