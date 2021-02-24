from glob import glob
import argparse
import chevron
import datetime
import humanize
import os
import sys


def get_size(path):
    return humanize.naturalsize(os.path.getsize(path))


def get_files(directory):
    filenames = glob(directory + "/*.stl")
    filenames.extend(glob(directory + "/*.zip"))

    return map(
        lambda filename: {
            "filename": os.path.relpath(filename, directory),
            "size": get_size(filename),
        },
        sorted(filenames),
    )


def get_html(directory, commit):
    today = datetime.date.today()
    values = {
        "files": get_files(directory),
        "last_updated": today.strftime("%B %d, %Y"),
        "commit": commit,
    }

    return chevron.render(template, values)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    # TODO: explain
    parser.add_argument("--directory", type=str, required=True)
    parser.add_argument("--commit", type=str, required=True)
    arguments = parser.parse_args()

    dir_path = os.path.dirname(os.path.realpath(__file__))

    if not os.path.isdir(arguments.directory):
        sys.exit("ERROR: " + arguments.directory + " directory does not exist")

    with open(dir_path + "/template.mustache", "r") as template:
        output = open(arguments.directory + "/index.html", "w")
        output.write(get_html(directory=arguments.directory, commit=arguments.commit))
        output.close()
