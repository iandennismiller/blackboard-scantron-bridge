# -*- coding: utf-8 -*-
# TDot (c) Ian Dennis Miller

from setuptools import setup

version = '0.1'

setup(version=version,
    name='blackboard-scantron-bridge',
    description="BSB makes it easy to transfer Scantron scores into a Blackboard grades database.",
    packages=[
        "bsb",
    ],
    scripts=[
        "bin/bsb-init.sh",
        "bin/bsb-dimensions.sh",
        "bin/bsb-students.sh",
        "bin/bsb-finalize.sh",
    ],
    long_description="BSB makes it easy to transfer Scantron scores into a Blackboard grades database.",
    classifiers=[],  # Get strings from http://pypi.python.org/pypi?%3Aaction=list_classifiers
    include_package_data=True,
    keywords='',
    author='Ian Dennis Miller',
    author_email='ian@iandennismiller.com',
    url='http://github.com/iandennismiller/blackboard-scantron-bridge',
    dependency_links=[
    ],
    install_requires=[
        "mr.bob==0.1a7",
    ],
    license='MIT',
    zip_safe=False,
)
