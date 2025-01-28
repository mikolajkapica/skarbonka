enum Route: Hashable {
    case home
    case goalForm
    case goalConfirmation(goal: GoalModel)
    case goalEnd(goal: GoalModel)
    case games
    case profile
}
