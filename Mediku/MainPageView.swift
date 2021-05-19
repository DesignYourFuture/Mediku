//
//  MainPageView.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/03.
//

import UIKit
import MapKit
import SafariServices

class MainPageView : UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet weak var loctaionBtn: UIButton!
    
    @IBOutlet var pageControl: UIPageControl!
    
    var images = ["banner01.jpg","banner02.jpg","banner03.jpg"]
    var imgNum = 1
    let urlList = ["https://www.naver.com","https://www.konkuk.ac.kr","https://www.google.com"]
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var JsonTest = JsonParser()
    
    var locationAccessCheck = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JsonTest.readJson()
        
        
        
        // 배너를 위한 코드
        pageControl.numberOfPages = images.count // 전체 페이지 수
        pageControl.currentPage = 0 // 현재 페이지
        pageControl.pageIndicatorTintColor = UIColor.green // 페이지를 표시하는 부분의 색상을 의미 즉 페이지를 표시하는 페이지 컨트롤러의 색이 초록색으로 보인다.
        imgView.image = UIImage(named: images[0])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto(_:)))
        imgView.addGestureRecognizer(tapGesture)
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(MainPageView.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        //swipeLeft.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(MainPageView.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        //swipeRight.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeRight)
        
        
    }
    
    @objc func touchToPickPhoto(_ gesture : UIGestureRecognizer) {
      
        let url = URL(string: urlList[pageControl.currentPage])
        let safariViewController = SFSafariViewController(url: url!)
        
        present(safariViewController, animated: true, completion: nil)
        
        print("ASD")
        
        
    }
    
    @objc func respondToSwipeGesture(_ gesture : UIGestureRecognizer) {
        // 액션메서드 구현하기 인수는 스와이프 제스처를 행했을 때 실행할 메서드를 의미합니다. 그럼 스와이프 제스처를 행했을 때 실행할 액션 메서드를 구현해 보자!!
        //NSLog("asd")
        if let swipeGesture = gesture as? UISwipeGestureRecognizer { // 만일 제스처가 있다면

            // 스위치 문을 사용해 제스처의 방향에 따라 해당 방향의 이미지를 빨간색 이미지로 변경합니다.
            switch swipeGesture.direction {

                case UISwipeGestureRecognizer.Direction.right:
                    if imgNum > 1 {
                        imgNum -= 1
                        pageControl.currentPage = imgNum - 1
                    }
                    imgView.image = UIImage(named: "banner0" + String(imgNum) + ".jpg")
                    
                
                case UISwipeGestureRecognizer.Direction.left:
                    if imgNum < images.count {
                        imgNum += 1
                        pageControl.currentPage = imgNum - 1
                    }
                
                    imgView.image = UIImage(named: "banner0" + String(imgNum) + ".jpg")
                    
                
                default:
                    break
            }
        }
        
    } // ~ViewDidLoad
    
    
    
    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage]) // 페이지 컨트롤의 상세정보를 가져와서 이미지 뷰에 보여줌
    }
    
    @IBAction func Mylocation(_ sender: Any) {
        if locationAccessCheck == 0 {
            // 초기에 0회
            Mapalert()
        } else if locationAccessCheck == 1 {
            // 한번 허용
            locationAccessCheck = 0
            
        } else if locationAccessCheck == -2 {
            // 허용 안함
            NegativeAlert()
        } else if locationAccessCheck == -1 {
            // 앱을 사용하는 동안 허용
        }
    }
    
    @IBAction func idx1(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 0
    }
    
    @IBAction func idx2(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 1
    }
    
    @IBAction func idx3(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 2
    }
    
    
    @IBAction func idx4(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 3
    }
    
    
    @IBAction func idx5(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 4
    }
    
    @IBAction func idx6(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 5
    }
    
    @IBAction func idx7(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 6
    }
    
    @IBAction func idx8(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 7
    }
    
    @IBAction func idx9(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 8
    }
    
    @IBAction func idx10(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 9
    }
    
    @IBAction func idx11(_ sender: UIButton) {
        ButtonClickSegue()
        appDelegate?.buttonidx = 10
    }
    
    
    @IBAction func unwind(_ segue : UIStoryboardSegue) { // unwind 세그웨이 프로그래밍적으로 구현 - 왜냐하면 바로 이전화면이 아니라 더더 이전화면을 건너가야하는 경우도 생기니까.
        // 단지 프로필 화면으로 되돌아오기 위한 표식 역할만 할 뿐이므로 아무 내용도 작성하지 않는다
    }
}

extension MainPageView {
    // MARK:: button click method - view
    
    func ButtonClick() {
        // present 방식으로 화면 전환 - 모달 방식 사용 가능
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorListVC") as? DoctorList else {
            return
        }
        vc.accessibilityNavigationStyle = .automatic
        present(vc, animated: false, completion: nil)
    }
    
    func ButtonClickSegue() {
        // 세그 방식으로 화면 전환 - 네비게이션 형식 사용 가능
        self.performSegue(withIdentifier: "SegueId", sender: self)
    }
    
    
}

extension MainPageView {
    
    // MARK:: button click method - location
    
    func Mapalert() {
        let dialog = UIAlertController(title: "Medic이(가) 사용자의 위치를 사용하도록 허용하겠습니까?", message: "위치 서비스를 제공받기 위해 위치 정보 접근이 필요합니다.", preferredStyle: .alert)
        
        
        let OnceAction = UIAlertAction(title: "한 번 허용", style: .default) {
            (_) in
            self.locationAccessCheck = 1 // flag 1
            self.loctaionBtn.setTitle("한 번 허용 상태", for: .normal)
        }
        
        let AlwaysAction = UIAlertAction(title: "앱을 사용하는 동안 허용", style: .default) {
            (_) in
            self.locationAccessCheck = -1 // flag -1
            self.loctaionBtn.setTitle("앱을 사용하는 동안 허용 상태", for: .normal)
        }
        
        let DeniedAction = UIAlertAction(title: "허용 안함", style: .default) {
            (_) in
            self.locationAccessCheck = -2 // flag -2
            self.loctaionBtn.setTitle("허용 안함", for: .normal)
            print("bbbbbb")
            print(self.locationAccessCheck)
        }
        
        let contentVC = MapkitViewController()
        dialog.setValue(contentVC, forKey: "contentViewController") // private api
        
        dialog.addAction(OnceAction)
        dialog.addAction(AlwaysAction)
        dialog.addAction(DeniedAction)
        
        
        present(dialog, animated: true, completion: nil)
    }
    
    func NegativeAlert() {
        let dialog = UIAlertController(title: "앱 설정에서 위치 권한을 허용해주세요.", message: "위치 서비스를 제공받기 위해 위치 정보 접근이 필요합니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        let reAction = UIAlertAction(title: "재설정하기", style: .default) {
            (_) in
            self.locationAccessCheck = 0
            self.Mapalert()
        }
        dialog.addAction(okAction)
        dialog.addAction(reAction)
        present(dialog, animated: true, completion: nil)
    }
    
    
    
}
