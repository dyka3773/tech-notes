<!-- omit in toc -->
# Δίκτυα Υπολογιστών

<!-- omit in toc -->
## Περιεχόμενα
- [11/10/2023 - Πρώτο μάθημα](#11102023---πρώτο-μάθημα)
- [23/10/2023 - 2ο Μάθημα](#23102023---2ο-μάθημα)
  - [Excersise analysis](#excersise-analysis)


## 11/10/2023 - Πρώτο μάθημα

- Οι διαφάνειες του μαθηματος ειναι στο site του Βίτσα.


## 23/10/2023 - 2ο Μάθημα

- A host, in order to connect to its network, only needs to know its own IP, the IP of its router and the subnet mask (or prefix).
- For future reference `/24`=`255.255.255.0`. This means that the usable hosts are `2^8-2=254` (the `-2` is because the first and last IP are reserved for the network and broadcast address respectively).

### Excersise analysis
- When the excercise says that each network is in need of eg 13 hosts the way we sould calculate the required address is x=13 + 1 (for the router) + 2 (1 broadcast + 1 network) = 16. So we need to find the smallest power of 2 that is equal or greater than 16. This is 2^4=16. So we need 4 bits for the host part of the address. So the subnet mask is /28.
- In the end of the excercise we need to add the subnets of every peer-to-peer connection between the routers. So we need to add 1 subnet for each connection. These subnets are /30 because we need 2 hosts (1 for each router) + 2 (1 broadcast + 1 network) = 4. So we need 2 bits for the host part of the address. If we have 3 routers (eg A, B, C) that all connect to a central router (D) we need 3 subnets (A-D, B-D, C-D), each with a /30 subnet mask. So in total we need 12 more IP addresses (3 subnets * 4 IPs/subnet).
- When increasing the number of the host requirements in a subnet beyond what its current mask can provide, the whole subnet is moved to a later IP address and changes its subnet mask to satisfy the new requirements. The new subnet that will be created needs to start from an IP that matches the ones and zeroes of the new subnet mask. For example if the latest occupied IP in a network is `192.168.1.83` and a new subnet comes that needs to have 13 hosts (`/28` subnet mask) then the new subnet will be `192.168.1.96/28` and not `192.168.1.84/28` because the latter does not start with 4 zeroes and doesn't end with 4 ones when treated as a binary number.
- 