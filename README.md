# NFT Studio Playground

This quick how-to explains how to install a local testing environment, hereafter called the `Playground`, for the Centrifuge
Chain. The latter relies on the Parity [`Polkadot-Launch`](https://github.com/paritytech/polkadot-launch) tool for bootstraping the `Playground` components (i.e. relay chain and parachain nodes)

Configurations for the `Playground` are located in the [`configs`](./configs) folder (see ")

Concretely, a relay chain is installed (see "Building Polkadot Relay Chain")
on which the Centrifuge Parachain (called Altair) will be onboarded (see "Building Centrifuge Parachain"), the latter providing the [`Uniques`](https://github.com/paritytech/substrate/tree/master/frame/uniques) pallet (a kind of plugin, in the Polkadot jargon) that will be used for minting, transfering or creating NFTs. The NFT Studio will invoke this pallet's business logic using transactions, that are called [`extrinsics`](), in the [Polkadot Substrate](https://github.com/paritytech/substrate) terminology. The [Polkadot Substrate](https://github.com/paritytech/substrate) is the Rust framework used for building the Centrifuge Chain on top of Polkadot.

## 1. Getting Started

First, you should clone this playground's repository in a folder on your host:

```bash
git clone git@github.com:tankofzion/nft-studio-playground.git
```

In the following scripts, the `ROOT_DIR` placeholder refers to this `nft-studio-playground` folder where the playground's code
was cloned.

Now you can install all necessary tools by simply running the following command:

```bash
make setup
```

This command will clone Polkadot relay chain and the Centrifuge parachain repositories in the [`source`](./source) folder.

## 2. Installing `Polkadot-Launch` Tool

The [`Polkadot-Launch`](https://github.com/paritytech/polkadot-launch) tool helps bootstraping a complete Polkadot environment including
a relay chain and the [collator nodes](https://wiki.polkadot.network/docs/learn-collator) of a parachain.

As said in [Polkadot documentation](https://wiki.polkadot.network/docs/learn-collator), the role of collator nodes is to collect parachain transactions from users and produce state transition proofs for the relay chain validator nodes.

Install the `Polkadot-Launch` tool globally on your host as follows, using `yarn`:

```bash
yarn global add polkadot-launch
```
or if you prefer `npm`, as follows:

```bash
npm i polkadot-launch -g
```
## 2. Building Binaries

Bulding binaries for [Polkadot v0.9.11](https://github.com/paritytech/polkadot/releases/tag/v0.9.11) relay chain and [Centrifuge](https://github.com/centrifuge/centrifuge-chain) parachain is as simple as executing the following command:

```bash
make build
```

You can also run `make build-relaychain` or `make build-parachain` command in order to build
a specific executable.

## 3. Configuring the `Playground`

A [basic configuration](./configs/basic-config.json) for the `Playground` is provided, that should be a good starting point.

Please refer to [`README.md`](https://github.com/paritytech/polkadot-launch#configuration-file) the `Polkadot-Launch` tool for more information on the configuration file's options.

## 4. Starting the `Playground`

Using the provided [Makefile](./Makefile), the `Playground` can be launched by means of the following simple command (recommended):

```bash
make start
```

You can also spin up the `Playground` using the `Polkadot-Launch` tool directly, as shown below:

```bash
polkadot-launch ./configs/basic-config.json
```

... that's it folks!

## 5. Cleaning Up the `Playground`

As simple as running the `make clean` command.