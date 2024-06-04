# -*- coding: utf-8 -*-
# @File  : serializers.py
from rest_framework.serializers import ModelSerializer

from course.models import User, Product, Operation, Order, Category


class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

    def create(self, validated_data):
        user = super(UserSerializer, self).create(validated_data)
        user.set_password(validated_data['password'])
        user.save()
        return user


class ProductSerializer(ModelSerializer):

    class Meta:
        model = Product
        fields = '__all__'

    def to_representation(self, instance):
        data = super(ProductSerializer, self).to_representation(instance)
        data['c'] = Category.objects.get(id=data['category']).name
        return data

    # def to_representation(self, instance):
    #     data = super(ArtGallerySerializer, self).to_representation(instance)
    #     if data['type'] == 2:
    #         data['art_all'] = [i.id for i in ArtGalleryForeign.objects.filter(gallery=data['id'])]
    #     return data


class CategorySerializer(ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'


class OperationSerializer(ModelSerializer):

    class Meta:
        model = Operation
        fields = '__all__'

    def to_representation(self, instance):
        data = super(OperationSerializer, self).to_representation(instance)
        data['user'] = User.objects.filter(id=data['user']).values()[0]
        data['product'] = Product.objects.filter(id=data['product']).values()[0]
        return data


class OrderSerializer(ModelSerializer):

    class Meta:
        model = Order
        fields = '__all__'

    def to_representation(self, instance):
        status  = {

        }
        data = super(OrderSerializer, self).to_representation(instance)
        data['user1'] = User.objects.filter(id=data['user1']).values()[0]
        data['user2'] = User.objects.filter(id=data['user2']).values()[0]
        data['product1'] = Product.objects.filter(id=data['product1']).values()[0]
        data['product2'] = Product.objects.filter(id=data['product2']).values()[0]
        # data['href'] = Href.objects.filter(id=data['href']).values()[0]
        return data
