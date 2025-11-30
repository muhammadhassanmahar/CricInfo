from pydantic import BaseModel

class EventModel(BaseModel):
    event_type: str  # e.g., "WICKET", "SIX"
    over: float
    batsman: str
    bowler: str
