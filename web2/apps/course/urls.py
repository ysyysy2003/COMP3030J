# -*- coding: utf-8 -*-
# @File  : urls.py


from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter

from .views import UserViewSet, ProductViewSet, OperationViewSet, OrderViewSet, CategoryViewSet

router = DefaultRouter()

router.register('user', UserViewSet)
router.register('product', ProductViewSet)
router.register('category', CategoryViewSet)
router.register('operation', OperationViewSet)
router.register('order', OrderViewSet)

urlpatterns = [
    url('', include(router.urls)),
]

