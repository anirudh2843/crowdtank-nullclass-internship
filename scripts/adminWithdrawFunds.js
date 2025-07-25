const contractAddr = "0x7252CdA30f60611125243f5cC4Ba5Cfd0F05d3A7";

async function main() {
  const CrowdTank = await ethers.getContractFactory("CrowdTank");
  const crowdTank = await CrowdTank.attach(contractAddr);

  const projectId = 1;

  const txn = await crowdTank.adminWithdrawFunds(projectId);
  console.log("Txn Status =>", txn.hash);
  console.log("Transaction =>", txn);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
