from repositories.open_ai_repository import OpenAiRepository
from dtos.habit_dto import HabitDTO


class MessagesService:
    def __init__(self):
        self.repository = OpenAiRepository()

    def generate_motivation_message(self, message: HabitDTO) -> HabitDTO:
        motivation = self.repository.generate_motivation_message(message.reason)
        message.motivation = motivation

        return message
