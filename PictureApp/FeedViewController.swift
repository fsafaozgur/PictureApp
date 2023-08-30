//
//  FeedViewController.swift
//  PictureApp
//
//  Created by Safa on 29.08.2023.
//

import UIKit
import Firebase
import SDWebImage       //Resimleri asenkron olarak cekmek icin kullandigimiz kutuphane


class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {


    @IBOutlet weak var tableView: UITableView!
    
    //FireStore dan veriler bir Obje olarak cekecegimiz icin Post dizisi olusturuyoruz
    var postArray = [Post]()

    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        //Yukleme aninda verileri FireStore dan cekiyoruz
        fetchFromFirebase()


    }
    
    
    func fetchFromFirebase () {
        
        //FireStore ye baglaniyoruz
        let database = Firestore.firestore()
        
        //Post koleksiyonunda yer alan datalari tarih siralamasi ile cekiyoruz
        database.collection("Post").order(by: "tarih", descending: true).addSnapshotListener { snapshot, error in
            
            
            if error != nil {
                
                print (error!.localizedDescription)
            } else {
                
                //Veri geldimi diye kontrol yapiyoruiz
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    //Her islemde dizinin ustune eklemesin diye diziyi oncelikle sifirliyoruz daha sonra tum verileri ekleyecegiz
                    self.postArray.removeAll(keepingCapacity: false)

                    //Gelen verileri Post turunden diziye ekliyoruz
                    for data in snapshot!.documents {
                        
                        if let email = data.get("email") as? String {
                            
                            if let comment = data.get("comments") as? String {
                                
                                if let imageUrl = data.get("imageurl") as? String {
                                    
                                    let post = Post(email: email, comment: comment, imageUrl: imageUrl)
                                    
                                    self.postArray.append(post)
                                  
                                }
                            }

                        }
                          
                    }
                     
                }
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
   
        
        let feedCell : FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell

        feedCell.emailFeed.text = postArray[indexPath.row].email
        feedCell.commentFeed.text = postArray[indexPath.row].comment
        
        //Asenkron veri cektigimiz icin SDWebImage methotlarini kullaniyoruz
        feedCell.imageFeed.sd_setImage(with: URL(string : postArray[indexPath.row].imageUrl))

        return feedCell
    }
    


}
