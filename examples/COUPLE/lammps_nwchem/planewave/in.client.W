# small W unit cell for use with NWChem

variable        mode index file
 
if "${mode} == file" then &
  "message client md file tmp.couple" &
elif "${mode} == zmq" &
  "message client md zmq localhost:5555" &
# Note: General Web (localhost:80), Secure HTTPS (localhost:443), Develop. XAMPP (localhost:8888), Develop. Web (localhost:5555)

variable	x index 1
variable	y index 1
variable	z index 1

units           metal
atom_style      charge
atom_modify     sort 0 0.0 map yes

read_data       data.W

mass            1 183.85

replicate       $x $y $z

velocity        all create 300.0 87287 loop geom

neighbor        0.3 bin
neigh_modify	delay 0 every 10 check no

fix             1 all nve
fix             2 all client/md
fix_modify      2 energy yes

dump            d1 all cfg 1 cfg/run.*.cfg mass type xs ys zs id type q
dump_modify     d1 element W

thermo          1
run             10

