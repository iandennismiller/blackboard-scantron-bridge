# BSB: Install

The **Install Guide** walks through the installation of BSB.

### Installation

    pip install git+http://github.com/iandennismiller/blackboard-scantron-bridge

### Pre-requisites

#### Requirements

- Unix-like OS (OS X, BSD, Linux)
- Python 2.7.x
- Python pip
- Python virtualenv
- Python virtualenvwrapper
- iconv

#### Installing pre-requisites

The following instructions will update Python's libraries and then create a Python virtual environment for exams.

    pip install --upgrade pip virtualenv virtualenvwrapper
    mkvirtualenv exams

To access the virtual environment in the future, use the virtualenvwrapper `workon` command.

    workon exams

Now you have access to the following BSB commands:

- `bsb-init.sh`
- `bsb-dimensions.sh`
- `bsb-students.sh`
- `bsb-finalize.sh`

## Next steps

Now that you have installed BSB, you can read the [Setup Guide](Setup.md) to create a new project.
