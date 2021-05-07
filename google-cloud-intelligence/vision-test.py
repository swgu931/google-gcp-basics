import io
import os

# Imports the Google Cloud client library
from google.cloud import vision

# Instantiates a client
client = vision.ImageAnnotatorClient()

# The name of the image file to annotate
file_name = os.path.abspath('/shared/google-images-download/images/face/4.290255-Jessica_Alba-face.jpg')
content = io.open(file_name, 'rb').read()
image = vision.Image(content=content)
response = client.face_detection(image=image)
faces = response.face_annotations
print(faces)
#for face in faces:
#  print(face)
