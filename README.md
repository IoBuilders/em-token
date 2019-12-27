# E-Money token project

An e-money, bank and central bank money issued token based on [ERC-20](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md). With additional functionalities such as holds, clearance and detailed compliance.

This project is the first implementation of electronic money on a Blockchain. The learnings that were made during its creation were used to propose [ERC-2020 - The E-Money Token Standard](https://emoneytokenstandard.org/). Currently there are differences between the interfaces used here and the proposed standard. The interfaces of the standard will be adapted in a future release.

## Installation

The contracts and the corresponding build files can be downloaded with:

```
npm install emoney-token
```

## Interacting with the token

The abstract contract [EmoneyToken](contracts/EmoneyToken.sol) can be used to interact with the token. It consists of the following interfaces:

### ERC-20

Please refer to the [ERC-20 Token Standard](https://eips.ethereum.org/EIPS/eip-20) for the exact specification.

### Hold

An extension to the ERC-20 standard token that allows tokens to be put on hold. This guarantees a future transfer and makes the held tokens unavailable for transfer in the mean time. Holds are similar to escrows in that are firm and lead to final settlement.

Please refer to [IHoldable.sol](contracts/IHoldable.sol) for the exact specification.

#### balanceOf

The standard implementation of ERC-20 has been changed in order to deduct the held balance from the ERC-20 balance.

#### transfer

The standard implementation of ERC-20 has been changed in order to deduct the held balance from the ERC-20 balance. Any amount that is held can not be transferred.

#### transferFrom

The standard implementation of ERC-20 has been changed in order to deduct the held balance from the ERC-20 balance. Any amount that is held can not be transferred.

### Two Step Transfer (Clearable Transfer)

> "In banking and finance, clearing denotes all activities from the time a commitment is made for a transaction until it is settled." [[1]][Clearing-Wikipedia] 

Please refer to [ITwoStepTransferableToken.sol](contracts/ITwoStepTransferableToken.sol) for the exact specification.

[1] https://en.wikipedia.org/wiki/Clearing_(finance)

[Clearing-Wikipedia]: https://en.wikipedia.org/wiki/Clearing_(finance)

### Compiling

To compile the interfaces and the abstract contract, please execute:
```sh
npm install
npm run compile
```
