from fastapi import APIRouter, Body
from services.messages_service import MessagesService
from dtos.habit_dto import HabitDTO

router = APIRouter()
service = MessagesService()


@router.post("/")
async def root(motivation_request: HabitDTO):
    return service.generate_motivation_message(motivation_request)