#!/bin/bash

if [ -z $DEBUG ]; then 
	DEBUG=0
fi

# Figure out the directory the current script lives in. We'll use it later to determine default file paths for other stuff.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Set up defaults

target_dir="${HOME}/Archive/backups/dot-env"
base_source_dir="${HOME}/src"
verbose=0

# Process Options

function usage () {
	echo "Usage:"
	echo "  $( basename "${0}" ) [options]"
	echo 
	echo "  Options include: "
	echo "    -h             Display this help message."
	echo "    -s source_dir  Base source dir under which to search for .env files. Defaults to `${base_source_dir}`."
	echo "    -t target_dir  Place generated file in the specified directory. Defaults to `${target_dir}`."
	echo "    -v             Be verbose."
}

while getopts ":hvt:" opt; do
	case ${opt} in
		h)
			usage
			exit 0
			;;
		s)
			base_source_dir="$( cd "$OPTARG" && pwd )"
			;;
		t)
			target_dir="$( cd "$OPTARG" && pwd )"
			;;
		v)
			echo "Increasing verbosity"
			verbose=1
			;;
		\? )
			echo "Invalid Option: -$OPTARG" 1>&2
			exit 1
			;;
	esac
done
shift $((OPTIND -1))

#

if [ $verbose -gt 0 -o $DEBUG -ne 0 ]; then
	echo "What am I?: ${0}"
	echo "Verbose: ${verbose}"
	echo "DIR: ${DIR}"
	echo "Target dir:      ${target_dir}"
	echo "Base Source dir: ${base_source_dir}"
fi

echo "Backing up .env files in ${base_source_dir} ... "

## Get it done

files=`find ${base_source_dir} -name .env`

for file in $files; do
	dest_file="${file/${base_source_dir}/${target_dir}}"
	dest_dir="$( dirname "$dest_file" )"
	dest_file="${dest_dir}/env.$( date +%Y%m%d%H%M%S )"

	if [ ! -d "${dest_dir}" ]; then
		if [ $verbose -gt 0 -o $DEBUG -ne 0 ]; then
			echo "Destination directory missing. Creating ${dest_dir} ..."
		fi

		mkdir -p "${dest_dir}"
	fi

	cp -v "${file}" "${dest_file}"
done
