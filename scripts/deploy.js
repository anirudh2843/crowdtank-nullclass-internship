const hre = require("hardhat");

async function main() {
  const CrowdTank = await hre.ethers.getContractFactory("CrowdTank");

  const crowdTank = await CrowdTank.deploy();

  await crowdTank.waitForDeployment(); // wait for the deployment to finish

  console.log("CrowdTank deployed to:", crowdTank.target); // use .target for contract address
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
