from fastapi import APIRouter
from ..database import db

matches_router = APIRouter()

@matches_router.get("/matches")
async def get_matches():
    matches = await db.matches.find().to_list(100)
    return matches

@matches_router.get("/matches/{match_id}/score")
async def get_score(match_id: str):
    match = await db.matches.find_one({"match_id": match_id})
    if match and "score" in match:
        return match["score"]
    return {"runs": 0, "wickets": 0, "overs": 0.0}
