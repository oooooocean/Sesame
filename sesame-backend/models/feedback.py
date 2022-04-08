from enum import IntEnum


class FeedbackCategory(IntEnum):
    AppFeature = 1
    AppBug = 2
    Other = 3

    def __str__(self):
        if self == FeedbackCategory.AppFeature:
            return '来点新功能'
        elif self == FeedbackCategory.AppBug:
            return '有BUG啊'
        else:
            return '纯吐槽'
