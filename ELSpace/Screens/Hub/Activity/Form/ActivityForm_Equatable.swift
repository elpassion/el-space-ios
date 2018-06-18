extension ActivityForm: Equatable {}

func ==(lhs: ActivityForm, rhs: ActivityForm) -> Bool {
    return lhs.comment == rhs.comment &&
        lhs.date == rhs.date &&
        lhs.hours == rhs.hours &&
        lhs.projectId == rhs.projectId
}
