FROM ubuntu
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install -y ethereum wget git vim
RUN wget https://www.rinkeby.io/rinkeby.json
RUN geth --datadir=$HOME/.rinkeby init rinkeby.json
# RUN wget https://dl.dropboxusercontent.com/u/4270001/testnet_genesis.json
# RUN mv testnet_genesis.json ropsten.json
# RUN geth --datadir=$HOME/.ropsten init ropsten.json

EXPOSE 8545
EXPOSE 8546
EXPOSE 30303
EXPOSE 30303/udp

# To run a rinkeby full node and open web socket:
# CMD geth --networkid=4 --datadir=$HOME/.rinkeby --cache=1024 --rpc --rpcapi="db,eth,net,web3,personal,miner,txpool" --rpcaddr "127.0.0.1" --rpcport 8545 

CMD geth --rinkeby --syncmode "fast" --rpc --rpcapi="db,eth,net,web3,personal,miner,txpool" --cache=1024 --rpcaddr "127.0.0.1" --rpccorsdomain "*" --datadir=$PWD/.rinkeby --ws --wsaddr "127.0.0.1" --wsorigins "*"
