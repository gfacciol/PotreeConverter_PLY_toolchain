### compilation


all: plytool_ potree

potree: 
	cd PotreeConverter && make 

plytool_:
	cd plytool; make ply2binary ply2ascii

clean:
	cd PotreeConverter && make clean
	cd plytool && make clean

