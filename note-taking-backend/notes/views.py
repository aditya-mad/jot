from rest_framework import viewsets, status
from .models import User, Category, Note, ToDo
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializers import UserSerializer, CategorySerializer, NoteSerializer, ToDoSerializer
import pytesseract
import requests
import json
import openai

from .textextract import TextExtractor

pytesseract.pytesseract.tesseract_cmd ='C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserCategoryViewSet(APIView):
    def get(self, request, user_id, category_id=None):
        if category_id is None:
            categories = Category.objects.filter(user_id=user_id)
            serializer = CategorySerializer(categories, many=True)
            return Response(serializer.data)
        else:
            try:
                category = Category.objects.get(id=category_id, user_id=user_id)
                serializer = CategorySerializer(category)
                return Response(serializer.data)
            except Category.DoesNotExist:
                return Response(status=status.HTTP_404_NOT_FOUND)


class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class CategoryNoteViewSet(viewsets.ModelViewSet):
    serializer_class = NoteSerializer

    def get_queryset(self):
        category_id = self.kwargs.get('category_id')
        return Note.objects.filter(category_id=category_id)

    def perform_create(self, serializer):
        category_id = self.kwargs.get('category_id')
        serializer.save(category_id=category_id)

    def perform_update(self, serializer):
        category_id = self.kwargs.get('category_id')
        serializer.save(category_id=category_id)


class ExtractTextView(APIView):
    def post(self, request):
        image_url = request.data.get('image_url')
        image_url_list = image_url.split("/")
        image_url = "https://drive.google.com/uc?export=view&id=" + image_url_list[-2]
        api_key = "your_key"  # Replace with your OpenAI API key
        
        if not image_url:
            return Response({'error': 'Image URL is required'}, status=status.HTTP_400_BAD_REQUEST)
        
        text_extractor = TextExtractor(image_url, api_key)
        extracted_text = text_extractor.answer()
        
        return Response({'extracted_text': extracted_text}, status=status.HTTP_200_OK)
    
class ToDoViewSet(viewsets.ModelViewSet):
    serializer_class = ToDoSerializer

    def get_queryset(self):
        user_id = self.kwargs.get('user_id')
        return ToDo.objects.filter(user_id=user_id)

