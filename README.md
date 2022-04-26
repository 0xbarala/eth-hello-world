# eth-hello-world
Solidity hello world contract

# Covers basic learning points
* Used `foundry` to create the project
* HelloWorld solidity contract
* Getting familiar with basic symantics i.e `array` `map` `modifier` `function`
* Checks around access controls i.e `Owener can add Admins`, `Admins can add messagge`
* Events emitting
* Various tests using `foundry`

# RPC network addresses for different chains
* https://rpc.info/

# Deploy smart contract code on Rinkeby test network
```
forge create --rpc-url https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161 \
> --constructor-args <address of smart contract owner> \
> --private-key <your private key> src/HelloWorld.sol:HelloWorld
```

# Deployed smart contract code link
* https://rinkeby.etherscan.io/address/0xaf19e9d5d02696e0f51f13c88e18d69f7d1ebe23