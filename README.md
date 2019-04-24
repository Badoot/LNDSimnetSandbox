# LND Simnet Sandbox

  Lightning Network Daemon Simnet Sandbox

  BTCD + 4 LND instances launched.

# Setup

  1. git clone https://github.com/Badoot/lnd_simnet_sandbox
  2. docker build lnd_simnet_sandbox/. -t lnd_simnet_sandbox
  3. docker run -ti lnd_simnet_sandbox

# Steps for getting started:

1. Generate (mine) at least 1 block:
      
        btcctl generate 1

2. At least one wallet is needed for subsequent block rewards:
  
        lncli-alice create
    Note: Wait a few seconds for RPC services to switch over from wallet to node before moving to step 3.

3. Create an on-chain address to receive block rewards:

        lncli-alice newaddress np2wkh
    Note: If you get an RPC error, you probably didn't wait long enough... try #3 again.

4. Stop btcd:

        btcctl stop

5. Start btcd with the new mining address that you just created:
        
        /gocode/bin/btcd --simnet --rpcuser=testuser --rpcpass=testpass  --txindex --miningaddr=ADDRESS_FROM_STEP_3 > /dev/null &"

6. Generate plenty of blocks so that the reward is spendable:

        btcctl generate 200

7. Now Alice has plenty to start opening channels and sending funds.
          
        lncli-alice walletbalance

8. You can go back to step #4 and generate mining rewards for the other nodes, or start connecting to peers and opening channels.
    
    Note:  Type 'ps -ef |grep lnd' to get each node's 'listen=ip:port' used for 'lncli connect'.

# Pre-set Aliases
  Manage btcd:

    btcctl = btcctl --rpcuser=testuser --rpcpass=testpass --simnet

  Alice's node:

    lncli-alice = lncli --rpcserver=localhost:10001 --no-macaroons --tlscertpath=/gocode/dev/alice/data/tls.cert

  Bob's node

    lncli-bob = lncli --rpcserver=localhost:10002 --no-macaroons --tlscertpath=/gocode/dev/bob/data/tls.cert

  Charlie's node

    lncli-charlie = lncli --rpcserver=localhost:10003 --no-macaroons --tlscertpath=/gocode/dev/charlie/data/tls.cert

  Danny's node

    lncli-danny = lncli --rpcserver=localhost:10004 --no-macaroons --tlscertpath=/gocode/dev/danny/data/tls.cert

