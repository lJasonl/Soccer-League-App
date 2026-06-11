from fastapi import FastAPI

app = FastAPI(
    title="Soccer League API",
    version="1.0.0"
)

@app.get("/")
def root():
    return {"message": "Soccer League API Running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}
