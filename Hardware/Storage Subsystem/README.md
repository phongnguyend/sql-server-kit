### IOPS & Throughput:
### 1. IOPS:

**IOPS (Input/Output Operations Per Second, pronounced i-ops)** is a common performance measurement used to benchmark computer storage devices like hard disk drives (HDD), solid state drives (SSD), and storage area networks (SAN). As with any benchmark, IOPS numbers published by storage device manufacturers do not guarantee real-world application performance.

**IOPS** can be measured with applications such as Iometer (originally developed by Intel), as well as IOzone and FIO and is primarily used with servers to find the best storage configuration.

The specific number of IOPS possible in any system configuration will vary greatly depending upon the variables the tester enters into the program, including the balance of read and write operations, the mix of sequential and random access patterns, the number of worker threads and queue depth, as well as the data block sizes. There are other factors which can also affect the IOPS results including the system setup, storage drivers, OS background operations, etc. Also, when testing SSDs in particular, there are preconditioning considerations that must be taken into account.

[(Reference)](https://kb.sandisk.com/app/answers/detail/a_id/8153/~/input%2Foutput-operations-per-second-%28iops%29-defined)

### 2. Throughput:

**Throughput measures the data transfer rate to and from the storage media in megabytes per second**. While your bandwidth is the measurement of the total possible speed of data movement along the network, throughput can be affected by IOPS and packet size. Network protocol can also change the overall throughput. It is a measurement of the ultimate amount of data that actually moves along the network path — while bandwidth is the potential capacity of the path without an extenuating factors.

[(Reference)](https://www.greenhousedata.com/blog/know-your-storage-constraints-iops-and-throughput)

### Hardware Identification:
1. [CPU-Z](https://www.cpuid.com/softwares/cpu-z.html)

### Disk Benchmarks:
1. [CrystalDiskMark](http://crystalmark.info/en/software/crystaldiskmark/)
2. [DiskSpd](https://gallery.technet.microsoft.com/DiskSpd-A-Robust-Storage-6ef84e62)

### Monitoring Tools:
1. [Windows Performance Monitor](https://blogs.technet.microsoft.com/askperf/2014/07/17/windows-performance-monitor-overview/)
2. [Windows Resource Monitor](https://www.digitalcitizen.life/how-use-resource-monitor-windows-7)
