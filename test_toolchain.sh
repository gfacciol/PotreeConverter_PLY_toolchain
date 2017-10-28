
cloud=testdata/cloud.ply
aply=`mktemp`.ply
blas=`mktemp`.las

# make a text ply
if head $cloud | grep "format binary" ; then 
   echo "converting binary ply to ascii"
   ./plytool/ply2ascii < $cloud  > $aply
   cloud=$aply
fi

# conert ply to las because PotreeConverter is not able to read PLY
# (ATTENTION to the -parse field s means skip)
#./PotreeConverter/LAStools/bin/txt2las -parse xyzsssRGBs -verbose  -i  $cloud -o $blas 2>/dev/null
./PotreeConverter/LAStools/bin/txt2las -parse xyzRGB -verbose -i  $cloud -o $blas 2>/dev/null

# convert to potree
export LC_ALL=C
./PotreeConverter/build/PotreeConverter/PotreeConverter $blas -o testdata -p testPotree --edl-enabled --material ELEVATION --overwrite

# clean
rm $aply $blas

# launch a simple webserver
#python -m SimpleHTTPServer &

