From: Chao Yu <yuchao0@huawei.com>
Subject: Re: BUG: kernel stack overflow when mounting with
 data_flush
Date: Sat, 30 Mar 2019 15:29:16 +0800
Message-ID: <5725124a-95c8-cedb-d3a8-d8be86d260dd@huawei.com>
References: <CADoWrG_NTz29eyaa3fUti2sNBP4xp7-zfhDVkix=Kty4rD=Otw@mail.gmail.com>
 <35b643e5-562c-942d-67ce-4a9dbef66d16@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hA8Qt-00029I-BP
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Mar 2019 07:29:39 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hA8Qf-001HgX-Ia
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Mar 2019 07:29:39 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 5F523A095D15E31BC5D7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Mar 2019 15:29:17 +0800 (CST)
In-Reply-To: <35b643e5-562c-942d-67ce-4a9dbef66d16@huawei.com>
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
To: Hagbard Celine <hagbardcelin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

Oh, sorry, it's quite possible that bug is caused by data_flush, could
remove that mount option first?

Thanks,

On 2019/3/30 11:25, Chao Yu wrote:
> Hi Hagbard,
> 
> Sorry for the delay.
> 
> On 2019/3/27 21:59, Hagbard Celine wrote:
>> Hi, this is a long standing bug that I've hit before on older kernels,
>> but I was not able to get the syslog saved because of the nature of
>> the bug. This time I had booted form a pen-drive, and was able to save
>> the log to it's efi-partition.
> 
> Now which version of kernel do you use? and do you remember what is your
> kernel version when this bug occured at first time?
> 
>> What i did to trigger it was to create a partition and format it f2fs,
>> then mount it with options:
>> "rw,relatime,lazytime,background_gc=on,disable_ext_identify,discard,heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,data_flush,extent_cache,mode=adaptive,active_logs=6,whint_mode=fs-based,alloc_mode=default,fsync_mode=strict".
>> Then I unpacked a big .tar.xz to the partition (I used a
>> gentoo-stage3-tarball as I was in process of installing Gentoo).
>>
>> Same options just without data_flush gives no problems.
>>
>> Syslog from crash follows:
>> Mar 20 20:20:34 usbgentoo syslog-ng[3644]: syslog-ng starting up;
>> version='3.17.2'
>> Mar 20 20:20:34 usbgentoo /usr/sbin/gpm[3674]: *** info
>> [daemon/startup.c(136)]:
>> Mar 20 20:20:34 usbgentoo /usr/sbin/gpm[3674]: Started gpm
>> successfully. Entered daemon mode.
>> Mar 20 20:20:34 usbgentoo kernel: ip (3771) used greatest stack depth:
>> 12312 bytes left
>> Mar 20 20:20:34 usbgentoo dhcpcd[3840]: eth0: waiting for carrier
>> Mar 20 20:20:37 usbgentoo kernel: igb 0000:03:00.0 eth0: igb: eth0 NIC
>> Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>> Mar 20 20:20:37 usbgentoo kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0:
>> link becomes ready
>> Mar 20 20:20:37 usbgentoo dhcpcd[3840]: eth0: carrier acquired
>> Mar 20 20:20:38 usbgentoo dhcpcd[3840]: DUID
>> 00:01:00:01:24:24:e8:94:d0:50:99:3b:c9:21
>> Mar 20 20:20:38 usbgentoo dhcpcd[3840]: eth0: IAID 99:3b:c9:21
>> Mar 20 20:20:38 usbgentoo dhcpcd[3840]: eth0: adding address
>> fe80::3c99:2bbf:63bb:8354
>> Mar 20 20:20:38 usbgentoo dhcpcd[3840]: eth0: rebinding lease of 192.168.1.22
>> Mar 20 20:20:38 usbgentoo dhcpcd[3840]: eth0: probing address 192.168.1.22/24
>> Mar 20 20:20:39 usbgentoo dhcpcd[3840]: eth0: soliciting an IPv6 router
>> Mar 20 20:20:43 usbgentoo dhcpcd[3840]: eth0: leased 192.168.1.22 for
>> 86400 seconds
>> Mar 20 20:20:43 usbgentoo dhcpcd[3840]: eth0: adding route to 192.168.1.0/24
>> Mar 20 20:20:43 usbgentoo dhcpcd[3840]: eth0: adding default route via
>> 192.168.1.1
>> Mar 20 20:20:43 usbgentoo dhcpcd[3840]: forked to background, child pid 3883
>> Mar 20 20:20:48 usbgentoo login[4003]: pam_unix(login:auth):
>> authentication failure; logname=LOGIN uid=0 euid=0 tty=/dev/tty1
>> ruser= rhost=  user=root
>> Mar 20 20:20:51 usbgentoo dhcpcd[3883]: eth0: no IPv6 Routers available
>> Mar 20 20:21:06 usbgentoo login[4003]: pam_unix(login:session):
>> session opened for user root by LOGIN(uid=0)
>> Mar 20 20:21:06 usbgentoo login[4012]: ROOT LOGIN  on '/dev/tty1'
>> Mar 20 20:22:30 usbgentoo kernel: EXT4-fs (sdb4): recovery complete
>> Mar 20 20:22:30 usbgentoo kernel: EXT4-fs (sdb4): mounted filesystem
>> with ordered data mode. Opts: (null)
>> Mar 20 20:22:39 usbgentoo kernel: EXT4-fs (sdb5): recovery complete
>> Mar 20 20:22:39 usbgentoo kernel: EXT4-fs (sdb5): mounted filesystem
>> with ordered data mode. Opts: (null)
>> Mar 20 20:22:46 usbgentoo login[4003]: pam_unix(login:session):
>> session closed for user root
>> Mar 20 20:22:51 usbgentoo login[4025]: pam_unix(login:session):
>> session opened for user root by LOGIN(uid=0)
>> Mar 20 20:22:51 usbgentoo login[4027]: ROOT LOGIN  on '/dev/tty1'
>> Mar 20 20:23:34 usbgentoo login[4004]: pam_unix(login:session):
>> session opened for user root by LOGIN(uid=0)
>> Mar 20 20:23:34 usbgentoo login[4034]: ROOT LOGIN  on '/dev/tty2'
>> Mar 20 20:30:21 usbgentoo kernel: F2FS-fs (nvme0n1p5): Found nat_bits
>> in checkpoint
>> Mar 20 20:30:22 usbgentoo kernel: F2FS-fs (nvme0n1p5): Mounted with
>> checkpoint version = b9e8e7
>> Mar 20 20:30:35 usbgentoo login[4025]: pam_unix(login:session):
>> session closed for user root
>> Mar 20 20:30:42 usbgentoo login[4061]: pam_unix(login:session):
>> session opened for user root by LOGIN(uid=0)
>> Mar 20 20:30:42 usbgentoo login[4063]: ROOT LOGIN  on '/dev/tty1'
>> Mar 20 20:40:31 usbgentoo kernel: Adding 23984124k swap on
>> /dev/nvme0n1p6.  Priority:-2 extents:1 across:23984124k SSDsc
>> Mar 20 20:54:01 usbgentoo kernel: FAT-fs (nvme0n1p4): Volume was not
>> properly unmounted. Some data may be corrupt. Please run fsck.
> 
> It looks that there are any other problems in your environment, nvme0n1p4
> volume is corrupted.
> 
>> Mar 20 21:05:23 usbgentoo kernel: kworker/dying (1588) used greatest
>> stack depth: 12064 bytes left
>> Mar 20 21:06:40 usbgentoo kernel: BUG: stack guard page was hit at
>> 00000000a4b0733c (stack is 0000000056016422..0000000096e7463f)
>> Mar 20 21:06:40 usbgentoo kernel: kernel stack overflow
> 
> And your kernel stack is overflow....
> 
> Thanks,
> 
>> (double-fault): 0000 [#1] SMP PTI
>> Mar 20 21:06:40 usbgentoo kernel: CPU: 7 PID: 1606 Comm:
>> kworker/u16:15 Not tainted 5.0.3-gentoo #6
>> Mar 20 21:06:40 usbgentoo kernel: Hardware name: To Be Filled By
>> O.E.M. To Be Filled By O.E.M./C226 WS, BIOS P3.40 06/25/2018
>> Mar 20 21:06:40 usbgentoo kernel: Workqueue: writeback wb_workfn (flush-259:0)
>> Mar 20 21:06:40 usbgentoo kernel: RIP: 0010:f2fs_inode_chksum_verify+0x14/0xc0
>> Mar 20 21:06:40 usbgentoo kernel: Code: 00 00 04 0f 45 f0 e9 3b 85 e8
>> ff 90 66 2e 0f 1f 84 00 00 00 00 00 48 8b 47 48 a8 40 0f 85 9d 00 00
>> 00 41 55 41 54 55 48 89 fd <53> 48 89 f3 e8 33 fd ff ff ba 01 00 00 00
>> 84 c0 75 09 5b 89 d0 5d
>> Mar 20 21:06:40 usbgentoo kernel: RSP: 0018:ffffb3ff4b0f4000 EFLAGS: 00010246
>> Mar 20 21:06:40 usbgentoo kernel: RAX: 0000000000000001 RBX:
>> ffffd57b5afeaa00 RCX: 0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: RDX: 0000000000000000 RSI:
>> ffffd57b5afeaa00 RDI: ffff9341f77f2000
>> Mar 20 21:06:40 usbgentoo kernel: RBP: ffff9341f77f2000 R08:
>> ffffb3ff4b0f4110 R09: ffff9340bfaa9377
>> Mar 20 21:06:40 usbgentoo kernel: R10: ffffb3ff4b0f41a0 R11:
>> 00000000fffffff3 R12: 000000000005c712
>> Mar 20 21:06:40 usbgentoo kernel: R13: 0000000000000000 R14:
>> 0000000000000001 R15: 0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: FS:  0000000000000000(0000)
>> GS:ffff9341fefc0000(0000) knlGS:0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Mar 20 21:06:40 usbgentoo kernel: CR2: ffffb3ff4b0f3ff8 CR3:
>> 000000006320e006 CR4: 00000000003606e0
>> Mar 20 21:06:40 usbgentoo kernel: DR0: 0000000000000000 DR1:
>> 0000000000000000 DR2: 0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: DR3: 0000000000000000 DR6:
>> 00000000fffe0ff0 DR7: 0000000000000400
>> Mar 20 21:06:40 usbgentoo kernel: Call Trace:
>> Mar 20 21:06:40 usbgentoo kernel:  read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  ? xas_load+0x8/0x50
>> Mar 20 21:06:40 usbgentoo kernel:  __get_node_page+0x73/0x2a0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_get_dnode_of_data+0x34e/0x580
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_inline_data+0x5e/0x2a0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x421/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  ? find_get_entries_tag+0x91/0x260
>> Mar 20 21:06:40 usbgentoo kernel:  ? get_partial_node.isra.86.part.87+0x2d/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  ? mempool_alloc+0x62/0x190
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  ? wait_woken+0x80/0x80
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  ? __switch_to_asm+0x40/0x70
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  ? raid6_avx5122_gen_syndrome+0x151/0x160
>> Mar 20 21:06:40 usbgentoo kernel:  ? sbitmap_get+0x71/0x160
>> Mar 20 21:06:40 usbgentoo kernel:  ? __sbitmap_queue_get+0x24/0x90
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_verify+0x1d/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  ? read_node_page+0x71/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_dirtied+0x21/0xc0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  __write_data_page+0x4fb/0x690
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_cache_pages+0x1cf/0x460
>> Mar 20 21:06:40 usbgentoo kernel:  ? __update_load_avg_cfs_rq+0x1b1/0x220
>> Mar 20 21:06:40 usbgentoo kernel:  ? enqueue_task_fair+0x441/0xfd0
>> Mar 20 21:06:40 usbgentoo kernel:  ? guard_bio_eod+0x27/0xf0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_data_pages+0x2b3/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? try_to_wake_up+0x52/0x550
>> Mar 20 21:06:40 usbgentoo kernel:  do_writepages+0x3c/0xd0
>> Mar 20 21:06:40 usbgentoo kernel:  ? nr_blockdev_pages+0xc/0x60
>> Mar 20 21:06:40 usbgentoo kernel:  ? si_meminfo+0x3a/0x60
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_available_free_memory+0x29/0x240
>> Mar 20 21:06:40 usbgentoo kernel:  ? complete+0x36/0x50
>> Mar 20 21:06:40 usbgentoo kernel:  __filemap_fdatawrite_range+0x7c/0xb0
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_sync_dirty_inodes+0xf2/0x200
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs_bg+0x2a3/0x2c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? __set_page_dirty_nobuffers+0xcb/0x100
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_balance_fs+0xd6/0x2b0
>> Mar 20 21:06:40 usbgentoo kernel:  ? f2fs_inode_chksum_set+0xc/0x40
>> Mar 20 21:06:40 usbgentoo kernel:  f2fs_write_inode+0x79/0x1c0
>> Mar 20 21:06:40 usbgentoo kernel:  __writeback_single_inode+0x2a1/0x340
>> Mar 20 21:06:40 usbgentoo kernel:  ? soft_cursor+0x1b4/0x220
>> Mar 20 21:06:40 usbgentoo kernel:  writeback_sb_inodes+0x1d5/0x3e0
>> Mar 20 21:06:40 usbgentoo kernel:  __writeback_inodes_wb+0x58/0xa0
>> Mar 20 21:06:40 usbgentoo kernel:  wb_writeback+0x250/0x2e0
>> Mar 20 21:06:40 usbgentoo kernel:  ? 0xffffffff8c000000
>> Mar 20 21:06:40 usbgentoo kernel:  ? cpumask_next+0x16/0x20
>> Mar 20 21:06:40 usbgentoo kernel:  wb_workfn+0x2f6/0x3b0
>> Mar 20 21:06:40 usbgentoo kernel:  ? __switch_to_asm+0x40/0x70
>> Mar 20 21:06:40 usbgentoo kernel:  process_one_work+0x1f5/0x3f0
>> Mar 20 21:06:40 usbgentoo kernel:  worker_thread+0x28/0x3c0
>> Mar 20 21:06:40 usbgentoo kernel:  ? rescuer_thread+0x330/0x330
>> Mar 20 21:06:40 usbgentoo kernel:  kthread+0x10e/0x130
>> Mar 20 21:06:40 usbgentoo kernel:  ? kthread_create_on_node+0x60/0x60
>> Mar 20 21:06:40 usbgentoo kernel:  ret_from_fork+0x35/0x40
>> Mar 20 21:06:40 usbgentoo kernel: Modules linked in: iTCO_wdt efivarfs
>> Mar 20 21:06:40 usbgentoo kernel: ---[ end trace 7d32682090ec7829 ]---
>> Mar 20 21:06:40 usbgentoo kernel: RIP: 0010:f2fs_inode_chksum_verify+0x14/0xc0
>> Mar 20 21:06:40 usbgentoo kernel: Code: 00 00 04 0f 45 f0 e9 3b 85 e8
>> ff 90 66 2e 0f 1f 84 00 00 00 00 00 48 8b 47 48 a8 40 0f 85 9d 00 00
>> 00 41 55 41 54 55 48 89 fd <53> 48 89 f3 e8 33 fd ff ff ba 01 00 00 00
>> 84 c0 75 09 5b 89 d0 5d
>> Mar 20 21:06:40 usbgentoo kernel: RSP: 0018:ffffb3ff4b0f4000 EFLAGS: 00010246
>> Mar 20 21:06:40 usbgentoo kernel: RAX: 0000000000000001 RBX:
>> ffffd57b5afeaa00 RCX: 0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: RDX: 0000000000000000 RSI:
>> ffffd57b5afeaa00 RDI: ffff9341f77f2000
>> Mar 20 21:06:40 usbgentoo kernel: RBP: ffff9341f77f2000 R08:
>> ffffb3ff4b0f4110 R09: ffff9340bfaa9377
>> Mar 20 21:06:40 usbgentoo kernel: R10: ffffb3ff4b0f41a0 R11:
>> 00000000fffffff3 R12: 000000000005c712
>> Mar 20 21:06:40 usbgentoo kernel: R13: 0000000000000000 R14:
>> 0000000000000001 R15: 0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: FS:  0000000000000000(0000)
>> GS:ffff9341fefc0000(0000) knlGS:0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Mar 20 21:06:40 usbgentoo kernel: CR2: ffffb3ff4b0f3ff8 CR3:
>> 000000006320e006 CR4: 00000000003606e0
>> Mar 20 21:06:40 usbgentoo kernel: DR0: 0000000000000000 DR1:
>> 0000000000000000 DR2: 0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: DR3: 0000000000000000 DR6:
>> 00000000fffe0ff0 DR7: 0000000000000400
>> Mar 20 21:06:40 usbgentoo kernel: kworker/u16:15 (1606) used greatest
>> stack depth: 8 bytes left
>> Mar 20 21:06:40 usbgentoo kernel: WARNING: CPU: 7 PID: 0 at
>> kernel/rcu/tree.c:600 rcu_idle_enter+0xe6/0xf0
>> Mar 20 21:06:40 usbgentoo kernel: Modules linked in: iTCO_wdt efivarfs
>> Mar 20 21:06:40 usbgentoo kernel: CPU: 7 PID: 0 Comm: swapper/7
>> Tainted: G      D           5.0.3-gentoo #6
>> Mar 20 21:06:40 usbgentoo kernel: Hardware name: To Be Filled By
>> O.E.M. To Be Filled By O.E.M./C226 WS, BIOS P3.40 06/25/2018
>> Mar 20 21:06:40 usbgentoo kernel: RIP: 0010:rcu_idle_enter+0xe6/0xf0
>> Mar 20 21:06:40 usbgentoo kernel: Code: 27 48 8b 45 00 48 8b 7d 08 48
>> 83 c5 18 31 c9 45 89 e8 ba 01 00 00 00 4c 89 e6 e8 45 40 d5 00 48 8b
>> 45 00 48 85 c0 75 dd eb 86 <0f> 0b e9 42 ff ff ff 0f 1f 00 41 57 41 56
>> 41 55 41 54 55 53 48 c7
>> Mar 20 21:06:40 usbgentoo kernel: RSP: 0018:ffffb3ff431dfec0 EFLAGS: 00010002
>> Mar 20 21:06:40 usbgentoo kernel: RAX: ffff9341fefe14c0 RBX:
>> 00000000000214c0 RCX: 0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: RDX: 4000000000000000 RSI:
>> 0000000000000348 RDI: ffff9341fefe8120
>> Mar 20 21:06:40 usbgentoo kernel: RBP: ffffffff8d592920 R08:
>> 000000000002bd5d R09: 0000000000039437
>> Mar 20 21:06:40 usbgentoo kernel: R10: ffff9341fefdf9e4 R11:
>> ffff9341fefdf9c4 R12: ffff9341fefe8120
>> Mar 20 21:06:40 usbgentoo kernel: R13: ffffffff8d4a8a20 R14:
>> 0000000000000004 R15: 0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: FS:  0000000000000000(0000)
>> GS:ffff9341fefc0000(0000) knlGS:0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Mar 20 21:06:40 usbgentoo kernel: CR2: ffffb3ff4b0f3ff8 CR3:
>> 000000006320e006 CR4: 00000000003606e0
>> Mar 20 21:06:40 usbgentoo kernel: DR0: 0000000000000000 DR1:
>> 0000000000000000 DR2: 0000000000000000
>> Mar 20 21:06:40 usbgentoo kernel: DR3: 0000000000000000 DR6:
>> 00000000fffe0ff0 DR7: 0000000000000400
>> Mar 20 21:06:40 usbgentoo kernel: Call Trace:
>> Mar 20 21:06:40 usbgentoo kernel:  do_idle+0x193/0x1e0
>> Mar 20 21:06:40 usbgentoo kernel:  cpu_startup_entry+0x14/0x20
>> Mar 20 21:06:40 usbgentoo kernel:  start_secondary+0x183/0x1b0
>> Mar 20 21:06:40 usbgentoo kernel:  secondary_startup_64+0xa4/0xb0
>> Mar 20 21:06:40 usbgentoo kernel: ---[ end trace 7d32682090ec782a ]---
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>> .
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
