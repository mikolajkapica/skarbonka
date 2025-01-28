import SwiftUI
import Lottie
import Combine

struct Coin: Identifiable {
    let id = UUID()
    var position: CGPoint
    var isVisible = true
}

class GameState: ObservableObject {
    @Published var coins: [Coin] = []
    @Published var score = 0
    @Published var isGameOver = false
    @Published var gameStarted = false
    
    private var timer: AnyCancellable?
    private var spawnTimer: AnyCancellable?
    private let screenHeight: CGFloat
    private let bottomTabBarHeight: CGFloat
    private let screenHeightWithTabBar: CGFloat

    private var baseSpawnInterval: Double = 2.0
    private var baseFallSpeed: Double = 3.0
    private var currentSpawnInterval: Double = 2.0
    private var currentFallSpeed: Double = 3.0
    
    let coinLength: CGFloat = 200

    init(screenHeight: CGFloat) {
        self.screenHeight = screenHeight
        self.bottomTabBarHeight = 180
        self.screenHeightWithTabBar = screenHeight - bottomTabBarHeight
    }
    
    func startGame() {
        gameStarted = true
        isGameOver = false
        score = 0
        coins = []
        
        currentSpawnInterval = baseSpawnInterval
        currentFallSpeed = baseFallSpeed
        
        startSpawnTimer()
    }
    
    private func startSpawnTimer() {
        spawnTimer?.cancel()
        spawnTimer = Timer.publish(every: currentSpawnInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.createNewCoin()
                self?.increaseDifficulty()
            }
    }
    
    private func increaseDifficulty() {
        let speedMultiplier = 1.0 + (Double(score) * 0.05)
        currentFallSpeed = min(baseFallSpeed * speedMultiplier, baseFallSpeed * 3)
        
        let newSpawnInterval = max(baseSpawnInterval - (Double(score) * 0.1), 0.5)
        
        if abs(currentSpawnInterval - newSpawnInterval) > 0.1 {
            currentSpawnInterval = newSpawnInterval
            startSpawnTimer()
        }
    }
    
    func createNewCoin() {
        let padding = coinLength / 2
        let randomX = CGFloat.random(in: padding...UIScreen.main.bounds.width - padding)
        let coin = Coin(position: CGPoint(x: randomX, y: -coinLength))
        coins.append(coin)
    }
    
    func updateCoinPositions() {
        guard !isGameOver else { return }

        for (index, coin) in coins.enumerated() {
            if coin.isVisible {
                coins[index].position.y += CGFloat(currentFallSpeed)
                if coins[index].position.y > screenHeightWithTabBar {
                    isGameOver = true
                    spawnTimer?.cancel()
                    break
                }
            }
        }
    }
    
    func catchCoin(at index: Int) {
        guard coins[index].isVisible else { return }
        coins[index].isVisible = false
        score += 1
    }
}

struct LottieView: UIViewRepresentable {
    let animationView = LottieAnimationView()
    var name: String
    var coinLength: CGFloat
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: coinLength),
            animationView.heightAnchor.constraint(equalToConstant: coinLength),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct GamesView: View {
    @StateObject private var gameState: GameState    
    
    @EnvironmentObject private var style: StyleConfig

    
    init() {
        _gameState = StateObject(wrappedValue: GameState(screenHeight: UIScreen.main.bounds.height))
    }
    
    let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            style.theme.backgroundGradient.ignoresSafeArea()
            
            if !gameState.gameStarted {
                VStack {
                    Text(String(localized: "Łapacz monet"))
                        .font(.largeTitle)
                        .bold()
                    
                    Button("Start Game") {
                        gameState.startGame()
                    }
                    .buttonStyle(FilledButton())
                    .font(.title)
                }
                .foregroundColor(.white)
            } else {
                ZStack {
                    ForEach(Array(gameState.coins.enumerated()), id: \.element.id) { index, coin in
                        if coin.isVisible {
                            LottieView(name: "coin", coinLength: gameState.coinLength)
                                .frame(width: gameState.coinLength, height: gameState.coinLength)
                                .position(coin.position)
                                .onTapGesture {
                                    gameState.catchCoin(at: index)
                                }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Wynik: \(gameState.score)")
                            .foregroundStyle(.white)
                            .font(.title)
                            .padding()
                        
                        Spacer()
                    }
                    
                    if gameState.isGameOver {
                        VStack {
                            Text("Game Over!")
                                .font(.largeTitle)
                                .bold()
                            
                            Text("Final Score: \(gameState.score)")
                                .font(.title)
                            
                            Button("Play Again") {
                                gameState.startGame()
                            }
                            .buttonStyle(FilledButton())
                            .font(.title)
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                    }
                }
                .frame(maxWidth: .infinity)
                .border(.red)
                .onReceive(timer) { _ in
                    gameState.updateCoinPositions()
                }
            }
        }
        .topBarTitle("Gry")
    }
}

// MARK: - Preview Helpers
#if DEBUG
extension GameState {
    static func preview() -> GameState {
        let state = GameState(screenHeight: UIScreen.main.bounds.height)
        state.score = 5
        return state
    }
}

#Preview {
    GamesView()
        .environmentObject(StyleConfig.preview)
}
#endif
