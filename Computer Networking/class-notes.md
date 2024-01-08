<!-- omit in toc -->
# Δίκτυα Υπολογιστών

<!-- omit in toc -->
## Περιεχόμενα
- [11/10/2023 - Πρώτο μάθημα](#11102023---πρώτο-μάθημα)
- [23/10/2023 - 2ο Μάθημα](#23102023---2ο-μάθημα)
  - [Excersise analysis](#excersise-analysis)
- [30/10/2023 - 4ο Μάθημα](#30102023---4ο-μάθημα)
- [13/11/2023 - 7ο Μάθημα](#13112023---7ο-μάθημα)
- [8/1/2024 - ? Μάθημα (Επανάληψη Υποδικτύωσης)](#812024----μάθημα-επανάληψη-υποδικτύωσης)


## 11/10/2023 - Πρώτο μάθημα

- Οι διαφάνειες του μαθηματος ειναι στο site του Βίτσα.


## 23/10/2023 - 2ο Μάθημα

- A host, in order to connect to its network, only needs to know its own IP, the IP of its router and the subnet mask (or prefix).
- For future reference `/24`=`255.255.255.0`. This means that the usable hosts are `2^8-2=254` (the `-2` is because the first and last IP are reserved for the network and broadcast address respectively).

### Excersise analysis

- When the excercise says that each network is in need of eg 13 hosts the way we sould calculate the required address is x=13 + 1 (for the router) + 2 (1 broadcast + 1 network) = 16. So we need to find the smallest power of 2 that is equal or greater than 16. This is 2^4=16. So we need 4 bits for the host part of the address. So the subnet mask is /28.
- In the end of the excercise we need to add the subnets of every peer-to-peer connection between the routers. So we need to add 1 subnet for each connection. These subnets are /30 because we need 2 hosts (1 for each router) + 2 (1 broadcast + 1 network) = 4. So we need 2 bits for the host part of the address. If we have 3 routers (eg A, B, C) that all connect to a central router (D) we need 3 subnets (A-D, B-D, C-D), each with a /30 subnet mask. So in total we need 12 more IP addresses (3 subnets * 4 IPs/subnet).
- When increasing the number of the host requirements in a subnet beyond what its current mask can provide, the whole subnet is moved to a later IP address and changes its subnet mask to satisfy the new requirements. The new subnet that will be created needs to start from an IP that matches the ones and zeroes of the new subnet mask. For example if the latest occupied IP in a network is `192.168.1.83` and a new subnet comes that needs to have 13 hosts (`/28` subnet mask) then the new subnet will be `192.168.1.96/28` and not `192.168.1.84/28` because the latter does not start with 4 zeroes and doesn't end with 4 ones when treated as a binary number.


## 30/10/2023 - 4ο Μάθημα

- Οι διαδικτυακες συσκευες τρεχουν μονο τα 3 κατώτερα επιπεδα του μοντέλου OSI και τα υπολοιπα τρέχουν στους τελικούς κόμβους ενός δικτύου (end systems).
- Υπάρχουν 2 πιθανές αρχιτεκτονικές για web applications:
  - Client - Server
    * Ο client είναι ο browser και ο server είναι ο web server (συνήθως).
    * Οι σέρβερ:
      * Είναι πάντα on.
      * Έχουν σταθερή IP.
    * Οι clients:
      * Είναι συνήθως off.
      * Έχουν δυναμική IP.
      * Είναι πολλοί.
  - Peer-to-Peer
    * no always-on server
    * arbitrary end systems directly communicate
    * peers request service from other peers, provide service in return to other peers
    * self scalability: new peers bring new service capacity, as well as new service demands
    * peers are intermittently connected and change IP addresses
- Client Processes initiate communication
- Server Processes wait to be contacted and end the communication
- Applications with P2P architectures have both client and server processes running on the same end system
- Sockets: A buffer that is used by the application layer to keep data for each connection (usually).
- To recieve a message, each process must have and ID, in order to do that we use the IP address and the port number of that process.
- A protocol defines the format and the order of messages exchanged between two or more communicating entities, as well as the actions taken on the transmission and/or receipt of a message or other event
- Πράγματα που αφορούν το Transport layer:
  - data integrity: some apps require 100% reliable data transfer (eg file transfering) and some other apps don't (eg audio)
  - timing: some apps require low delay to be effective (eg real time apps) and some other apps don't (eg email)
  - throughput: some apps require minimum amount of throughput to be effective (eg multimedia) and some other apps don't (eg email, file transfer)
  - security: some apps require encryption of data (eg online shopping) and some other apps don't (eg audio)
- Το transport layer παρέχει τις παρακάτω υπηρεσίες:
  - Connection-oriented service: TCP
    * εγγύηση παράδοσης, flow control, congestion control, connection-oriented (χρειάζεται setup μεταξύ πελάτη και εξυπηρετητη)
    * Δεν προσφέρει: timing, minimum throughput guarantee, security
    * Χρησιμοποιείται για file transfer, email, web documents
  - Connectionless service: UDP
    * Απλό, χωρίς σύνδεση, καμία εγγύηση παράδοσης, καμία εγγύηση σειράς παράδοσης, καμία συντήρηση καταστάσεων
    * Χρησιμοποιείται για streaming multimedia, real-time audio/video, DNS
- Web & HTTP:
  - A web page constists of multiple objects like HTML file, JPEG image, Java applet, audio file, etc.
  - Each object is addressable by a URL (Uniform Resource Locator)
  - HTTP (HyperText Transfer Protocol) is the Web's application layer protocol and uses the client-server model
  - HTTP uses TCP as its underlying transport protocol and creates a socket on port 80
  - HTTP is stateless, which means that the server does not keep any information about past client requests
- Persistent HTTP
  - server leaves connection open after sending response
  - subsequent HTTP messages between same client/server sent over open connection
  - client sends requests as soon as it encounters a referenced object
  - as little as one RTT for all the referenced objects
- Non-persistent HTTP
  - at most one object is sent over a TCP connection
  - HTTP/1.0 uses non-persistent HTTP
  - RTT for each referenced object
- HTTP request message
  - ASCII (human-readable format)
  - Request methods (GET, POST, HEAD, PUT, DELETE, TRACE, OPTIONS, CONNECT)
  - Header lines
  - Optional message body
- HTTP response status codes
  - status codes appear in first line of HTTP response (and in first line of server-to-server response)
  - they are split into 5 classes:
    - 1xx: informational
    - 2xx: success
    - 3xx: redirection
    - 4xx: client error
    - 5xx: server error
  - some sample status codes:
    - 200 OK
    - 301 Moved Permanently
    - 400 Bad Request
    - 404 Not Found
    - 505 HTTP Version Not Supported
- Cookies: keeping "state"
- Web caching (proxy server)
  - goal: satisfy client request without involving origin server
  - user sets browser: Web accesses via cache
  - browser sends all HTTP requests to cache
  - if object in cache: cache returns object
  - else cache requests object from origin server, then returns object to client
  - cache acts as both client (to the origin server) and server (to the client)
  - Pros: reduced response time for client request, reduced traffic on an institution's access link
  - Cons: cache may be out of date, cache may serve stale object
  - typically cache is installed by ISP (university, company, residential ISP)
- Conditional GET
  - Goal: don't send object if cache has up-to-date cached version
  - client specifies date of cached copy in HTTP request using the `If-modified-since: <date>` header line
  - server response contains no object if cached copy is up-to-date: `HTTP/1.0 304 Not Modified`


## 13/11/2023 - 7ο Μάθημα

- Το TCP είναι connection-oriented, δηλαδή χρειάζεται handshaking (3-way handshake) μεταξύ client και server πριν ξεκινήσει η επικοινωνία.
- Είναι reliable, δηλαδή εγγυάται την παράδοση των δεδομένων.
- Κάνει congestion & flow control, δηλαδή ρυθμίζει τον ρυθμό μετάδοσης των δεδομένων ώστε να μην υπάρχει συμφόρηση.
- TCP Segment Structure (32 bit per line until the end of the header):
  - Source port number: 16 bits + Destination port number: 16 bits (Τα port numbers του αποστολέα και του παραλήπτη)
  - Sequence number: 32 bits (Αριθμός σειράς του segment σε ενα ευρύτερο stream)
  - Acknowledgement number: 32 bits (Αριθμός σειράς του επόμενου segment που περιμένει ο αποστολέας)
  - Header length (Το μέγεθος του παραθύρου που έχει ο παραλήπτης): 4 bits + not used: 4 bits + Control bits (Τα flags είναι: URG, ACK, PSH, RST, SYN, FIN και χρησιμοποιούνται για να δείξουν την κατάσταση του segment): 8 bits + receive window (Το μέγεθος του παραθύρου χρόνου που έχει ο παραλήπτης για να στείλει ACK): 16 bits
  - Checksum: 16 bits + Urgent pointer (Χρησιμοποιείται για να δείξει το offset του τελευταίου byte του urgent data): 16 bits
  - Options: 0-320 bits (variable length)
  - Data: 0-65,535 bytes (variable length)
- TCP seq. numbers and ACKs
  - Seq. Numbers: byte stream "number" of first byte in segment's data
  - ACKs: seq number of next byte expected from other side (cumulative ACK)
- TCP Round Trip Time (RTT) and Timeout
  - RRT varies, mainly because of network congestion or distance
  - When RRT is too short, the sender will timeout too often and retransmit unnecessarily
  - When RRT is too long, the sender will wait too long before retransmitting
  - Estimating the RTT
    * SampleRTT: measured time from segment transmission until ACK receipt
    * In case of retransmission, do not use measured SampleRTT
    * SampleRTT will vary, want estimated RTT "smoother" (average several recent measurements, not just current SampleRTT)
- TCP reliable data transfer with ACKs
  - duplicate ACKs (Αν ο αποστολέας λάβει 3 συνεχόμενα duplicate ACKs τότε θα ξαναστείλει το segment που έχει τον μικρότερο αριθμό σειράς από το ACK που περίμενε)
  - timeout (Αν ο αποστολέας δεν λάβει ACK μέσα σε ένα χρονικό διάστημα ίσο με τον χρόνο που υπολόγισε ότι χρειάζεται για να φτάσει το segment τότε θα ξαναστείλει το segment που έχει τον μικρότερο αριθμό σειράς από το ACK που περίμενε)
  - Ο αποστολέας στέλνει διπλότυπο ACK στη περίπτωση που το Seq. Number του segment που λάβει είναι μεγαλύτερο από το Acknowledgement number που περίμενε
- TCP Congestion Control


## 8/1/2024 - ? Μάθημα (Επανάληψη Υποδικτύωσης)

**Άσκηση 1**:
Σε μια εταιρεία δώθηκε το παρακάτω δίκτυο: 195.251.123.0/25 (Άρα 195.251.123.0 - 195.251.123.127)
Το δίκτυο αυτό θα χρησιμοποιηθεί για την σύνδεση 4 routers. 
Τα routers αυτά θα έχουν τις εξής απαιτήσεις:
Αθήνα (Α) - 13 hosts
Θεσσαλονίκη (Θ1) - 12 hosts
Θεσσαλονίκη (Θ2) - 4 hosts
Πάτρα (Π) - 4 hosts
Λάρισα (Λ) - 3 hosts

Όλοι οι routers συνδέονται με ευθεια ζευξη με τον router της Αθήνας (Α).
Ο router της Αθήνας (Α) συνδέεται με τον ISP για την πρόσβαση στο Internet. (Δε μας ενδιαφερει αυτό)
Αναθέστε τις απαιτούμενες διευθύνσεις IP στα routers και στις ζεύξεις τους.

**Απάντηση**:

- Αθήνα (Α) -> 13 hosts + 1 Router = 14 -> 2^4=16 -> /28 -> 195.251.123.0/28 (195.251.123.0-15)
> Αυτο που παρατηρω ειναι οτι εχει νοημα κοιτώντας τη μασκα, να υπολογιζω το τελευταιο κομματι σε bits, δηλαδη 195.251.123.*|0|?|?|?|?|?|?|?|*
> Ετσι αν το μεγαλυτερο μμ υποδίκτυο χρειαζεται να κατακερματίσει χρησιμοποιώντας 16 bits, δλδ 2^4=16 και αρα θα πρεπει να χρησιμοποιησει /28 μασκα,
> τοτε ο υπολογισμος της διευθυνσης του υποικτυου μπορει να υπολογιστει με βαση τους συνδιασμους των bits αυτών.
> Στην προκειμενη περιπτωση αν χρειαζομαι 4 bits για το υποδικτυο, υπολοιπονται 3 ακομα bits για διαφορετικους συνδιασμους άλλων υποδικτύων (2^3=8 υποδίκτυα με 16 hosts)
- Θεσσαλονίκη (Θ1) -> 12 hosts + 1 Router = 13 -> 2^4=16 -> /28 -> 195.251.123.16/28 (195.251.123.16-31)
- Θεσσαλονίκη (Θ2) -> 4 hosts + 1 Router = 5 -> 2^3=8 -> /29 -> 195.251.123.32/29 (195.251.123.32-39)
- Πάτρα (Π) -> 4 hosts + 1 Router = 5 -> 2^3=8 -> /29 -> 195.251.123.40/29 (195.251.123.40-47)
- Λάρισα (Λ) -> 3 hosts + 1 Router = 4 -> 2^3=8 -> /29 -> 195.251.123.48/29 (195.251.123.48-55)
- Συνδέσεις:
  - Αθήνα (Α) - Θεσσαλονίκη -> 2 hosts + 2 Routers = 4 -> 2^2=4 -> /30 -> 195.251.123.56/30 (195.251.123.56-59)
  - Αθήνα (Α) - Πάτρα -> 2 hosts + 2 Routers = 4 -> 2^2=4 -> /30 -> 195.251.123.60/30 (195.251.123.60-63)
  - Αθήνα (Α) - Λάρισα -> 2 hosts + 2 Routers = 4 -> 2^2=4 -> /30 -> 195.251.123.64/30 (195.251.123.64-67)

> Ενας επισης ευκολος τροπος να δουμε τον κατακερματισμο ειναι να φτιαξουμε ενα μίνι γραφημα με 32αδες απο IPs οπου να χωριζουμε για παράδειγμα:
> - | Α (16)                          | Θ1 (16)                   |
> - | Θ2 (8)              | Π (8)     | Λ (8) | Α-Θ (4) | Α-Π (4) | 
> - | Α-Λ (4) | empty (4) | empty (8) | empty (16)                |
> - | empty (32)                                                  |

**Άσκηση 2**:

Υπολογίστε τις μετατροπες που πρεπει να γινουν στο παραπάνω δίκτυο για να ισχυουν οι παρακάτω απαιτήσεις:
- Λ += 3 hosts

**Aπάντηση**:

- Λ += 3 hosts -> 3+3 hosts + 1 router = 7 -> 2^4=16 -> /28 -> 195.251.123.80/28 (195.251.123.80-95) (Αυτό είναι το μόνο που αλλάζει, το υπόλοιπο παραμένει ίδιο και οι προηγούμενες IP μένουν κενες)
> Με βάση το παραπάνω note μου, πλεον ο κατακερματισμός είναι κάπως έτσι:
> - | Α (16)                          | Θ1 (16)                       |
> - | Θ2 (8)              | Π (8)     | empty (8) | Α-Θ (4) | Α-Π (4) |
> - | Α-Λ (4) | empty (4) | empty (8) | Λ (16)                        |
> - | empty (32)                                                      |

**Άσκηση 3**:

Υπολογιστε τις μετατροπες που πρέπει να γίνουν στο παραπάνω δίκτυο για να ισχύουν οι παρακάτω απαιτήσεις:
- Θ1 += 3 hosts
- Π += 3 hosts
- Νέο router στο Ηράκλειο (Η) με 8 hosts

**Απάντηση**:

- Θ1 += 3 hosts -> 3+12 hosts + 1 router = 16 -> 2^5=32 -> /27 -> 195.251.123.96/27 (195.251.123.96-127) (Οι προηγούμενες IP μένουν κενές)
- Π += 3 hosts -> 3+4 hosts + 1 router = 8 -> 2^4=16 -> /28 -> 195.251.123.16/28 (195.251.123.16-31) (Οι προηγούμενες IP μένουν κενές)
- Ηράκλειο (Η) -> 8 hosts + 1 router = 9 -> 2^4=16 -> /28 -> 195.251.123.64/28 (195.251.123.64-79) (Θα αναγκαστώ να μετακινήσω κάτι και επιλέγω το Α-Λ γτ θα μετακινηθουν τα λιγότερα hosts)
- Αναγκαστική Μετακίνηση:
  - Α-Λ -> 2 hosts + 2 routers = 4 -> 2^2=4 -> /30 -> 195.251.123.48/30 (195.251.123.48-51)

> Με βάση το παραπάνω note μου, πλεον ο κατακερματισμός είναι κάπως έτσι:
> - | Α (16)                          | Π (16)                                  |
> - | Θ2 (8)              | empty (8) | Α-Λ (4) | empty (4) | Α-Θ (4) | Α-Π (4) |
> - | Η (16)                          | Λ (16)                                  |
> - | Θ1 (32)                                                                   |