#### Realtek 8812BU

- `sudo apt-get install build-essential dkms git`
- Follow <https://github.com/cilynx/rtl88x2bu>
- `sudo ifconfig eth0 down/up`


#### Change `metric`
Update `/etc/network/interfaces`
```
auto lo
iface lo inet loopback

allow-hotplug wlx1cbfcee52295
auto wlx1cbfcee52295
iface wlx1cbfcee52295 inet dhcp
    metric 299
```

Update `/etc/NetworkManager/NetworkManager.conf` to enable interface in NetworkManager 
```
[ifupdown]
managed=true
```

Restart:
```
sudo service networking restart
sudo service network-manager restart
```

#### Change `metric` using `ifmetric` 
`sudo ifmetric wlx1cbfcee52295 298`

#### Manual changes & testing
```
ip route list`
sudo ip route add default via 192.168.0.1 dev wlx1cbfcee52295`
ip route get 8.8.8.8`
```
