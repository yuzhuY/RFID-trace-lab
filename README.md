# RFID-trace-lab

## Translation
The RFID trace we finally interpreted it as the following array:
020111111111111111113
1010v1011010110101011011101010101101111011011110101101013021100000111
111111111111110011111110101011

Note:0 means "data-0", 1 means "data-1", "v" is part of preampble,2
presents longer pulse, 3 is a special label we set by ourselves which means the start and the end of reply.

This array will be divided into three parts in order to investigate deep meaning behind it.


## Meaning of each part

1. The first part is "02011111111111111111", if we put preamble aside, it can be seen that this command starts with "01", which means it is a ACK command. And the length of this command is 18 bits.
2. The response from label is "1010v101101011010101101110101010110111101101111010110101". It is a 56 bits reply.
3. In the end, reader sends a 44 bits message to label again. It is "021100000111
111111111111110011111110101011". The start of this array is 11000001. So we
consider it as a Req RN command. According to following table from given reference book, a successful ACK command should between 21 bits to 33328 bits, and what we derived meet this condition.

##Conclusion
According to the three times communications we derived, we can see it is a part of the following showed communication between reader and tag:
<p align="center"><img src="https://github.com/yuzhuY/RFID-trace-lab/blob/master/CommunicationBetweenReaderAndTag.jpg" width="250">

In this way, the three
times communication between reader and tag are identified as ACK(RN16),
reply,Req RN.

More details can be seen in file [RFID_trace_lab_Report.pdf](https://github.com/yuzhuY/RFID-trace-lab/blob/master/RFID_trace_Lab_Report.pdf)
