# MacOS X VMware image creation

## Base image install

Obtain installation image:

- Download MacOS X 10.13 installer `Install macOS High Sierra` from
  the Apple app store, or use a previously downloaded image.

## Base machine creation

In VMware Fusion:

- File→New then drag and drop the installer from the Finder to the
  "Install from disc or image" part of the "Select the Installation
  Method" window.

- Select `macOS 10.12` under "Choose Operating System" (or the correct
  version with a newer version of VMware)

- Choose `Customize Settings` under "Finish"

- Save As `ansible-macos-10.13-base` (wait while disc image is created)

- 2 processor cores
- 2 GiB RAM
- Network is Bridged Networking (`Autodetect`)
- Disc is 200GB (sparse, not pre-allocated)
- Disable features:
  - No 3D graphics
  - No CD
  - No sound
  - No USB
  - No Bluetooth
  - No drag+drop
  - No copy+paste

## Base machine installation

In VMware Fusion:

- Start the virtual machine (the installer will automatically run)
- Language: `English`
- `Install macOS` (follow through prompts until installer runs and
  completes)
- After automatic restart:
  - Location: United Kingdom
  - Keyboard: British
  - Don't transfer information
  - Don't sign in with Apple ID
- Create user account:
  - Full name: CI Admin
  - Account name: ci-admin
  - Password: [see ci/all.gpg in credentials.git]
  - Hint: See ci/all.gpg in credentials.git
- Final configuration:
  - Don't enable location services
  - Time zone GMT/Edinburgh
  - Don't share analytics with Apple
  - Don't share crash data
- Check for and install any software updates
- Shut down machine
- Snapshot for future reference

# Create machine for deployment

In VMware Fusion:

- Clone the base machine (use full clone for better performance but
  increased disc usage)
- Adjust CPU count, memory and disc as needed
- Boot system

Log in as the ci-admin user, and perform the following actions:

- Set the hostname
- Set static IP address, DNS, search domains
- Enable SSH for all users

Perform all remaining setup steps with ansible.
