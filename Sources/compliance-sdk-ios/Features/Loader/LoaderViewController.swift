import UIKit


protocol LoaderViewDelegate: AnyObject {
    func onSubmit(completion: @escaping (Result<String, Error>) -> Void)
}

class LoaderViewController: UIViewController, ModalViewControllerDelegate, PopUpModalDelegate {
    private let theme = ComplianceSDK.shared.configuration.theme
    let sheetTVC = ModalViewController()
    let modalView =  PopUpModalViewController()
    
    func onAllowClicked() {
        sheetTVC.dismiss(animated: true, completion: nil)
    }
    
    func onCancelClicked() {
        navigationController?.popViewController(animated: true)
        sheetTVC.dismiss(animated: true, completion: nil)
    }
    

    
    weak var delegate: LoaderViewDelegate?
    var loaderImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.color.surfaceBackgroundPrimary
        navigationController?.setNavigationBarHidden(true, animated: false)

        loaderImageView = UIImageView()
        loaderImageView.contentMode = .scaleAspectFit
        loaderImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderImageView)

        
        NSLayoutConstraint.activate([
            loaderImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderImageView.widthAnchor.constraint(equalToConstant: 100),
            loaderImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        showLoader()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               self.handleOnSubmitClicked()
           }
        
    }
    
    func showLoader() {
      
        let jeremyGif = ComplianceSDK.shared.configuration.platformType == .send ? UIImage.gifImageWithName("send_loader") : UIImage.gifImageWithName("f4b_loader")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 150.0)
        loaderImageView.image = jeremyGif
    }
    
   
    func hideLoader() {
        loaderImageView.isHidden = true
    }
    
    @objc func handleOnSubmitClicked() {
        showLoader()
        
        delegate?.onSubmit { result in
            self.hideLoader()
            switch result {
            case .success(let response):
                if ComplianceSDK.shared.configuration.platformType == .send {
                    self.presentSuccessCustomSheet()
                } else {
                    self.presentSuccessModal()
                }
            case .failure(let error):
                if ComplianceSDK.shared.configuration.platformType == .send {
                    self.presentErrorCustomSheet(error.localizedDescription)
                } else {
                    self.presentErrorModal(error.localizedDescription)
                }
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    
    @objc func presentSuccessModal() {
        modalView.modalPresentationStyle = .overFullScreen
        modalView.modalTransitionStyle = .coverVertical
        modalView.titleText = "Verification in progress"
        modalView.bodyText = "We are working on verifying your identity, we'll let you know once we are done"
        modalView.iconName = "f4b_success_icon"
        modalView.delegate = self
    self.present(modalView, animated: true)
    }
    
    @objc func presentErrorModal(_ errorMsg: String) {
        modalView.modalPresentationStyle = .overFullScreen
        modalView.modalTransitionStyle = .coverVertical
        modalView.titleText = "Error Occured"
        modalView.bodyText = errorMsg
        modalView.iconName = "f4b_error_icon"
    self.present(modalView, animated: true)
    }
    
    private func presentSuccessCustomSheet() {
        sheetTVC.delegate = self
        sheetTVC.titleText = "Verification in progress"
        sheetTVC.bodyText = "We are working on verifying your identity, we'll let you know once we are done"
        sheetTVC.iconName = "send_success_icon"
        if let sheet = sheetTVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 24
            sheetTVC.isModalInPresentation = true
        }
        
        self.present(self.sheetTVC, animated: true, completion: nil)
    }
    
    
    @objc func presentErrorCustomSheet(_ errorMsg: String) {
        sheetTVC.delegate = self
        sheetTVC.titleText = "Error Occured"
        sheetTVC.bodyText = errorMsg
        sheetTVC.iconName = "send_error_icon"
        if let sheet = sheetTVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 24
            sheetTVC.isModalInPresentation = true
        }
        
        self.present(self.sheetTVC, animated: true, completion: nil)
    }
    
    func continueButtonTapped() {
            dismiss(animated: true, completion: nil)
        }
    
}

