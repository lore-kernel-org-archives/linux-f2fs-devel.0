From: Chao Yu <yuchao0@huawei.com>
Subject: Re: f2fs issue on linux-5.0.0-rc2
Date: Thu, 17 Jan 2019 10:00:12 +0800
Message-ID: <4ffd83a1-8599-5f39-1114-4f878dbfcc4e@huawei.com>
References: <CAAJw_Zuf=-BUYQDpbB2Yk2z9hG7ikzNoyPB4DScJp4n7JN+sCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gjwyp-0008HP-Hs
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Jan 2019 02:00:27 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gjwym-00AnYo-P7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Jan 2019 02:00:27 +0000
In-Reply-To: <CAAJw_Zuf=-BUYQDpbB2Yk2z9hG7ikzNoyPB4DScJp4n7JN+sCw@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jeff Chua <jeff.chua.linux@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

On 2019/1/16 20:57, Jeff Chua wrote:
> This is on rpi3b+ running latest linux git pull, and root filesystem
> is "read-only" ...

Did you hit this issue after you upgrade kernel from lower one to 5.0?

> 
> Here's the full error ...
> 
> This also reported on ...
> 
> https://github.com/raspberrypi/linux/issues/2811
> 
> # dmesg
> Booting Linux on physical CPU 0x0
> CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=10c5383d
> CPU: div instructions available: patching division code
> OF: fdt: Machine model: Raspberry Pi 3 Model B Plus Rev 1.3
> cma: Reserved 8 MiB at 0x2f800000
> On node 0 totalpages: 196608
>   Normal zone: 1536 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 196608 pages, LIFO batch:63
> percpu: Embedded 16 pages/cpu @(ptrval) s34444 r8192 d22900 u65536
> pcpu-alloc: s34444 r8192 d22900 u65536 alloc=16*4096
> pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> rcu: Hierarchical RCU implementation.
> rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> arch_timer: cp15 timer(s) running at 19.20MHz (phys).
> clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:
> 0x46d987e47, max_idle_ns: 440795202767 ns
> sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> rcu: Hierarchical SRCU implementation.
> smp: Bringing up secondary CPUs ...
> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> smp: Brought up 1 node, 4 CPUs
> SMP: Total of 4 processors activated (153.60 BogoMIPS).
> CPU: All CPU(s) started in HYP mode.
> CPU: Virtualization extensions available.
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 19112604462750000 ns
> pinctrl core: initialized pinctrl subsystem
> hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
> hw-breakpoint: maximum watchpoint size is 8 bytes.
> Serial: AMBA PL011 UART driver
> bcm2835-mbox 3f00b880.mailbox: mailbox enabled
> raspberrypi-firmware soc:firmware: Request 0x00000002 returned status 0x80000001
> raspberrypi-firmware soc:firmware: Attached to firmware from
> 2019-01-10 15:00, variant cmd unsupported
> raspberrypi-firmware soc:firmware: Request 0x00000003 returned status 0x80000001
> Advanced Linux Sound Architecture Driver Initialized.
> FS-Cache: Loaded
> CacheFiles: Loaded
> hw perfevents: enabled with armv7_cortex_a7 PMU driver, 7 counters available
> Initialise system trusted keyrings
> workingset: timestamp_bits=30 max_order=18 bucket_order=0
> Key type asymmetric registered
> Asymmetric key parser 'x509' registered
> bcm2835-rng 3f104000.rng: hwrng registered
> vc-mem: phys_addr:0x00000000 mem_base=0x3ec00000 mem_size:0x40000000(1024 MiB)
> vc-sm: Videocore shared memory driver
> libphy: Fixed MDIO Bus: probed
> tun: Universal TUN/TAP device driver, 1.6
> dwc_otg 3f980000.usb: base=0xf0980000
> dwc_otg: Microframe scheduler enabled
> dwc_otg: FIQ disabled
> dwc_otg: NAK holdoff enabled
> dwc_otg: FIQ split-transaction FSM disabled
> Module dwc_common_port init
> IR NEC protocol handler initialized
> IR RC5(x/sz) protocol handler initialized
> IR RC6 protocol handler initialized
> IR JVC protocol handler initialized
> IR Sony protocol handler initialized
> IR SANYO protocol handler initialized
> IR Sharp protocol handler initialized
> IR MCE Keyboard/mouse protocol handler initialized
> IR XMP protocol handler initialized
> bcm2835-wdt 3f100000.watchdog: Broadcom BCM2835 watchdog timer
> bcm2835-cpufreq: min=600000 max=1400000
> mmc-bcm2835 3f300000.mmc: could not get clk, deferring probe
> ledtrig-cpu: registered to indicate activity on CPUs
> [vc_sm_connected_init]: start
> [vc_sm_connected_init]: end - returning 0
> bcm2835_audio bcm2835_audio: card created with 8 channels
> Registering SWP/SWPB emulation handler
> Loading compiled-in X.509 certificates
> uart-pl011 3f201000.serial: cts_event_workaround enabled
> 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 81, base_baud = 0)
> is a PL011 rev2
> mmc-bcm2835 3f300000.mmc: mmc_debug:0 mmc_debug2:0
> mmc-bcm2835 3f300000.mmc: DMA channel allocated
> sdhost: log_buf @ (ptrval) (ef853000)
> mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
> mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
> mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
> mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
> mmc0: sdhost-bcm2835 loaded - DMA enabled (>1)
> of_cfs_init
> of_cfs_init: OK
> ALSA device list:
>   #0: bcm2835 ALSA
> Waiting for root device /dev/mmcblk0p2...
> mmc1: new high speed SDIO card at address 0001
> mmc0: host does not support reading read-only switch, assuming write-enable
> mmc0: new high speed SDHC card at address aaaa
> mmcblk0: mmc0:aaaa SL16G 14.8 GiB
>  mmcblk0: p1 p2 p3 p4
> F2FS-fs (mmcblk0p2): Found nat_bits in checkpoint
> F2FS-fs (mmcblk0p2): recover fsync data on readonly fs
> F2FS-fs (mmcblk0p2): Mounted with checkpoint version = 33864fd
> VFS: Mounted root (f2fs filesystem) readonly on device 179:2.
> Freeing unused kernel memory: 1024K
> Run /sbin/init as init process
> lan78xx 1-1.1.1:1.0 (unnamed net_device) (uninitialized): No External
> EEPROM. Setting MAC Speed
> libphy: lan78xx-mdiobus: probed
> lan78xx 1-1.1.1:1.0 (unnamed net_device) (uninitialized): int urb period 64
> F2FS-fs (mmcblk0p4): Found nat_bits in checkpoint
> F2FS-fs (mmcblk0p4): recover fsync data on readonly fs
> F2FS-fs (mmcblk0p4): Mounted with checkpoint version = cb5fbf0
> F2FS-fs (mmcblk0p3): Found nat_bits in checkpoint
> F2FS-fs (mmcblk0p3): recover fsync data on readonly fs
> F2FS-fs (mmcblk0p3): Mounted with checkpoint version = cb5fbee
> Unable to handle kernel NULL pointer dereference at virtual address 00000014
> pgd = e06bd8bb
> [00000014] *pgd=00000000
> Internal error: Oops: 17 [#1] SMP ARM
> Modules linked in: bnep btusb btintel btbcm btrtl bluetooth ecdh_generic rfkill
> CPU: 2 PID: 750 Comm: kworker/u8:3 Not tainted 5.0.0-rc2 #1
> Hardware name: BCM2835
> Workqueue: writeback wb_workfn (flush-179:0)
> PC is at f2fs_balance_fs_bg+0x26c/0x2a8
> LR is at f2fs_build_free_nids+0x394/0x510
> pc : [<803187e4>]    lr : [<803120b8>]    psr: 600a0013
> sp : aebe9d50  ip : aea8a840  fp : aebe9ee0
> r10: 80a03d00  r9 : 80a09c88  r8 : ae5743a4
> r7 : aebe9df0  r6 : 80a09c88  r5 : 80a09c88  r4 : ae270000
> r3 : 00000000  r2 : aea9d600  r1 : 00000000  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5383d  Table: 2ba7006a  DAC: 00000055
> Process kworker/u8:3 (pid: 750, stack limit = 0x295c935e)
> Stack: (0xaebe9d50 to 0xaebea000)
> 9d40:                                     af7a1040 802f222c af7a1040 ae5c8000
> 9d60: ae270000 148e697c 00000000 ae270000 00000000 80311ae0 aebe9ee0 802f2774
> 9d80: 80941c00 aebe9df0 ae5c80ec 148e697c ae25544c aebe9df0 ae5743a4 aebe9df0
> 9da0: ae25544c 801b7f34 ae5742b8 ae255438 aebe9df0 80222e94 00000000 ade61588
> 9dc0: ae574360 ae255438 ae5742b8 ae25544c aeaa5800 802231b8 00000001 aebe8000
> 9de0: ffff9930 ae574320 00000000 00000c00 00000c00 00000000 00000000 00000000
> 9e00: ffffffff 7fffffff 00000000 00000011 80a09c88 148e697c ffbdae30 ae255438
> 9e20: aeaa5800 ae5c80a8 00000000 aebe9ee0 ae25544c 80a03d00 ffff993a 802234d0
> 9e40: 00000007 ae255438 aebe9ee0 ffff9930 ffff9930 0000000a 80a03d00 80a14950
> 9e60: ae255464 802236b0 ffff0a00 ae255514 000009d7 80a09c88 ae9f1080 ffff8d78
> 9e80: aebe9e80 aebe9e80 aebe9e88 aebe9e88 ae000000 148e697c ae25543c ae25551c
> 9ea0: ae255510 ae255438 ae255514 ae25543c 80a1494c 80a03d00 000009d7 80224274
> 9ec0: 00000000 80a09c88 2e888000 aea8a840 ae8a4018 aea8a840 af1c9c00 ae87c500
> 9ee0: 000009d7 00000000 aebe9e7c 00000000 00000006 00000003 00000000 00000000
> 9f00: 00000000 148e697c ad61c0c4 ae25551c ae9f1080 ae806200 ae805c00 00000000
> 9f20: ae255520 00000000 ae806200 80135984 00000088 80a03d00 ae9f1080 ae806200
> 9f40: ae9f1094 00000088 80a03d00 ae806218 aebe8000 80136720 aebe8000 ae9a8100
> 9f60: 00000000 aea71a40 aebe8000 ae9a8100 00000000 ae9f1080 801366f0 aeb0deb4
> 9f80: aea71a5c 8013b370 00000001 ae9a8100 8013b26c 00000000 00000000 00000000
> 9fa0: 00000000 00000000 00000000 801010d8 00000000 00000000 00000000 00000000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [<803187e4>] (f2fs_balance_fs_bg) from [<80311ae0>]
> (f2fs_write_node_pages+0x40/0x148)
> [<80311ae0>] (f2fs_write_node_pages) from [<801b7f34>] (do_writepages+0x20/0x7c)
> [<801b7f34>] (do_writepages) from [<80222e94>]
> (__writeback_single_inode+0x2c/0x1b0)
> [<80222e94>] (__writeback_single_inode) from [<802231b8>]
> (writeback_sb_inodes+0x1a0/0x444)
> [<802231b8>] (writeback_sb_inodes) from [<802234d0>]
> (__writeback_inodes_wb+0x74/0xac)
> [<802234d0>] (__writeback_inodes_wb) from [<802236b0>]
> (wb_writeback+0x1a8/0x1fc)
> [<802236b0>] (wb_writeback) from [<80224274>] (wb_workfn+0x178/0x33c)
> [<80224274>] (wb_workfn) from [<80135984>] (process_one_work+0x204/0x418)
> [<80135984>] (process_one_work) from [<80136720>] (worker_thread+0x30/0x59c)
> [<80136720>] (worker_thread) from [<8013b370>] (kthread+0x104/0x134)
> [<8013b370>] (kthread) from [<801010d8>] (ret_from_fork+0x14/0x3c)
> Exception stack(0xaebe9fb0 to 0xaebe9ff8)
> 9fa0:                                     00000000 00000000 00000000 00000000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Code: e5933058 e3530000 1affff8a e592306c (e5933014)
> ---[ end trace b0c047f17d4eb527 ]---

Why there are dirty data/node in readonly filesystem?

Could you try below commands to make sure where it actually crash?

gdb f2fs.ko
l *(f2fs_balance_fs_bg+0x26c/0x2a8)
l *(f2fs_build_free_nids+0x394/0x510)

Thanks,

> 
> 
> 
