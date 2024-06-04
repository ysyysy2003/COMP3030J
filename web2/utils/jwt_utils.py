# -*- coding: utf-8 -*-

import warnings
import uuid

from datetime import datetime
from django.db import models
from rest_framework_jwt.utils import jwt_payload_handler
from django.contrib.auth import get_user_model
from django.conf import settings
from django.contrib.auth.models import AbstractBaseUser
from rest_framework_jwt.authentication import JSONWebTokenAuthentication


def get_username_field():
    try:
        username_field = get_user_model().USERNAME_FIELD
    except:
        username_field = 'username'

    return username_field


def get_username(user):
    try:
        username = user.get_username()
    except AttributeError:
        username = user.username

    return username


def jwt_payload_handler(user):
    username_field = get_username_field()
    username = get_username(user)

    warnings.warn(
        'The following fields will be removed in the future: '
        '`email` and `user_id`. ',
        DeprecationWarning
    )

    payload = {
        'id': user.pk,
        'username': username,
        'exp': datetime.utcnow() + settings.JWT_AUTH['JWT_EXPIRATION_DELTA']
    }
    if isinstance(user.pk, uuid.UUID):
        payload['id'] = str(user.pk)

    payload['role'] = user.role.name
    # 存储多个 team id
    teams = user.team.values("id")
    payload['team'] = ",".join([str(team.get("id")) for team in teams])
    payload['nickname'] = user.nickname
    payload['avatar_url'] = user.avatar_url

    payload[username_field] = username

    return payload


def jwt_response_payload_handler(token, user=None, request=None):
    """
    自定义jwt认证成功返回数据
    :token  返回的jwt
    :user   当前登录的用户信息[对象]
    :request 当前本次客户端提交过来的数据
    """
    return {
        'token': token,
        'id': user.id,
        'status': user.status,
        'username': user.username,
        'company': user.company,
        'image': user.image,
        'about': user.about,
        'is_superuser': user.is_superuser,
        'type': user.type
    }

