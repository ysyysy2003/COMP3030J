from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    type = models.IntegerField(default=1, blank=True, null=True)  # 3 商家 1 管理员
    status = models.IntegerField(default=1, blank=True, null=True)  # 1 正常  3 禁用
    image = models.CharField(max_length=255, default='', blank=True, null=True)  # 图片
    company = models.CharField(max_length=255, default='', blank=True, null=True)    # 公司
    email = models.CharField(max_length=255, default='', blank=True, null=True)    # 邮箱
    about = models.CharField(max_length=255, default='', blank=True, null=True)    # 关于


class Category(models.Model):
    name = models.CharField(max_length=255)  # 名称
    info = models.CharField(max_length=255)  # 简介


class Product(models.Model):
    name = models.CharField(max_length=255)    # 名称
    category = models.ForeignKey(Category, on_delete=models.DO_NOTHING)
    user = models.ForeignKey(User, on_delete=models.DO_NOTHING)
    status = models.IntegerField(default=3, blank=True, null=True)  #  1 同意  2 拒绝 3  审核中
    status_info = models.CharField(max_length=255, default='', blank=True, null=True)  # 审核意见
    nums = models.FloatField(default=0, blank=True, null=True)  # 数量
    description = models.TextField(default='', blank=True, null=True)   # 详情
    image = models.CharField(max_length=255, default='', blank=True, null=True)  # 图片
    condition = models.CharField(max_length=255, default='', blank=True, null=True)    # 几成新
    tag = models.CharField(max_length=255, default='', blank=True, null=True)    # 标签
    address = models.CharField(max_length=255, default='', blank=True, null=True)  # 地址
    city = models.CharField(max_length=255, default='', blank=True, null=True)  # 城市
    state = models.CharField(max_length=255, default='', blank=True, null=True)  # 街道
    phone = models.CharField(max_length=255, default='', blank=True, null=True)  # 手机
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)


class Operation(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    type = models.IntegerField()  # 类型  2 评论 1 点赞
    info = models.CharField(max_length=255, default='', blank=True, null=True)   # 内容
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)


class Order(models.Model):
    user1 = models.ForeignKey(User, on_delete=models.CASCADE, related_name="user1")
    user2 = models.ForeignKey(User, on_delete=models.CASCADE, related_name="user2")
    product1 = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="product1")
    product2 = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="product2")
    nums2 = models.IntegerField()   # 数量
    type = models.IntegerField()   # 类型  1 同意  2 拒绝 3  等待
    note = models.TextField(default='', blank=True, null=True)  # 备注
    address = models.CharField(max_length=255, default='', blank=True, null=True)  # 地址
    phone = models.CharField(max_length=255, default='', blank=True, null=True)  # 手机
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)


