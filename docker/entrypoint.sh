#!/bin/sh

world=${MT_WORLD}
root_dir=/var/lib/luanti
conf_file=$root_dir/worlds/${world}/minetest.conf
log_file=$root_dir/worlds/${world}/current.txt
world_dir=$root_dir/worlds/${world}

#-------------------------------------------------------------------------------
# Start the server
#-------------------------------------------------------------------------------
/usr/local/bin/luantiserver \
    --world $world_dir \
    --port 30000 \
    --config $conf_file \
    --logfile $log_file \
    --gameid minetest
#-------------------------------------------------------------------------------