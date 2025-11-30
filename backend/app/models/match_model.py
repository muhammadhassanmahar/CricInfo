from pydantic import BaseModel
from typing import List, Optional

class MatchModel(BaseModel):
    match_id: str
    team1: str
    team2: str
    status: str = "upcoming"
    score: Optional[dict] = None  # Example: {"runs": 100, "wickets": 2, "overs": 12.3}
