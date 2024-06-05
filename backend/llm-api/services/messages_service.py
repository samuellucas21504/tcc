from repositories.open_ai_repository import OpenAiRepository


class MessagesService:
    def __init__(self):
        self.repository = OpenAiRepository()

    def test(self):
        return  self.repository.test_message()
