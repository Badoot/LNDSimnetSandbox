#!/bin/sh
# Setup your LND test environment

mining_address=riZiZx3YM8YD24PJKwNwMS7ytXf7DoxGeu

# Start btcd
echo
echo "Starting btcd..."
mkdir -p /root/.btcd
touch /root/.btcd/btcd.conf
/gocode/bin/btcd --simnet --rpcuser=testuser --rpcpass=testpass --debuglevel=info --txindex \
--miningaddr=$mining_address  > /dev/null &
echo " Manage btcd with btcctl. See 'btcctl -l' for a list of commands."
echo " Mine x blocks:  btcctl generate x"

# Start lnd for each simulated node
echo
echo "Starting lnd nodes..."
echo " Alice : lncli-alice"
/gocode/bin/lnd --alias=Alice \
  --rpclisten=localhost:10001 --restlisten=localhost:8001 --listen=localhost:10011 --datadir=/gocode/dev/alice/data \
  --logdir=/gocode/dev/alice/logs --debuglevel=info --bitcoin.simnet --bitcoin.active --bitcoin.node=btcd \
  --tlscertpath=/gocode/dev/alice/data/tls.cert --tlskeypath=/gocode/dev/alice/data/tls.key --no-macaroons \
  --btcd.rpcuser=testuser --btcd.rpcpass=testpass --btcd.rpchost=127.0.0.1:18556 > /dev/null &
echo " Bob : lncli-bob"
/gocode/bin/lnd --alias=Bob \
  --rpclisten=localhost:10002 --restlisten=localhost:8002 --listen=localhost:10012 --datadir=/gocode/dev/bob/data \
  --logdir=/gocode/dev/bob/logs --debuglevel=info --bitcoin.simnet --bitcoin.active --bitcoin.node=btcd \
  --tlscertpath=/gocode/dev/bob/data/tls.cert --tlskeypath=/gocode/dev/bob/data/tls.key --no-macaroons \
  --btcd.rpcuser=testuser --btcd.rpcpass=testpass --btcd.rpchost=127.0.0.1:18556 > /dev/null &
echo " Charlie : lncli-charlie"
/gocode/bin/lnd --alias=Charlie \
  --rpclisten=localhost:10003 --restlisten=localhost:8003 --listen=localhost:10013 --datadir=/gocode/dev/charlie/data \
  --logdir=/gocode/dev/charlie/logs --debuglevel=info --bitcoin.simnet --bitcoin.active --bitcoin.node=btcd \
  --tlscertpath=/gocode/dev/charlie/data/tls.cert --tlskeypath=/gocode/dev/charlie/data/tls.key --no-macaroons \
  --btcd.rpcuser=testuser --btcd.rpcpass=testpass --btcd.rpchost=127.0.0.1:18556> /dev/null &
echo " Danny : lncli-danny"
/gocode/bin/lnd --alias=Danny \
  --rpclisten=localhost:10004 --restlisten=localhost:8004 --listen=localhost:10014 --datadir=/gocode/dev/danny/data \
  --logdir=/gocode/dev/danny/logs --debuglevel=info --bitcoin.simnet --bitcoin.active --bitcoin.node=btcd \
  --tlscertpath=/gocode/dev/danny/data/tls.cert --tlskeypath=/gocode/dev/danny/data/tls.key --no-macaroons \
  --btcd.rpcuser=testuser --btcd.rpcpass=testpass --btcd.rpchost=127.0.0.1:18556 > /dev/null &

echo
echo "LND Simnet Sandbox ready!"
echo
echo "Steps for getting started:"
echo
echo " 1. Generate a block so that alice can sync to a chain with at least 1 block:"
echo "      # btcctl generate 1"
echo " 2. Need at least one wallet up to mine subsequent blocks to:"
echo "      # lncli-alice create"
echo " 3. Create an on-chain address to receive block generation rewards:"
echo "      # lncli-alice newaddress np2wkh"
echo " 4. Stop btcd"
echo "      # btcctl stop"
echo " 5. Start btcd with the new mining address you just created:"
echo "      # /gocode/bin/btcd --simnet --rpcuser=testuser --rpcpass=testpass \
--txindex --miningaddr=ADDRESS_FROM_STEP_3 > /dev/null &"
echo " 6. Generate enough blocks that the reward is spendable:"
echo "      # btcctl generate 200"
echo
