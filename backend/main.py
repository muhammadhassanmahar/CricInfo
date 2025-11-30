from fastapi import FastAPI, WebSocket
from app.routers import matches, admin
from app.websocket_manager import manager

app = FastAPI()

app.include_router(matches.matches_router)
app.include_router(admin.admin_router)

@app.websocket("/ws/match/{match_id}")
async def match_ws(match_id: str, websocket: WebSocket):
    await manager.connect(match_id, websocket)
    try:
        while True:
            await websocket.receive_text()  # Keep connection alive
    except:
        manager.disconnect(match_id, websocket)
