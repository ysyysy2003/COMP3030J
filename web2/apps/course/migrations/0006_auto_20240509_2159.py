# Generated by Django 2.2 on 2024-05-09 21:59

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('course', '0005_auto_20240509_0108'),
    ]

    operations = [
        # migrations.RenameField(
        #     model_name='category',
        #     old_name='svg',
        #     new_name='info',
        # ),
        migrations.RenameField(
            model_name='product',
            old_name='price',
            new_name='nums',
        ),
        migrations.AddField(
            model_name='order',
            name='nums1',
            field=models.IntegerField(default=0),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='product',
            name='user',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.DO_NOTHING, to=settings.AUTH_USER_MODEL),
            preserve_default=False,
        ),
    ]
