from fastapi import APIRouter
from ..database import db
from ..websocket_manager import manager

admin_router = APIRouter(prefix="/admin")

@admin_router.post("/match/{match_id}/update_score")
async def update_score(match_id: str, score: dict):
    await db.matches.update_one({"match_id": match_id}, {"$set": {"score": score}})
    await manager.broadcast(match_id, {"score": score})
    return {"status": "success"}

@admin_router.post("/match/{match_id}/event")
async def add_event(match_id: str, event: dict):
    await db.matches.update_one(
        {"match_id": match_id}, {"$push": {"events": event}}
    )
    await manager.broadcast(match_id, {"event": event})
    return {"status": "success"}
