# Foundry + nodemon + docker-compose boilerplate

Small boilerplate repository for developing on Foundry.

It will compile and test your contracts under `src` on save. Happy coding!

## Usage

### docker-compose

Can be used via docker-compose:

`docker-compose up`

You can set environment variables and flags with an `.env` file

```
FOUNDRY_FLAGS="--fork-url https://eth-mainnet.alchemyapi.io/v2/QfzWQxGrh8ORZGyXbpg0I8hsVDnT_yTq"
```

### nodemon

If you have nodemon already installed as a global:

`nodemon <--args>`

## Maintenance notes

To reenable deleted git submodules, use this example:

`git submodule add --force https://github.com/foundry-rs/forge-std lib/forge-std`

This will redownload and link github submodules
