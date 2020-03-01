FILE_NAME = wrapsync

$(FILE_NAME): bin/setup.sh
	bin/setup.sh

clean:
	mv $(FILE_NAME).bak $(FILE_NAME)
