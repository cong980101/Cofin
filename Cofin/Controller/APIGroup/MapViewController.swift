//
//  MapViewController.swift
//  Cofin
//
//  Created by Cong on 2020/11/9.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var apiData: APIData!
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //navigationController
        
        
        let lat = Double(apiData.latitude)
        let lon = Double(apiData.longitude)
        let name = apiData.name
        getLocation(lat: lat!, lon: lon!, name: name)

        // Do any additional setup after loading the view.
    }
    
    func getLocation(lat: CLLocationDegrees, lon: CLLocationDegrees, name: String){
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let xScale: CLLocationDegrees = 0.0025
        let yScale: CLLocationDegrees = 0.0025
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: xScale, longitudeDelta: yScale)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()    // 生成大頭針
        annotation.coordinate = location    // 設定大頭針座標
        annotation.title = name   // 加入標題
        mapView.addAnnotation(annotation)   // 在地圖上加入大頭針
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
