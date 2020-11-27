//
//  PostService.swift
//  Cofin
//
//  Created by Cong on 2020/11/19.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase

final class PostService{
    
    
    static let shared: PostService = PostService()
    
    private init(){}
    
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    let POST_DB_REF: DatabaseReference = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
    
    let PHOTO_STORAGE_REF: StorageReference = Storage.storage().reference().child("photos")
    
    func uploadImage(image: UIImage, completionHandler: @escaping () -> Void){
        
        let postDataRef = POST_DB_REF.childByAutoId()
        
        guard let imageKey = postDataRef.key else {
            
            return
        }
        let imageStorageRef = PHOTO_STORAGE_REF.child("\(imageKey).jpg")
        
        
        let matadata = StorageMetadata()
        matadata.contentType = "image/jpg"
        
//        let data = data()
//        let uploadTask = imageStorageRef.putData(data, metadata: matadata)
//
//        uploadTask.obser
    }
    
    
    
}

