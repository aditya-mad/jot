import cv2
import requests
import numpy as np
import pytesseract
from PIL import Image
from io import BytesIO

class TextExtractor():
    def __init__(self, image_url, api_key):
        self.image_url = image_url
        self.api_key = api_key
        self.auth_token = "Bearer " + self.api_key
        self.generatedOp1 = self.extractUsingBytesIO()
        self.generatedOp2 = self.extarctUsingCv2()
        self.getEndPoint = 'https://api.openai.com/v1/chat/completions'

    
    def extractUsingBytesIO(self):
        response = requests.get(self.image_url)
        image = Image.open(BytesIO(response.content))
        
        return pytesseract.image_to_string(image)


    def extarctUsingCv2(self):
        response = requests.get(self.image_url)
        
        image_array = np.frombuffer(response.content, dtype=np.uint8)
        image = cv2.imdecode(image_array, cv2.IMREAD_COLOR)
        
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        gray = cv2.resize(gray, None, fx=2, fy=2)

        return  pytesseract.image_to_string(gray)


    def fineTuneText(self):
        
        prompt = self.generatedOp1 + "\n\nThis is the text output of first model\n\n" + self.generatedOp2 + "\n\nThis is the ouput of second model" + "These are the two texts generated from two different handwritten recognition models. Please attempt to correct any errors and provide the final corrected text. Provide only the final fair text and nothing else."
        headers = {
            'Authorization': self.auth_token,  
            'Content-Type': 'application/json'
        }

        payload = {
            'model': 'gpt-3.5-turbo',
            'messages': [
                {"role": "system", "content": "These are the two texts generated from two different handwritten models. Please attempt to correct any errors or combine if necessary and provide the final corrected text."},
                {"role": "user", "content": prompt}
            ]
        }

        response = requests.post(self.getEndPoint, headers=headers, json=payload)
        response_json = response.json()
        generated_content = response_json['choices'][0]['message']['content']
        return generated_content


    def getExtractedText(self):
        return self.fineTuneText()
    
    def answer(self):
        pytesseract.pytesseract.tesseract_cmd ='C:\\Program Files\\Tesseract-OCR\\tesseract.exe'
        api_key = self.api_key
        textExtractor = TextExtractor(self.image_url, api_key)
        return textExtractor.getExtractedText()