//
//  View.swift
//  TrackViewDemo
//
//  Created by liujiang on 2020/9/18.
//

import UIKit
import MapKit

class View: UIView {
    //limit scroll content view min and max height
    private final let scrollMenuMinHeight: CGFloat = 200
    private final let scrollMenuMaxHeight: CGFloat = 500 //assign to 1000 to see some difference
    //navigation bar height
    private final let headerBarHeight: CGFloat = (UIDevice.current.userInterfaceIdiom == .phone ? 44 : 50)+UIApplication.shared.statusBarFrame.height
    
    private var _mapView: MKMapView?
    private var _headBar: UIView?
    private var _listView: (bg: UIScrollView, contentView: UIView)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.startUpdateUserLocation()
        self.constructUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func startUpdateUserLocation() {
        self.mapView.showsUserLocation = true

    }
    
    @objc private func tapAction(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view  else {
            return
        }
        print("tap at \(self.listView.contentView.subviews.firstIndex(of: view) ?? -1)")
    }
   
}
/**
 @abstract: lazy properties
 note: store property is not allow in extension, so declare ' private lazy var ... = {}()' is not approved
 */
extension View {
    private func constructUI() {
        self.bringSubviewToFront(self.headBar)
        self.insertSubview(self.listView.bg, belowSubview: self.headBar)
        
        var topAnchor = self.listView.contentView.topAnchor
        let spacing:CGFloat = 8.0
        //insert rows
        let rowCount = 13
        for i in (1...rowCount) {
            let row = UIView()
            row.backgroundColor = randomColor()
            self.listView.contentView.addSubview(row)
            row.translatesAutoresizingMaskIntoConstraints = false
            row.topAnchor.constraint(equalTo: topAnchor, constant: spacing).isActive = true
            row.leadingAnchor.constraint(equalTo: row.superview!.leadingAnchor, constant: 0.0).isActive = true
            row.rightAnchor.constraint(equalTo: row.superview!.rightAnchor).isActive = true
            row.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
            if i == rowCount {
                row.bottomAnchor.constraint(equalTo: row.superview!.bottomAnchor, constant: 0).isActive = true
            }
          
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
            tap.delaysTouchesBegan = true
            row.addGestureRecognizer(tap)
            topAnchor = row.bottomAnchor
        }
        
    }
    private var mapView: MKMapView {
        get {
            if let view = _mapView {
                return view
            }
            let mapView = MKMapView(frame: CGRect.zero)
            self.addSubview(mapView)
            mapView.translatesAutoresizingMaskIntoConstraints = false
            mapView.topAnchor.constraint(equalTo: mapView.superview!.topAnchor).isActive = true
            mapView.leadingAnchor.constraint(equalTo: mapView.superview!.leadingAnchor).isActive = true
            mapView.bottomAnchor.constraint(equalTo: mapView.superview!.bottomAnchor).isActive = true
            mapView.rightAnchor.constraint(equalTo: mapView.superview!.rightAnchor).isActive = true
            
            mapView.mapType = .standard
            mapView.userTrackingMode = .follow
            if #available(iOS 9.0, *) {
                mapView.showsCompass = false
                mapView.showsScale = false
            }
            _mapView = mapView
            return mapView
        }
    }
    
    private var headBar: UIView {
        get {
            if let bar = _headBar {
                return bar
            }
            
            let view = UIView()
            self.addSubview(view)
            view.backgroundColor = UIColor.white
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: view.superview!.topAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: view.superview!.rightAnchor).isActive = true
            view.heightAnchor.constraint(equalToConstant: headerBarHeight).isActive = true
            
            _headBar = view
            return view
        }
    }
    
    private var listView: (bg: UIScrollView, contentView: UIView) {
        get {
            if let list = _listView {
                return list
            }
            let listView = UIScrollView(frame: CGRect.zero)
            self.addSubview(listView)
            listView.translatesAutoresizingMaskIntoConstraints = false
            listView.topAnchor.constraint(equalTo: listView.superview!.bottomAnchor, constant: -scrollMenuMaxHeight).isActive = true
            listView.leadingAnchor.constraint(equalTo: self.headBar.leadingAnchor, constant: 0).isActive = true
            listView.trailingAnchor.constraint(equalTo: self.headBar.trailingAnchor, constant: 0).isActive = true
            listView.heightAnchor.constraint(equalToConstant: scrollMenuMaxHeight).isActive = true
            listView.contentInset = UIEdgeInsets(top: scrollMenuMaxHeight-scrollMenuMinHeight, left: 0, bottom: 0, right: 0)
            if #available(iOS 11.0, *) {
                listView.contentInsetAdjustmentBehavior = .never
            }
            listView.showsVerticalScrollIndicator = false
            listView.showsHorizontalScrollIndicator = false
            
            let view = UIView()
            view.backgroundColor = UIColor(red: 245.0/255, green: 245/255.0, blue: 245/255.0, alpha: 1)
            listView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: view.superview!.topAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: view.superview!.widthAnchor).isActive = true
//            view.heightAnchor.constraint(greaterThanOrEqualTo: listView.superview!.heightAnchor, constant: -headerBarHeight ).isActive = true
            
            let footer = UIView()
            footer.translatesAutoresizingMaskIntoConstraints = false
            footer.backgroundColor = view.backgroundColor
            view.addSubview(footer)
            footer.topAnchor.constraint(equalTo: footer.superview!.bottomAnchor).isActive = true
            footer.leadingAnchor.constraint(equalTo: footer.superview!.leadingAnchor).isActive = true
            footer.rightAnchor.constraint(equalTo: footer.superview!.rightAnchor).isActive = true
            footer.heightAnchor.constraint(equalToConstant: scrollMenuMinHeight).isActive = true
            _listView = (listView, view)
            return (listView, view)
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let view = super.hitTest(point, with: event)
        let relativeOffsetY = self.listView.bg.contentOffset.y + (scrollMenuMaxHeight - scrollMenuMinHeight)
        let absoluteY = self.frame.height - min(scrollMenuMinHeight + relativeOffsetY, scrollMenuMaxHeight)
        return point.y > absoluteY ? super.hitTest(point, with: event) : self.mapView.hitTest(point, with: event)
    }
}

let randomColor = {
    () -> UIColor in
    return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
}
