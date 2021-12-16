//
//  PhotoPicker.swift
//  StreamQRCode
//
//  Created by Ilya Cherkasov on 15.12.2021.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var sourceImage: UIImage
    var sourceType: UIImagePickerController.SourceType
    var completion: (() -> Void)?
    
    typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(picker: self)
    }

}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let photoPicker: PhotoPicker
    
    init(picker: PhotoPicker) {
        self.photoPicker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            photoPicker.sourceImage = image
        }
        picker.dismiss(animated: true) { [weak self] in
            self?.photoPicker.completion?()
        }
    }
    
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
