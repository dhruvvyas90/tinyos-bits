This task involved a grid of 16 TelosB motes with the packet delivery ratio between the main sender (mote 1) 
and the main receiver (mote 16) being monitored. Each packet was of 20 Bytes. The motes were arranged as follows:
                            
                            13 14 15 16
                            9  10 11 12
                            5  6  7  8
                            1  2  3  4

The protocol as of this code involved the packet being sent to 16 through multi hops through paths wherein each mote was
broadcasting either to the mote in front of it, or to its right. For instance, 6 would receive the packet from 5 or 2
(some times even from 1, but that depends on the power level settings and distance between the motes) and then 6 would forward
the packet to 10 or 7. In this manner, the data (essentially a counter running on mote 1) was forwarded to mote 16 by the grid.

In this code, each mote would also- 
a) append its own node ID to the data packet( so that we could trace the path of each packet)
b) increment a variable that kept track of the number of hops

and then forward the packet.

                            

                            
