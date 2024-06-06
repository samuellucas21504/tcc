from typing import Optional

from pydantic import BaseModel


class HabitDTO(BaseModel):
    reason: str
    motivation: Optional[str]

