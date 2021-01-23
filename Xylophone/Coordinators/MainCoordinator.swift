import UIKit

class MainCoordinator: Coordinator {
    
    func start() {
        mainMenu()
    }
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController.navigationBar.shadowImage = UIImage()
        self.navigationController.navigationBar.isTranslucent = true
    }
    
    private func showNavBar(){
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    private func hideNavBar(){
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func mainMenu(){
        hideNavBar()
        let vc = MenuViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func gameOptions(){
        showNavBar()
        let vc = GameOptionsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func gameOver(gameMode: Int, keyGenerationStrategy: KeyGenerationStrategy, score: Int64, finishedText: String){
        hideNavBar()
        let vc = GameOverViewController.instantiate()
        vc.gameFinishedText = finishedText
        vc.gameMode = gameMode
        vc.keyGenerationStrategy = keyGenerationStrategy
        vc.score = Int64(score)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func highScores(){
        showNavBar()
        let vc = HighScoreViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func shop(){
        showNavBar()
        let vc = ShopViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func playGame(gameMode: Int, keyGenerationStrategy: KeyGenerationStrategy){
        hideNavBar()
        if gameMode == GameMode.FREE_PLAY.rawValue {
            showNavBar()
        }
        let vc = GameViewController.instantiate()
        vc.coordinator = self
        vc.gameMode = gameMode
        vc.keyGenerationStrategy = keyGenerationStrategy
        navigationController.pushViewController(vc, animated: true)
    }
    
    func enterHighScoreName(gameMode: Int, keyGenerationStrategy: KeyGenerationStrategy, score: Int64, finishedText: String){
        hideNavBar()
        let vc = EnterHighScoreViewController.instantiate()
        vc.finishedText = finishedText
        vc.score = score
        vc.keyGenerationStrategy = keyGenerationStrategy
        vc.gameMode = gameMode
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
