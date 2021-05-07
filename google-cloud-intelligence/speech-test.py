import io
from google.cloud import speech
#from google.cloud.speech import enums, types

client = speech.SpeechClient()

#audio_file = io.open("output.mp3", 'rb')
audio_file = io.open("sample.wav", 'rb')

content = audio_file.read()

audio = speech.RecognitionAudio(content=content)

'''
config = speech.RecognitionConfig(
        encoding = speech.RecognitionConfig.AudioEncoding.LINEAR16,
        sample_rate_hertz=16000,
        language_code='en_US')
'''
config = speech.RecognitionConfig(
        encoding = speech.RecognitionConfig.AudioEncoding.LINEAR16,
        sample_rate_hertz=22050,
        language_code='ko_KR')

print(type(config), "\n", type(audio))
response = client.recognize(config=config, audio=audio)
print("---\n", response,"\n----")
for result in response.results:
    print("Transcript: {}".format(result.alternatives[0].transcript))
