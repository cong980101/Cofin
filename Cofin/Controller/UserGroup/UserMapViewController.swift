//
//  UserMapViewController.swift
//  Cofin
//
//  Created by Cong on 2020/11/24.
//

import UIKit
import MapKit

class UserMapViewController: UIViewController {
    
    var cafeData: UserCafeDatas?
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let data = cafeData{
            let geoCooder = CLGeocoder()
            geoCooder.geocodeAddressString(data.address, completionHandler: {placemarks, error in
                if let error = error{
                    print(error)
                    return
                }
                if let placemarks = placemarks{
                    let placemark = placemarks[0]
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = data.name
                    if let location = placemark.location{
                        annotation.coordinate = location.coordinate
                        
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
