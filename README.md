# Hack The Box zsh function
If you've interacted with the Hack The Box platform, you may find yourself accumulating a number of `ovpn` files. It can be slightly annoying to work with these and track which IP address belongs to which tunnel if you are utilizing more than one address. Additionally, if you work across platforms each platform (lab, academy, ctf) may have it's own `ovpn` file.

Copy the contents of `zsh-function` into your `~/.zshrc` and run `source ~/.zshrc`

### Using this function
You call the function with the syntax `htb [type] [name]`. The script checks the folder `~/.ovpn` for a matching file named `[type]_[name].ovpn`. This allows the function a lot of flexibility. Additionally, the script will create and track tunnel addresses with the file `~/.ovpn/tunnel_adapters.txt`. 

## Examples

### manage-htb.sh
You can use this simple script to add your ovpn files to the `~/.ovpn/` directory and name them appropriatly. It also adds the function to `~/.zshrc` for you and allows an overwrite in the case that I update the code. Makes it easier for you.

```sh
❯ ./manage-htb.sh
Enter the type of ovpn file (lab, academy, ctf):
lab
Enter a name for this configuration:
test
Enter the full path to your current ovpn file:
~/Downloads/lab_jgh0stsecops.ovpn
Moved and renamed /Users/jgh0stsecops/Downloads/lab_jgh0stsecops.ovpn to /Users/jgh0stsecops/.ovpn/lab_test.ovpn
htb function already exists in ~/.zshrc. Use --force to overwrite.
```

### Connect using the function
```sh
❯ htb status
VPN status:
❯ htb connect lab main
Connecting to Hack The Box lab main...
Connected on utun8 with IP 10.10.14.27.
❯ htb connect lab test
Connecting to Hack The Box lab test...
Connected on utun9 with IP 10.10.14.27.
❯ htb status
VPN status:
lab_test: Connected on utun9 with IP 10.10.14.27
lab_main: Connected on utun8 with IP 10.10.14.27
```

Enjoy a much much better experience shuffling around your HTB files!
