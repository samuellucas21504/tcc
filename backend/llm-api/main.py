from fastapi import FastAPI
from fastapi.routing import APIRoute
from routes.router import api_router


def custom_generate_unique_id(route: APIRoute) -> str:
    return f"{route.tags[0]}-{route.name}"


app = FastAPI(
    title="LLM - API",
    generate_unique_id_function=custom_generate_unique_id,
)

app.include_router(api_router)
