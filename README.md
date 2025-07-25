# 🚀 CrowdTank - Blockchain-based Crowdfunding Platform

> 🎓 Internship Task for Nullclass - Blockchain Internship  
> 🧑‍💻 Developed by: Domakonda Anirudh (CMR College of Engineering and Technology)  
> 🗓️ Submitted on: [Insert Date]

---

## 📌 Table of Contents
- [Overview](#overview)
- [Smart Contract Features](#smart-contract-features)
- [Commission Logic](#commission-logic)
- [Technologies Used](#technologies-used)
- [Folder Structure](#folder-structure)
- [Deployment Info](#deployment-info)
- [Testing the Project](#testing-the-project)
- [How to Run](#how-to-run)
- [Report](#report)
- [Contact](#contact)

---

## 🧩 Overview

CrowdTank is a decentralized crowdfunding platform built using **Solidity** and **Hardhat**.  
It allows users to:
- Create crowdfunding projects
- Fund them with ETH
- Withdraw funds based on conditions
- Admin to earn 5% commission per project

---

## 🔐 Smart Contract Features

- ✅ **Create Projects**: With unique ID, deadline, funding goal
- ✅ **Fund Projects**: With automatic 5% commission deduction
- ✅ **Refunds**: Users can withdraw funds if project fails
- ✅ **Creator Withdrawals**: After deadline if fully funded
- ✅ **Admin Withdrawals**: For accumulated commissions

---

## 💸 Commission Logic

- A **5% commission** is charged from each contribution
- If contribution > funding goal, excess amount + commission is refunded
- Commission is stored per project and withdrawable by the system admin

---

## 🧰 Technologies Used

| Tech | Description |
|------|-------------|
| Solidity | Smart contract development |
| Hardhat | Ethereum dev environment |
| Alchemy | Sepolia testnet endpoint |
| Ethers.js | JavaScript library to interact with contracts |
| dotenv | Securely manage API keys |

---
## 🌐 Deployment Info

- **Network**: Sepolia Testnet  
- **Contract Address**: `0x7252CdA30f60611125243f5cC4Ba5Cfd0F05d3A7`  
- **Deployed via**: Hardhat

---

## 🧪 Testing the Project

You can interact with the contract using these scripts:

# Fund a project
node scripts/fundProject.js

# Creator withdraws funds (after funding goal met)
node scripts/adminWithdraw.js

# User withdraws funds (if project failed)
node scripts/userWithdraw.js
Make sure to set your .env file with:

env
Copy
Edit
SEPOLIA_RPC=your_sepolia_rpc_url
PRIVATE_KEY=your_private_key
ETHERSCAN_API_KEY=your_etherscan_api_key
🖥️ How to Run
bash
Copy
Edit
# Clone the repo
git clone https://github.com/YOUR_USERNAME/nullclass-blockchain-internship

# Navigate into project
cd nullclass-blockchain-internship

# Install dependencies
npm install

# Compile contracts
npx hardhat compile

# Run deployment
npx hardhat run scripts/deploy.js --network sepolia


# Clone the repo
git clone https://github.com/YOUR_USERNAME/nullclass-blockchain-internship

# Navigate into project
cd nullclass-blockchain-internship

# Install dependencies
npm install

# Compile contracts
npx hardhat compile

# Run deployment
npx hardhat run scripts/deploy.js --network sepolia
