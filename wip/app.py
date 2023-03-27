#!/usr/bin/env python
""" app

    Tue Jul 20 21:05:22 2021

    __author__ = 'Jose Lima'

"""

from fastapi import FastAPI
from pydantic import BaseModel
from enum import Enum

# nested models
# https://fastapi.tiangolo.com/tutorial/body-nested-models/

allowed = [
    {"name": "project1"},
    {"name": "project2"},
    {"name": "project3"},
]

# origins = [
#     "http://localhost:3000",
#     "localhost:3000"
# ]

# app.add_middleware(
#     CORSMiddleware,
#     allow_origins=origins,
#     allow_credentials=True,
#     allow_methods=["*"],
#     allow_headers=["*"]
# )

# https://dev.to/ivergara/dynamic-generation-of-informative-enum-s-in-python-1b22
# In [15]: Animal = Enum('Animal', {el:el.lower() for el in 'ANT BEE CAT DOG'.split(" ")}, type=str)
#     ...: list(Animal)

# TODO: add test to check projects have names defined @12:08 08-29-21
Projects = Enum("projects", {x["name"]: x["name"] for x in allowed}, type=str)

app = FastAPI()


@app.post("/models/")
async def post_model(project_name: Projects):
    return {"project_name": project_name}


# TODO: add endpoints for displaying projects, also return src/dest inventory @12:08 08-29-21
@app.get("/models/")
async def get_model():
    return {"projects": [x["name"] for x in allowed]}
