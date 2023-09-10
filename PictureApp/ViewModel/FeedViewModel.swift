//
//  FeedViewModel.swift
//  PictureApp
//
//  Created by Safa on 10.09.2023.
//

import Foundation


struct FeedTableViewModel {
    
    var postList : [Post]
    
    func numberOfRowSection() -> Int {
        return self.postList.count
    }
    
    func cellForRowAt (index : Int) -> FeedViewModel {
        
        let post = self.postList[index]
        return FeedViewModel(post: post)
    }
    
}




struct FeedViewModel {
    
    var post : Post
    
    var email : String {
        return post.email
    }
    
    var comment : String {
        return post.comment
    }
    
    var imageUrl : String {
        return post.imageUrl
    }
    
}
