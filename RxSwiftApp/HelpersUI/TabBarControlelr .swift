import UIKit

final class MainTabBarController : UITabBarController {
    
    private let middleButtonDiameter: CGFloat = 42

    private lazy var globalImage: UIImageView = {
        let globalImage = UIImageView()
        globalImage.image = UIImage(named: "Group")
        globalImage.tintColor = .white
        globalImage.contentMode = .scaleAspectFit
        globalImage.translatesAutoresizingMaskIntoConstraints = false
        return globalImage
    }()

    private lazy var middleButton: UIButton = {
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = middleButtonDiameter / 2
        middleButton.backgroundColor = UIColor(red: 14/255.0,
                                               green: 15/255.0,
                                               blue: 13/255.0,
                                               alpha: 1.0)
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        return middleButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
}

extension MainTabBarController {
    
    private func makeUI() {
        
        tabBar.addSubview(middleButton)
        middleButton.addSubview(globalImage)

        NSLayoutConstraint.activate([
            middleButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            globalImage.heightAnchor.constraint(equalToConstant: 32),
            globalImage.widthAnchor.constraint(equalToConstant: 32),
            globalImage.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
            globalImage.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        ])
    }
}
