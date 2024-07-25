# FlightSurf feed client

- These scripts aid in setting up your current ADS-B receiver to feed [flightsurf.io](https://flightsurf.io/)
- This will not disrupt any existing feed clients

## 1: Find antenna coordinates and elevation

<https://www.freemaptools.com/elevation-finder.htm>

## 2: Install the FlightSurf feed client

```
curl -L -o /tmp/flightsurf-feed.sh https://flightsurf.io/feed.sh
sudo bash /tmp/flightsurf-feed.sh
```

## 3: Use netstat to check that your feed is working

```
netstat -t -n | grep -E '30004|31090'
```
Expected Output:
```
tcp        0    182 localhost:43530     65.109.2.208:31090      ESTABLISHED
tcp        0    410 localhost:47332     65.109.2.208:30004      ESTABLISHED
```

## 4: Optional: Install [local interface](https://github.com/wiedehopf/tar1090) for your data

The interface will be available at http://192.168.X.XX/flightsurf  
Replace the IP address with the address of your Raspberry Pi.

Install / Update:
```
sudo bash /usr/local/share/flightsurf/git/install-or-update-interface.sh
```
Remove:
```
sudo bash /usr/local/share/tar1090/uninstall.sh flightsurf
```

### Update the feed client without reconfiguring

```
curl -L -o /tmp/update.sh https://raw.githubusercontent.com/flightsurf/feed-client/main/update.sh
sudo bash /tmp/update.sh
```

### If you encounter issues, please do a reboot and then supply these logs on the forum or Discord (last 20 lines for each is sufficient):

```
sudo journalctl -u flightsurf-feed --no-pager
sudo journalctl -u flightsurf-mlat --no-pager
```

### Display the configuration

```
cat /etc/default/flightsurf
```

### Use an external source

If your feeder is on a separate device from the one this script is installed.
Edit config `sudo nano /etc/default/flightsurf` and change the IP on the following lines to point to your feeder device's IP:

```
INPUT="127.0.0.1:30005"
...
UAT_INPUT="127.0.0.1:30978"
```
Then restart the feed client:
```
sudo systemctl restart flightsurf-feed
sudo systemctl restart flightsurf-mlat
```

### Changing the configuration

This is the same as the initial installation.
If the client is up to date it should not take as long as the original installation,
otherwise this will also update the client which will take a moment.

```
curl -L -o /tmp/flightsurf-feed.sh https://raw.githubusercontent.com/flightsurf/feed-client/main/install.sh
sudo bash /tmp/flightsurf-feed.sh
```
Alternatively edit the config directly and restart the feed client
```
sudo nano /etc/default/flightsurf
sudo systemctl restart flightsurf-feed
sudo systemctl restart flightsurf-mlat
```

### Disable / Enable flightsurf MLAT-results in your main decoder interface (readsb / dump1090-fa)

- Disable:

```
sudo sed --follow-symlinks -i -e 's/RESULTS=.*/RESULTS=""/' /etc/default/flightsurf
sudo systemctl restart flightsurf-mlat
```
- Enable:

```
sudo sed --follow-symlinks -i -e 's/RESULTS=.*/RESULTS="--results beast,connect,127.0.0.1:30104"/' /etc/default/flightsurf
sudo systemctl restart flightsurf-mlat
```

### Other device as a data source (networked standalone receivers):

https://github.com/adsbxchange/wiki/wiki/Datasource-other-device

### Restart the feed client

```
sudo systemctl restart flightsurf-feed
sudo systemctl restart flightsurf-mlat
```

### Show status

```
sudo systemctl status flightsurf-feed
sudo systemctl status flightsurf-mlat
```

### Removal / disabling the services

```
sudo bash /usr/local/share/flightsurf/uninstall.sh
```

If the above doesn't work, you can just disable the services and the scripts won't run anymore:

```
sudo systemctl disable --now flightsurf-feed
sudo systemctl disable --now flightsurf-mlat
```
