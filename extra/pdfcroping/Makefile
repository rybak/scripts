PC=./pdfcrop.sh
PCM=$(PC) -m "10 0 10 0" 

1-4m.pdf : part1-4.pdf
	$(PC) part1-4.pdf 1-4c.pdf
	$(PCM) 1-4c.pdf 1-4m.pdf

5-7m.pdf : part5-7.pdf
	$(PC) part5-7.pdf 5-7c.pdf
	$(PCM) 5-7c.pdf 5-7m.pdf

8-10m.pdf : part8-10.pdf
	$(PC) part8-10.pdf 8-10c.pdf
	$(PCM) 8-10c.pdf 8-10m.pdf
