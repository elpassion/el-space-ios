extension NewActivityDTO {

    static func create(with form: ActivityForm, type: ReportType) -> NewActivityDTO {
        return NewActivityDTO(projectId: form.projectId,
                              value: form.hours,
                              performedAt: form.date,
                              comment: form.comment,
                              reportType: type.rawValue)
    }

}
