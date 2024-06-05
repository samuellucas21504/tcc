from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()


class OpenAiRepository:
    def __init__(self):
        self.client = OpenAI()

    def __del__(self):
        self.client.close()

    def test_message(self):
        model = os.getenv("OPENAI_MODEL")

        completion = self.client.chat.completions.create(
            messages=[
                {"role": "system",
                 "content": "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."},
                {"role": "user", "content": "Compose a poem that explains the concept of recursion in programming."}
            ],
            model=model,
            temperature=0.7,
            stream=False
        )

        return completion.choices[0].message.content
