from django.urls import path, include
from rest_framework.routers import DefaultRouter 
from .views import HelloApiView, HelloViewSet, UserProfileViewSet, UserLoginApiView, UserProfileFeedViewSet

router = DefaultRouter()
router.register('hello-viewset', HelloViewSet, basename='hello-viewset')
router.register('profile', UserProfileViewSet)
router.register('feed', UserProfileFeedViewSet)

urlpatterns = [
    path('hello-api-view/', HelloApiView.as_view(), name='hello-api'),
    path('login/', UserLoginApiView.as_view()),
    path('', include(router.urls))
]