//
//  DirectionMapViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 18/05/23.
//

import UIKit
import MapKit
import ComponentUI

class DirectionMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var directionsTitleLabel: UILabel!
    
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directionsTitleLabel.showStyle(with: .content, weight: .semibold)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
