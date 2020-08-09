---
title: "Case of the Disappearing Packets"
date: 2020-08-03T18:55:04+05:30
draft: false
tags: ["rca", "network"]
---



Once upon a time an innocent guy who had inherited the VPN infrastructure had been bugged enough by a new joinee whose VPN was throwing tantrums. Deferring it for a day, he finally managed to start digging.

If natural disasters across the country were not weird enough, now one specific call to `azure docdb` was failing with a TLS handshake failure through the VPN for only ONE guy out of 100+. So, the innocent guy's first response was to (like all VPN issues) check if the request is going through the VPN.

```bash
route -n get docdb0-dev.documents.azure.com
```

Well, it is. Hmm, so let’s see what happens if we curl it then? On a working system (innocent guys), it was opening with a not authorized JSON response while for the new-joinee (Let’s call him Ajay from now, sounds cooler), It was timing out after a long time. Interesting! Let’s disconnect the VPN and check the same. And damn! It opens with the JSON response now.

Is there another VPN process running? Well, no. Ran the `ps` command to confirm.

When you don’t know what to do, you think of everything under the sun - Is the VPN server doing some magic? Logs say no. Are there errors in VPN client logs? Nopitty Nopes.

Ok so let’s go into a little more detail. Curl with verbose output shows its getting stuck at first SSL handshake itself. By stuck it means stuck! No response at all. Is it an HTTPS related thing? No idea.

Now the first step in debugging any network problem is to get tcpdumps at every point so lets do that now. `tcpdump` on server and on Ajay’s system while `curl` operation showed that packets were going to `VPN server` and it was forwarding to destination as well and getting responses but `Ajays system` got no responses. So is his system blocking them somehow?

Ah! Mac firewall is ON. Let’s switch it off and life is awesome again for Ajay and the innocent guy. But of course, what can go wrong will go wrong. This doesn’t help. Innocent guy now blames the router and checks the router configuration of Ajays home. He even knows his wifi password now so he can be his wifi stealing neighbour now. (Sadly, they are 1000kms apart)

Back to the issue, there is no setting on the router causing this so despite so much information, both innocent guy and Ajay are clueless. Innocent guy disconnects the call disappointed with himself and his life choices, searches random things to get any hint but rather clueless and sad as usual escalated the issue to the Sire.

The issue was explained to Sire and he did the `tcpdump` routine but caught what the innocent guy missed. The packets being dropped were bigger than usual and suspicion straight away went to MTU. Sire added `mtu-test` flag to the `openvpn` client conf and that gave the response:

```bash
2020-06-19 09:54:32.070630 NOTE: Empirical MTU test completed [Tried,Actual] local->remote=[1541,1437] remote->local=[1541,1541]

2020-06-19 09:54:32.070655 NOTE: This connection is unable to accommodate a UDP packet size of 1541. Consider using --fragment or --mssfix options as a workaround.
```

Now it was a simple fix as the message said to add `mssfix 1300` and Aha! Problem Solved!
For the clueless innocent guy who would have never thought of MTU being the root, some references:

- [https://blog.cloudflare.com/path-mtu-discovery-in-practice/](https://blog.cloudflare.com/path-mtu-discovery-in-practice/)
- [https://forums.openvpn.net/viewtopic.php?t=21857](https://forums.openvpn.net/viewtopic.php?t=21857)
- [https://en.wikipedia.org/wiki/Path_MTU_Discovery](https://en.wikipedia.org/wiki/Path_MTU_Discovery)


On thinking further, what this meant is that the route from Ajay's laptop to the azure servers had some link with lower MTU. Damn! Blame the ISP infrastrcuture of India. 
