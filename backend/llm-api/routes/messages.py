from fastapi import APIRouter, HTTPException
from services.messages_service import MessagesService

router = APIRouter()
service = MessagesService()


@router.get("/")
async def root():
    return {"message": "Hello World"}


@router.get("/hello/{name}")
def say_hello(name: str):
    test = service.test()
    return {test}
