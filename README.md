# Decentralized Voting Smart Contract

This smart contract implements a simple, secure, and transparent voting system using the Vyper smart contract language for the Ethereum blockchain. It allows voters to cast their vote to one of several predefined candidates (or party lists) and view results at any time after the election has concluded.

## Features

- Owner-controlled voting lifecycle (`open_vote`, `close_vote`)
- Up to 10 candidates supported
- One vote per address (enforced)
- Publicly viewable election results
- Predefined default candidates included
