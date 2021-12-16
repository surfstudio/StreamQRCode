//
//  ContentView.swift
//  StreamQRCode
//
//  Created by Ilya Cherkasov on 15.12.2021.
//

import SwiftUI

struct MainScreen: View {
    
    @State var isPhotoPickerPresented: Bool = false
    @State var sourceImage = UIImage()
    @State var isPhotoSelected: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $isPhotoSelected) {
                    
                } label: {}

                VStack {
                    Text("QR-код всегда под рукой")
                        .bold()
                    Text("Просто добавьте картинку с кодом из галереи или отсканируйте камерой")
                        .multilineTextAlignment(.center)
                }
                .frame(maxHeight: .infinity)
                HStack {
                    Button {
                        isPhotoPickerPresented = true
                    } label: {
                        Text("Выбрать из галереи")
                            .padding()
                    }
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    Button {
                        
                    } label: {
                        Text("Камера")
                            .padding()
                    }
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            }
            .sheet(isPresented: $isPhotoPickerPresented) {
                
            } content: {
                //в настройках приложения разрешить доступ к камера
                PhotoPicker(sourceImage: $sourceImage, sourceType: .photoLibrary) {
                    isPhotoSelected = true
                }
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
