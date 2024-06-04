# -*- coding: utf-8 -*-

from rest_framework.pagination import (
    PageNumberPagination as _PageNumberPagination,
    LimitOffsetPagination
)
from collections import OrderedDict
from rest_framework.response import Response


class PageNumberPagination(_PageNumberPagination):
    page_size_query_param = 'page_size'
    page_size = 12
    max_page_size = 10000

    def get_paginated_response(self, data):
        code = 200
        msg = 'success'

        return Response(OrderedDict([
            ('code', code),
            ('msg', msg),
            ('pageSize', self.get_page_size(self.request)),
            ('count', self.page.paginator.count),
            ('data', data),
        ]))
