import argparse
import chevron
import datetime
from glob import glob
import humanize
import os


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


def get_html(directory):
    today = datetime.date.today()
    values = {
        "last_updated": today.strftime("%B %d, %Y"),
        "files": get_files(directory),
    }

    return chevron.render(template, values)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--directory", type=str, required=True)
    arguments = parser.parse_args()

    dir_path = os.path.dirname(os.path.realpath(__file__))

    with open(dir_path + "/template.mustache", "r") as template:
        output = open(arguments.directory + "/index.html", "w")
        output.write(get_html(arguments.directory))
        output.close()
