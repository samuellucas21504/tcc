from fastapi import APIRouter
from routes import messages

api_router = APIRouter()

api_router.include_router(messages.router, prefix="/messages", tags=["messages"])