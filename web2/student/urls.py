"""student URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.contrib import admin
from django.conf.urls import url, include
from django.urls import path
from django.views.static import serve
from rest_framework.routers import DefaultRouter
from rest_framework_jwt.views import obtain_jwt_token

from course import urls as course_urls

router = DefaultRouter()

admin.site.site_header = "后台管理"

urlpatterns = [path('api/', include([path(r'v1/', include(course_urls)),
                                     path(r'login/', obtain_jwt_token),])),
               path('admin/', admin.site.urls),
               url(r'^media/(?P<path>.*)$', serve, {"document_root": settings.MEDIA_ROOT}),
               ]

