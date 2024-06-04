import base64
import datetime
import json
import os
import random
import time
from openai import OpenAI

from django.conf import settings
from django.db.models import Count, Q
from django.http import JsonResponse
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import generics, status
from rest_framework.decorators import action
from rest_framework.filters import SearchFilter, OrderingFilter
from rest_framework.pagination import PageNumberPagination
from rest_framework.permissions import AllowAny
from rest_framework.viewsets import ModelViewSet

from course.serializers import UserSerializer, ProductSerializer, OperationSerializer, OrderSerializer, \
    CategorySerializer
from course.models import User, Product, Operation, Order, Category

client = OpenAI(api_key="sk-proj-RGhNSMjD3mXw7UMAdjZnT3BlbkFJtNQsTPZYeE1e6tJOwGP7")


class StandardResultsSetPagination(PageNumberPagination):
    page_query_param = 'page'
    page_size = 12
    page_size_query_param = 'page_size'
    max_page_size = 10000


class UserViewSet(ModelViewSet, generics.GenericAPIView):
    serializer_class = UserSerializer
    pagination_class = StandardResultsSetPagination
    queryset = User.objects.all()
    permission_classes = [AllowAny, ]
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_fields = ['is_superuser']
    search_fields = ['$username']
    ordering = ['id']

    @action(methods=["POST"], detail=False)
    def password(self, request, pk=None):
        instance = User.objects.get(username=request.user)
        password = request.data.get("password", "")
        instance.set_password(password)
        instance.save()
        return JsonResponse(data={'results': 'success', 'code': status.HTTP_200_OK})


class CategoryViewSet(ModelViewSet, generics.GenericAPIView):
    serializer_class = CategorySerializer
    pagination_class = StandardResultsSetPagination
    queryset = Category.objects.all()
    permission_classes = [AllowAny, ]
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_fields = []
    search_fields = ['$name']
    ordering = ['id']


class ProductViewSet(ModelViewSet, generics.GenericAPIView):
    serializer_class = ProductSerializer
    pagination_class = StandardResultsSetPagination
    queryset = Product.objects.all()
    permission_classes = [AllowAny, ]
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_fields = ['category__id', 'city', 'user__id', 'status']
    search_fields = ['$name']
    ordering = ['-id']

    @action(methods=["POST"], detail=False)
    def get_img(self, request, pk=None):
        file = request.FILES.get('file')
        path = os.getcwd()
        path2 = '/media/' + str(int(time.time())) + '.jpg'
        with open(path + '/media/' + str(int(time.time())) + '.jpg', 'wb') as f:
            for i in file.chunks():
                f.write(i)
        return JsonResponse(data={'data': path2, 'code': status.HTTP_200_OK})

    @action(methods=["GET"], detail=False)
    def get_intro(self, request, pk=None):
        product = Product.objects.filter(status=1)
        c = product.order_by('?')
        a = product.order_by('-create_time')
        b = Product.objects.annotate(comment_count=Count('operation', filter=Q(operation__type=1))).prefetch_related(
            'operation_set__filter(operation__type=1)')
        return JsonResponse(data={'data': [list(a.values()[:8]), list(b.values()[:8]), list(c.values()[:8])],
                                  'code': status.HTTP_200_OK})

    @action(methods=["POST"], detail=False)
    def get_ai(self, request, pk=None):
        content = request.data.get('content', '')
        try:
            chat_completion = client.chat.completions.create(
                messages=[
                    {"role": "user",
                     "content": content, }
                ],
                model="gpt-3.5-turbo-0125",
            )
            msg = chat_completion.choices[0].message.content
        except Exception as e:
            msg = "Openai error"
        print(content)
        print(msg)
        return JsonResponse(data={'data': msg, 'code': status.HTTP_200_OK})


class OperationViewSet(ModelViewSet, generics.GenericAPIView):
    serializer_class = OperationSerializer
    pagination_class = StandardResultsSetPagination
    queryset = Operation.objects.all()
    permission_classes = [AllowAny, ]
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_fields = ['user__id', 'product__id', 'type']


class OrderViewSet(ModelViewSet, generics.GenericAPIView):
    serializer_class = OrderSerializer
    pagination_class = StandardResultsSetPagination
    queryset = Order.objects.all()
    permission_classes = [AllowAny, ]
    filter_backends = [DjangoFilterBackend, SearchFilter, OrderingFilter]
    filterset_fields = ['user1__id', 'user2__id', 'type']
