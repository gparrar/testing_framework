#!/usr/local/bin/python
# -*- coding: utf-8 -*-


DB_SERVER = "localhost"
DATABASE = "mb_local_db"
SCHEMA_NAME = "public"
BROWSER = "Chrome"
DELAY = 0
IMAGE_COMPARATOR_COMMAND = """/usr/bin/convert __REFERENCE__ __TEST__ -metric RMSE -compare -format  "%[distortion]" info:"""

ROBOT_DIR = "/opt/mb/robot"
ssh_user = "root"
ssh_path = "/root"
page_title = "Mobility"
