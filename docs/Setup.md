# BSB: Setup

The **Setup Guide** walks through the creation of a new exam grading project.  It assumes you have already [installed the system](Install.md).

### Initialize a project.

First, be sure you are in the Python virtual environment (if you used this option)

    workon exams

Then, issue `bsb-init.sh` to create a project folder called `marking`.

    bsb-init.sh

There is now a folder called `marking` that is used for grading your exam.

## Next steps

Now that you have a grading project, you can read the [Usage Guide](Usage.md) to grade an exam.
