from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

from .views import ExtractTextView, GenerateQuestionsView


router = DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'categories', views.CategoryViewSet)
router.register(r'notes', views.CategoryNoteViewSet, basename='category-notes')
router.register(r'todo', views.ToDoViewSet, basename='todo')

urlpatterns = [
    path('', include(router.urls)),
    path('extract-text/', ExtractTextView.as_view(), name='extract-text'),
    path('users/<str:user_id>/categories/', views.UserCategoryViewSet.as_view(), name='user-categories'),
    path('users/<str:user_id>/categories/<int:category_id>/', views.UserCategoryViewSet.as_view(), name='user-category-detail'),
    path('users/<str:user_id>/categories/<int:category_id>/notes/', views.CategoryNoteViewSet.as_view({'get': 'list', 'post': 'create'}), name='category-notes-list'),
    path('users/<str:user_id>/categories/<int:category_id>/notes/<int:pk>/', views.CategoryNoteViewSet.as_view({'get': 'retrieve', 'put': 'update', 'patch': 'partial_update', 'delete': 'destroy'}), name='category-note-detail'),
    path('users/<str:user_id>/todo/', views.ToDoViewSet.as_view({'get': 'list', 'post': 'create'}), name='user-todo-list'),
    path('users/<str:user_id>/todo/<int:pk>/', views.ToDoViewSet.as_view({'get': 'retrieve', 'put': 'update', 'patch': 'partial_update', 'delete': 'destroy'}), name='user-todo-detail'),
    path('users/<str:user_id>/categories/<int:category_id>/generate-questions/', GenerateQuestionsView.as_view()),
]
