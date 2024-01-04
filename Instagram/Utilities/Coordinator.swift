
import Foundation
import SwiftUI

enum Page: String, Identifiable{
    case NONE, addEmailView, createUsernameView, createPasswordView, completeSignUpView
    
    var id: String{
        return self.rawValue
    }
}

enum Sheet: String, Identifiable{
    case NONE
    var id: String{
        return self.rawValue
    }
}

enum FullScreenCover: String, Identifiable{
    case PREMIUM
    
    var id: String{
        return self.rawValue
    }
}

class Coordinator: ObservableObject{
    static var shared = Coordinator()
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(_ page: Page){
        path.append(page)
    }
    
    func present(_ sheet: Sheet){
        self.fullScreenCover = nil
        self.sheet = sheet
    }
    
    func present(_ fullScreenCover: FullScreenCover){
        self.sheet = nil
        self.fullScreenCover = fullScreenCover
    }
    
    func pop(){
        path.removeLast()
    }
    
    func popToRoot(){
        path.removeLast(path.count)
    }
    
    func dismissSheet(){
        self.sheet = nil
    }
    
    func dissmissFullscreenCover(){
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: Page) -> some View{
        switch page{
        case .addEmailView:
            AddEmailView()
                .environmentObject(Coordinator.shared)
                .environmentObject(EnvironmentContainer.shared.registrationViewModel)
                .navigationBarBackButtonHidden()
        case .createUsernameView:
            CreateUsernameView()
                .environmentObject(Coordinator.shared)
                .environmentObject(EnvironmentContainer.shared.registrationViewModel)
                .navigationBarBackButtonHidden()
        case .createPasswordView:
            CreatePasswordView()
                .environmentObject(Coordinator.shared)
                .environmentObject(EnvironmentContainer.shared.registrationViewModel)
                .navigationBarBackButtonHidden()
        case .completeSignUpView:
            CompleteSignUpView()
                .environmentObject(Coordinator.shared)
                .environmentObject(EnvironmentContainer.shared.registrationViewModel)
                .navigationBarBackButtonHidden()
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheet, isRemoveBackground: Bool = false ,dentents: Set<PresentationDetent> = [.large]) -> some View{
        switch sheet{
        default:
            EmptyView()
                .background(isRemoveBackground ? RemoveBackground() : .init())
                .presentationDetents(dentents)
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View{
        switch fullScreenCover{
            
        default:
            EmptyView()
        }
    }
}

struct RemoveBackground: UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .clear
        }
    }
}
