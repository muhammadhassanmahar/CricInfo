from fastapi import FastAPI, WebSocket
from fastapi.middleware.cors import CORSMiddleware
from app.routers import matches, admin
from app.websocket_manager import manager

app = FastAPI()

# ✅ CORS middleware (allow frontend requests)
origins = [
    "http://localhost:54670",  # your Flutter web origin
    "http://127.0.0.1:54670",
    "http://localhost:8000",
    "http://127.0.0.1:8000",
    "*"  # optional: allow all origins during development
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ✅ Include API routers
app.include_router(matches.matches_router)
app.include_router(admin.admin_router)

# ✅ WebSocket endpoint for live match updates
@app.websocket("/ws/match/{match_id}")
async def match_ws(match_id: str, websocket: WebSocket):
    await manager.connect(match_id, websocket)
    try:
        while True:
            await websocket.receive_text()  # Keep connection alive
    except:
        manager.disconnect(match_id, websocket)
