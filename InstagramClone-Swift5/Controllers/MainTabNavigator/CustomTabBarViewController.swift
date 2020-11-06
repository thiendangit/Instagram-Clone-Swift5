//
//  CustomTabBarViewController.swift
//  design_to_code13
//
//  Created by Dheeraj Kumar Sharma on 14/08/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import YPImagePicker
import AVFoundation
import AVKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var homeViewController:UIViewController!
    var exploreViewController:UIViewController!
    var addViewController:UIViewController!
    var activityViewController:UIViewController!
    var profileViewController:UIViewController!
    
    var tabItem = UITabBarItem()
    var selectedItems = [YPMediaItem]()

    let selectedImageV = UIImageView()
    let pickButton = UIButton()
    let resultsButton = UIButton()

    @objc
    func showResults() {
        if selectedItems.count > 0 {
            let gallery = YPSelectionsGalleryVC(items: selectedItems) { g, _ in
                g.dismiss(animated: true, completion: nil)
            }
            let navC = UINavigationController(rootViewController: gallery)
            self.present(navC, animated: true, completion: nil)
        } else {
            print("No items selected yet.")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController = UINavigationController(rootViewController: vc1)
        
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "ExploreViewController") as! ExploreViewController
        exploreViewController = UINavigationController(rootViewController: vc2)
        
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        addViewController = UINavigationController(rootViewController: vc3)
        
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        activityViewController = UINavigationController(rootViewController: vc4)
        
        let vc5 = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController = UINavigationController(rootViewController: vc5)
        
        viewControllers = [homeViewController , exploreViewController , addViewController , activityViewController, profileViewController]
        
        setUpViews()
        
        customTab(selectedImage: "home-selected", deselectedImage: "home", indexOfTab: 0 , tabTitle: "")
        customTab(selectedImage: "search-selected", deselectedImage: "search", indexOfTab: 1 , tabTitle: "")
        customTab(selectedImage: "add-selected", deselectedImage: "add", indexOfTab: 2 , tabTitle: "")
        customTab(selectedImage: "activity-selected", deselectedImage: "activity", indexOfTab: 3 , tabTitle: "")
        customTab(selectedImage: "user-selected", deselectedImage: "user", indexOfTab: 4 , tabTitle: "")
        
        self.view.backgroundColor = .white
             showPicker()
             selectedImageV.contentMode = .scaleAspectFit
             selectedImageV.frame = CGRect(x: 0,
                                           y: 0,
                                           width: UIScreen.main.bounds.width,
                                           height: UIScreen.main.bounds.height * 0.45)
             view.addSubview(selectedImageV)
    }
    
    func setUpViews(){
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = .white
        self.tabBar.layer.cornerRadius = 40
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func customTab(selectedImage image1 : String , deselectedImage image2: String , indexOfTab index: Int , tabTitle title: String ){
        
        let selectedImage = UIImage(named: image1)!.withRenderingMode(.alwaysOriginal)
        let deselectedImage = UIImage(named: image2)!.withRenderingMode(.alwaysOriginal)
        
        tabItem = self.tabBar.items![index]
        tabItem.image = deselectedImage
        tabItem.selectedImage = selectedImage
        tabItem.title = .none
        tabItem.imageInsets.bottom = -20
    }
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("tabBar \(tabBar)")
        print("item \(item)")
        print("Selected item")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
                print("Selected view controller")
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        if selectedIndex == 2 {
            print("2")
            showPicker()
            return false
        } else {
            //do whatever
             print("other")
        }
        return true
    }
    
     @objc func showPicker() {

            var config = YPImagePickerConfiguration()

            /* Uncomment and play around with the configuration 👨‍🔬 🚀 */

            /* Set this to true if you want to force the  library output to be a squared image. Defaults to false */
    //         config.library.onlySquare = true

            /* Set this to true if you want to force the camera output to be a squared image. Defaults to true */
            // config.onlySquareImagesFromCamera = false

            /* Ex: cappedTo:1024 will make sure images from the library or the camera will be
               resized to fit in a 1024x1024 box. Defaults to original image size. */
            // config.targetImageSize = .cappedTo(size: 1024)

            /* Choose what media types are available in the library. Defaults to `.photo` */
            config.library.mediaType = .photoAndVideo
            config.library.itemOverlayType = .grid
            /* Enables selecting the front camera by default, useful for avatars. Defaults to false */
            // config.usesFrontCamera = true

            /* Adds a Filter step in the photo taking process. Defaults to true */
            // config.showsFilters = false

            /* Manage filters by yourself */
    //        config.filters = [YPFilter(name: "Mono", coreImageFilterName: "CIPhotoEffectMono"),
    //                          YPFilter(name: "Normal", coreImageFilterName: "")]
    //        config.filters.remove(at: 1)
    //        config.filters.insert(YPFilter(name: "Blur", coreImageFilterName: "CIBoxBlur"), at: 1)

            /* Enables you to opt out from saving new (or old but filtered) images to the
               user's photo library. Defaults to true. */
            config.shouldSaveNewPicturesToAlbum = false

            /* Choose the videoCompression. Defaults to AVAssetExportPresetHighestQuality */
            config.video.compression = AVAssetExportPresetMediumQuality

            /* Defines the name of the album when saving pictures in the user's photo library.
               In general that would be your App name. Defaults to "DefaultYPImagePickerAlbumName" */
            // config.albumName = "ThisIsMyAlbum"

            /* Defines which screen is shown at launch. Video mode will only work if `showsVideo = true`.
               Default value is `.photo` */
            config.startOnScreen = .library

            /* Defines which screens are shown at launch, and their order.
               Default value is `[.library, .photo]` */
            config.screens = [.library, .photo, .video]

            /* Can forbid the items with very big height with this property */
    //        config.library.minWidthForItem = UIScreen.main.bounds.width * 0.8

            /* Defines the time limit for recording videos.
               Default is 30 seconds. */
            // config.video.recordingTimeLimit = 5.0

            /* Defines the time limit for videos from the library.
               Defaults to 60 seconds. */
            config.video.libraryTimeLimit = 500.0

            /* Adds a Crop step in the photo taking process, after filters. Defaults to .none */
            config.showsCrop = .rectangle(ratio: (16/9))

            /* Defines the overlay view for the camera. Defaults to UIView(). */
            // let overlayView = UIView()
            // overlayView.backgroundColor = .red
            // overlayView.alpha = 0.3
            // config.overlayView = overlayView

            /* Customize wordings */
            config.wordings.libraryTitle = "Gallery"

            /* Defines if the status bar should be hidden when showing the picker. Default is true */
            config.hidesStatusBar = false

            /* Defines if the bottom bar should be hidden when showing the picker. Default is false */
            config.hidesBottomBar = false
            
            config.hidesCancelButton = false

            config.maxCameraZoomFactor = 2.0

            config.library.maxNumberOfItems = 5
            config.gallery.hidesRemoveButton = false

            /* Disable scroll to change between mode */
            // config.isScrollToChangeModesEnabled = false
    //        config.library.minNumberOfItems = 2

            /* Skip selection gallery after multiple selections */
            // config.library.skipSelectionsGallery = true

            /* Here we use a per picker configuration. Configuration is always shared.
               That means than when you create one picker with configuration, than you can create other picker with just
               let picker = YPImagePicker() and the configuration will be the same as the first picker. */

            /* Only show library pictures from the last 3 days */
            //let threDaysTimeInterval: TimeInterval = 3 * 60 * 60 * 24
            //let fromDate = Date().addingTimeInterval(-threDaysTimeInterval)
            //let toDate = Date()
            //let options = PHFetchOptions()
            // options.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", fromDate as CVarArg, toDate as CVarArg)
            //
            ////Just a way to set order
            //let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
            //options.sortDescriptors = [sortDescriptor]
            //
            //config.library.options = options

            config.library.preselectedItems = selectedItems


            // Customise fonts
    //        config.fonts.menuItemFont = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
    //        config.fonts.pickerTitleFont = UIFont.systemFont(ofSize: 22.0, weight: .black)
    //        config.fonts.rightBarButtonFont = UIFont.systemFont(ofSize: 22.0, weight: .bold)
    //        config.fonts.navigationBarTitleFont = UIFont.systemFont(ofSize: 22.0, weight: .heavy)
    //        config.fonts.leftBarButtonFont = UIFont.systemFont(ofSize: 22.0, weight: .heavy)

            let picker = YPImagePicker(configuration: config)

            picker.imagePickerDelegate = self

            /* Change configuration directly */
            // YPImagePickerConfiguration.shared.wordings.libraryTitle = "Gallery2"

            /* Multiple media implementation */
            picker.didFinishPicking { [unowned picker] items, cancelled in

                if cancelled {
                    print("Picker was canceled")
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                _ = items.map { print("🧀 \($0)") }

                self.selectedItems = items
                if let firstItem = items.first {
                    switch firstItem {
                    case .photo(let photo):
                        self.selectedImageV.image = photo.image
                        picker.dismiss(animated: true, completion: nil)
                    case .video(let video):
                        self.selectedImageV.image = video.thumbnail

                        let assetURL = video.url
                        let playerVC = AVPlayerViewController()
                        let player = AVPlayer(playerItem: AVPlayerItem(url:assetURL))
                        playerVC.player = player

                        picker.dismiss(animated: true, completion: { [weak self] in
                            self?.present(playerVC, animated: true, completion: nil)
                            print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
                        })
                    }
                }
            }

            /* Single Photo implementation. */
             picker.didFinishPicking { [unowned picker] items, _ in
                 self.selectedItems = items
                 self.selectedImageV.image = items.singlePhoto?.image
                 picker.dismiss(animated: true, completion: nil)
             }

            /* Single Video implementation. */
            //picker.didFinishPicking { [unowned picker] items, cancelled in
            //    if cancelled { picker.dismiss(animated: true, completion: nil); return }
            //
            //    self.selectedItems = items
            //    self.selectedImageV.image = items.singleVideo?.thumbnail
            //
            //    let assetURL = items.singleVideo!.url
            //    let playerVC = AVPlayerViewController()
            //    let player = AVPlayer(playerItem: AVPlayerItem(url:assetURL))
            //    playerVC.player = player
            //
            //    picker.dismiss(animated: true, completion: { [weak self] in
            //        self?.present(playerVC, animated: true, completion: nil)
            //        print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
            //    })
            //}

            present(picker, animated: false, completion: nil)
        }
}

extension CustomTabBarViewController {
    /* Gives a resolution for the video by URL */
    func resolutionForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
}

// YPImagePickerDelegate
extension CustomTabBarViewController: YPImagePickerDelegate {
    func noPhotos() {}

    func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {
        return true// indexPath.row != 2
    }
}

