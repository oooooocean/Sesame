from enum import IntEnum


class Gender(IntEnum):
    MALE = 1
    FEMALE = 2

    def __str__(self):
        return '男性' if self is Gender.MALE else '女性'
