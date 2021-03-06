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
    
    @State private var presentLoadView = false
    @State private var backgroundImage:UIImage? = UIImage()
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    DrawingImageViewWrapper(backgroundImage: $backgroundImage)
                    
                    DrawingViewWrapper(model: $model, updateUI: $updateUI)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(leading: HStack(spacing:UIModel.navigationLongPadding) {
                            HStack(spacing:UIModel.navigationShortPadding){
                                Button(action: {
                                    let rect = Util.calculateRectOfImageInImageView(frameSize: geometry.size, imgSize: backgroundImage?.size)
                                    model.saveDrawingAndwriteToPhotoAlbum(drawingSize: geometry.size, imageCGRect: rect, backgroundImage: backgroundImage)
                                }, label: {
                                    Text("SAVE")
                                })
                                Button(action: {
                                    presentLoadView = true
                                    
                                }, label: {
                                    Text("LOAD")
                                }).sheet(isPresented: $presentLoadView, content: {
                                    LoadView(isPresent: $presentLoadView, model: $model)
                                })
                                
                            }
                            Button(action: {
                                isImagePickerDisplay.toggle()
                                
                            }, label: {
                                Text("ADD")
                            })
                            
                            
                        },trailing: HStack(spacing:UIModel.navigationLongPadding) {
                            HStack(spacing:UIModel.navigationShortPadding){
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
                            HStack(spacing:UIModel.navigationShortPadding) {
                                Button(action: {
                                    withAnimation {
                                        pencilViewHidden()
                                    }
                                }, label: {
                                    Text("PEN")
                                })
                                Button(action: {
                                    backgroundImage = UIImage()
                                    model.clearDrawingView {
                                        updateUI()
                                    }
                                }, label: {
                                    Text("CLEAN")
                                })
                                
                            }
                        }).sheet(isPresented: $isImagePickerDisplay, content: {
                            ImagePickerView(model: $model, backgroundImage: $backgroundImage)
                            
                        })
                    if !pencilViewIsHidden {
                        
                        VStack(alignment: .leading) {
                            Spacer().frame(maxWidth: .infinity)
                            PencilViewWrapper(model: $model)
                                .frame(width: UIScreen.main.bounds.width,
                                       height: UIModel.pencilViewHeight,
                                       alignment: .bottom)
                                
                                .transition(.move(edge: .bottom))
                        }
                    }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    func pencilViewHidden() {
        pencilViewIsHidden.toggle()
    }
}

struct DrawingImageViewWrapper: UIViewRepresentable {
    @Binding var backgroundImage: UIImage?
    private let imageView = UIImageView()
    
    func makeUIView(context: Context) -> UIImageView {
        imageView.image = backgroundImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    func updateUIView(_ uiView: UIImageView, context: Context) {
        if uiView.image != backgroundImage {
            uiView.image = backgroundImage
        }
    }
    
    
}


struct DrawingViewWrapper : UIViewRepresentable {
    @Binding var model: DrawingModel
    @Binding var updateUI: () -> ()
    
    func makeUIView(context: Context) -> DrawingView {
        let view = DrawingView()
        
        view.model = model
        return view
    }
    func updateUIView(_ uiView: DrawingView, context: Context) {
        uiView.backgroundColor = .clear
        updateUI = { [weak uiView] in
            uiView?.myDraw()
        }
        if model.isLoadDismiss {
            model.isLoadDismiss = false
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



struct LoadView: View {
    @Binding var isPresent: Bool
    @Binding var model: DrawingModel
    private let dateFormatter = DateFormatter().myFormatter()
    var body: some View {
        List(0 ..< DrawSaveDataManager.shared.histories.count) { list in
            let data = DrawSaveDataManager.shared.histories[list]
            let date = data.saveDate!
            let entity = data.saveDrawing!
            Button(action: {
                model.loadDrawing(entity)
                isPresent = false
            }, label: {
                Text("생성일 : \(dateFormatter.string(from: date))")
            })
        }
    }
}




