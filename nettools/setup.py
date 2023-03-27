"""Minimal setup file for tasks project."""

# pip install ./nettools
from setuptools import setup, find_packages

setup(
    name="netttols",
    version="0.1.0",
    license="UNLICENSED",
    description="tools to assist in network automation",
    author="Jose Lima",
    author_email="0x90shell@gmail.com",
    url="",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    install_requires=[""],
    # extras_require={"mongo": "pymongo"},
    # entry_points={"console_scripts": ["tasks = tasks.cli:tasks_cli",]},
)
