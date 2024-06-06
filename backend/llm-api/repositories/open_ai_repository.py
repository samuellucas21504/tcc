from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()


class OpenAiRepository:
    def __init__(self):
        self.client = OpenAI()

    def __del__(self):
        self.client.close()

    def generate_motivation_message(self, mensagem_usuario):
        model = os.getenv("OPENAI_MODEL")

        completion = self.client.chat.completions.create(
            messages=[
                {"role": "system",
                 "content": "Você a partir de agora um robô que tem como objetivo gerar mensagens para manter uma "
                            "pessoa motivada a partir de um tema. Imagine que a pessoa não consiga atualmente fazer o "
                            "que está descrito no tema e o objetivo é o tema. Gere uma frase de no máximo 240 "
                            "caracteres e 20 tokens, que seja coerente. Além disso traga fatos científicos sobre os "
                            "benefícios e que não soe ridícula ou desnecessariamente motivadora."},
                {"role": "user", "content": mensagem_usuario}
            ],
            model=model,
            temperature=0.7,
            stream=False
        )

        return completion.choices[0].message.content
