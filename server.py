from flask import Flask, send_file

app = Flask(__name__)

# Chemin vers l'image représentant le "stream"
#IMAGE_PATH = "path/to/your/stream.jpg"  
IMAGE_PATH = "streams/stream.jpg"  

@app.route("/stream")
def stream():
    return send_file(IMAGE_PATH, mimetype='image/jpeg')

@app.route("/")
def home():
    return "Welcome to the streaming app! Visit /stream to see the stream."

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)