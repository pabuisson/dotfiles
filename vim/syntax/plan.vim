syntax keyword Directory Goal Milestone Target Task 
syntax match Directory "Category of Goal"
syntax match Special "^  [1-4]-[:a-zA-Z]*"
syntax match Special "[A-Z][a-z]\+ [0-9]\+ [A-Z][a-z]\+$"
syntax match Special "\*\+"
syntax match NonText "^#"
syntax match NonText "^##"
syntax match NonText "^## [A-Za-z ]\+"
syntax match NonText "^###"

