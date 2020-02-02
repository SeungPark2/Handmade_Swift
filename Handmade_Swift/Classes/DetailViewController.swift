//
//  DetailViewController.swift
//  Handmade_Swift
//
//  Created by PST on 2020/01/31.
//  Copyright © 2020 PST. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView?
    
    @IBOutlet weak var imageScrollView: ImageScrollView?
    
    @IBOutlet weak var trackNameLabel: UILabel?
    @IBOutlet weak var artistLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    
    @IBOutlet weak var contentView: UIView?
    @IBOutlet weak var webButton: UIButton?
    @IBOutlet weak var sharedButton: UIButton?
    @IBOutlet weak var fileSizeLabel: UILabel?
    @IBOutlet weak var trackContentRatingLabel: UILabel?
    @IBOutlet weak var versionLabel: UILabel?
    @IBOutlet weak var versionButton: UIButton?
    
    @IBOutlet weak var realseNoteTextView: UITextView?
    @IBOutlet weak var descriptionTextView: UITextView?
    
    @IBOutlet weak var categoryView: CategoryView?
    
    var serviceList: ServiceList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = "핸드메이드"
        
        // Screenshots ScrollView
        imageScrollView?.imageUrlList = serviceList?.screenshotUrls
        
        // Contens View
        trackNameLabel?.text = serviceList?.trackName
        artistLabel?.text = serviceList?.artistName
                
        // 포멧터(가격, 파일 크기)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        // 가격
        if serviceList?.formattedPrice.contains("무료") ?? false {
            
            priceLabel?.text = "무료"
        }
        else {
            
            let price = Int(serviceList?.price ?? 0.0)
            
            if let formattedNumber = formatter.string(from: NSNumber(value: price)) {
                
                let string = NSMutableAttributedString(string: "\(formattedNumber)원")
                
                let atrribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let range = NSRange(location: string.length - 1, length: 1)
                string.addAttributes(atrribute, range: range)
                
                priceLabel?.attributedText = string
            }
        }
        
        // 파일 크기
        let fileSize = Int(serviceList?.fileSizeBytes ?? "0")
        let mbSize = (fileSize ?? 0) / 1024 / 1024
        
        if let formatterSize = formatter.string(from: NSNumber(value: mbSize)) {
            
            fileSizeLabel?.text = "\(formatterSize)MB"
        }
        
        // 연령
        trackContentRatingLabel?.text = serviceList?.trackContentRating
        
        // 새로운 기능: 버전
        versionLabel?.text = serviceList?.version
        
        // 새로운 기능: 내용
        realseNoteTextView?.text = serviceList?.releaseNotes
        // 새로운 기능 내용 숨김 처리
        showReleaseNoteButtonTouchUpInside(versionButton!)
        
        // 설명
        descriptionTextView?.text = serviceList?.description
        
        // 카테고리
        categoryView?.genereList = serviceList?.genres
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        
        // Set Image ScrollView
        imageScrollView?.frame.size.height = (imageScrollView?.contentSize.height ?? 0) + 20
        contentView?.frame.origin.y = (imageScrollView?.frame.maxY ?? 0) + 8
        categoryView?.frame.origin.y = (contentView?.frame.maxY ?? 0) + 8
        
        // Set Main ScrollView
        scrollView?.frame.size.height = UIScreen.main.bounds.height
        scrollView?.contentSize = CGSize(width: (scrollView?.frame.width ?? 0), height: (categoryView?.frame.maxY ?? 0) + 44)
    }
   
    @IBAction func webButtonTouchUpInside(_ sender: UIButton) {
        
        let trackViewUrl = serviceList?.trackViewUrl ?? "0"
        
        if let url = URL(string: trackViewUrl) {
            
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func shareButtonTouchUpInside(_ sender: UIButton) {
        
        let trackViewUrl = serviceList?.trackViewUrl
        let items = [trackViewUrl]
        let viewController = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        viewController.excludedActivityTypes = []
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func showReleaseNoteButtonTouchUpInside(_ sender: UIButton) {
        
        if sender.isSelected {
            
            // Hidden ReleaseNote
            let height = self.realseNoteTextView?.frame.size.height
            
            self.scrollView?.contentSize.height -= height ?? 0
            self.descriptionTextView?.frame.origin.y -= height ?? 0
            self.contentView?.frame.size.height -= height ?? 0
            self.categoryView?.frame.origin.y -= height ?? 0
            
            self.realseNoteTextView?.frame.size.height = 0
            
            if let arrowDownImage = UIImage(systemName: "arrow.down") {
                versionButton?.setImage(arrowDownImage, for: .normal)
            }
        }
        
        else {
            
            // Show ReleaseNote
            let size = self.realseNoteTextView?.sizeThatFits(CGSize(width: self.realseNoteTextView?.frame.size.width ?? 0, height: self.realseNoteTextView?.frame.size.height ?? 0))
            self.realseNoteTextView?.frame.size.height = size?.height ?? 0
            
            self.scrollView?.contentSize.height += size?.height ?? 0
            self.descriptionTextView?.frame.origin.y += size?.height ?? 0
            self.contentView?.frame.size.height += size?.height ?? 0
            self.categoryView?.frame.origin.y += size?.height ?? 0
            
            if let arrowUpImage = UIImage(systemName: "arrow.up") {
                versionButton?.setImage(arrowUpImage, for: .normal)
            }
        }
        
        sender.isSelected = !sender.isSelected
    }
    
}

class ImageScrollView: UIScrollView {
    
    let imageSpace = 219    // 219 = Image Space(10) + Image Width(209)
    
    var x = 10, y = 10
    var width = 209, height = 352
    
    var imageUrlList: [String]? = nil {
        
        didSet {
            
            update()
        }
    }
    
    func update() {
        
        if let list = imageUrlList {    // 옵셔널 해제하지 않으면 맵 처리 되지 않음
            
            let _ = list.map({ (string) in
                
                if let url = URL(string: string) {
                    
                    do {
                        
                        let data = try Data(contentsOf: url)
                            
                            if let image = UIImage(data: data) {
                            
                                // 이미지 사이즈에 맞춰서 이미지뷰 비율 변경
                                var frame = CGRect(x: x, y: y, width: width, height: height)
                                
                                if image.size.width > image.size.height {
                                    
                                    frame = CGRect(x: x, y: y, width: height, height: width)
                                }
                                
                                // 이미지뷰 생성
                                let imageView = UIImageView(frame: frame)
                                imageView.contentMode = .scaleAspectFit
                                imageView.image = image
                                addSubview(imageView)
                                
                                x += Int(imageView.frame.size.width) + 10
                                
                                // 이미지 스크롤뷰 ContentSize 조정
                                contentSize = CGSize(width: x, height: Int(imageView.frame.size.height))
                            }
                        }
                        catch let error {
                            
                            print(error)
                    }
                }
            })
        }
    }
}

class CategoryView: UIView {
    
    var x = 8, y = 54
    
    var genereList: [String]? = nil {
        
        didSet {
            
            update()
        }
    }
    
    func update() {
        
        if let list = genereList {
            
            let _ = list.map({ (string) in
                
                let text = " #\(string) "
                let textWdith = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]).width
                
                let frame = CGRect(x: x, y: y, width: Int(textWdith), height: 22)
                let label = UILabel(frame: frame)
                label.text = text
                label.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1) // 200, 200, 200
                label.font = UIFont.systemFont(ofSize: 12)
                label.cornerRadius = 2
                label.borderWidth = 1
                label.borderColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)  // 200, 200, 200
                addSubview(label)
                
                x = Int(frame.maxX) + 8
            })
        }
    }
}
