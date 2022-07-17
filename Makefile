-include .env
export

install :; forge install foundry-rs/forge-std && forge install dapphub/ds-test

test :; forge test

update :; forge update

deploy-rinkeby :; @forge script scripts/deploy.s.sol:Deploy --rpc-url ${RINKEBY_RPC_URL}  --private-key ${PRIVATE_KEY} --broadcast --verify --etherscan-api-key ${ETHERSCAN_KEY}  -vvv

dry-deploy-rinkeby :; @forge script scripts/deploy.s.sol:Deploy --rpc-url ${RINKEBY_RPC_URL}  --private-key ${PRIVATE_KEY}  -vvv
