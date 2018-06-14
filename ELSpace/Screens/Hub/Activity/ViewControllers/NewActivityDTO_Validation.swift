extension NewActivityDTO {

    var isValid: Bool {
        switch reportType {
        case 0: return projectId != nil && value != nil && comment != nil
        case 1: return projectId == nil && value != nil && comment == nil
        case 2, 3, 4: return projectId == nil && value == nil && comment == nil
        default: return false
        }
    }

}
