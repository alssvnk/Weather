
class Utilities {
    /** Get actual weather state */
    static func checkForState(with state: String) -> WeatherState {
        var currentState = WeatherState.another
        
        WeatherState.allCases.forEach {
            guard state.lowercased().contains($0.rawValue.lowercased()) else { return }
            currentState = $0
        }
        
        return currentState
    }
}
