//
//  ContentView.swift
//  DrawingAppSwiftUI
//
//  Created by brian은석 on 2021/05/30.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    @State private var model = DrawingModel()
    @State private var updateUI = {}
    @State private var pencilViewIsHidden = false
    @State private var isImagePickerDisplay = false
    @State private var selectedImage: UIImage?


    var rect:CGRect = .zero
    let imageSaver = ImageSaver()
    
    var body: some View {
        NavigationView {
            CanvasViewWrapper(model: $model, updateUI: $updateUI)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: HStack(spacing:20) {
                    HStack(spacing:5){
                        Button(action: {
                            saveImage()
                        }, label: {
                            Text("SAVE")
                        })
                        Button(action: {
                            
                        }, label: {
                            Text("LOAD")
                        })
                        
                    }
                    Button(action: {
                        isImagePickerDisplay.toggle()
                        
                    }, label: {
                        Text("ADD")
                    })
                },trailing: HStack(spacing:20) {
                    HStack(spacing:5){
                        Button(action: {
                            model.undoDrawing {
                                updateUI()
                            }
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        Button(action: {
                            model.redoDrawing {
                                updateUI()
                            }
                        }){
                            Image(systemName: "arrow.right")
                        }
                        
                    }
                    HStack(spacing:5) {
                        Button(action: {
                            withAnimation {
                                pencilViewHidden()
                            }
                            
                        }, label: {
                            Text("PEN")
                        })
                        Button(action: {
                            model.clearDrawingView {
                                updateUI()
                            }
                        }, label: {
                            Text("CLEAN")
                        })
                        
                    }
                }).sheet(isPresented: $isImagePickerDisplay, content: {
                    ImagePickerView(model: $model, sourceType: .photoLibrary)

                })
        }
        if pencilViewIsHidden {
            PencilViewWrapper(model: $model)
                .frame(width: UIScreen.main.bounds.width, height: 160, alignment: .bottom)
                .transition(.move(edge: .bottom))
        }
            
    }
    
    func saveImage() {
        let image = model.saveDrawing(UIScreen.main.bounds) ?? UIImage()
        imageSaver.writeToPhotoAlbum(image: image)
    }
    
    func pencilViewHidden() {
        pencilViewIsHidden.toggle()
    }
    
}


struct CanvasViewWrapper : UIViewRepresentable {
    @Binding var model: DrawingModel
    @Binding var updateUI: () -> ()
    
    func makeUIView(context: Context) -> DrawingView {
        let view = DrawingView()
        view.model = model
        return view
    }
    func updateUIView(_ uiView: DrawingView, context: Context) {
        uiView.backgroundColor = .white
        updateUI = {
            uiView.myDraw()
        }
    }
}

struct PencilViewWrapper: UIViewRepresentable {
    @Binding var model: DrawingModel
    func makeUIView(context: Context) -> PencilView {
        let view = PencilView()
        view.model = model
        return view
    }
    func updateUIView(_ uiView: PencilView, context: Context) {

    }
}



