# monero-binary-verifier
A basic shell script that automates and simplifies the process of verifying the hashes of a monero CLI or GUI archive.

## Purpose
Verifying the hashes of a monero wallet archive download ensures that the archive is genuine and should always be done before extracting and using the monero software in order to protect against invasions of privacy and cryptocurrency theft. However, repeating the hash verification process with each new release of the Monero software can become time consuming and burdensome.

This script automates execution of the BASH commands involved in this process and saves the user from having to manually scan the output of these commands to make sure they match the expected values by automatically comparing the values in the background. If the Signing key, Hash File, or Monero binary archive SHA256 hash does not match the expected value, the script notifies the user and instructs them to re-download the non-matching file and try again.

## Instructions:
  1. Download the script (verifyMoneroHashes.sh) and save it to the same file as the Monero binary archive to verify.
  2. Run the script, and provide the binary archive's file name as the first and only argument. For example:
  ```
  ./verifyMoneroHashes.sh monero-linux-x64-v0.17.1.1.tar.bz2
  ```
