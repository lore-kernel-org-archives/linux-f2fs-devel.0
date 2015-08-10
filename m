From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: f2fs for SMR drives
Date: Mon, 10 Aug 2015 18:20:40 +0800
Message-ID: <003d01d0d356$4d5b9480$e812bd80$@samsung.com>
References: <20150808135117.GA4594@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZOkDD-0005ct-AD
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Aug 2015 10:21:47 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZOkDA-00035y-Fw
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Aug 2015 10:21:47 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NSV00A443FM5M40@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Aug 2015 19:21:25 +0900 (KST)
In-reply-to: <20150808135117.GA4594@schmorp.de>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Marc Lehmann' <schmorp@schmorp.de>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Marc,

> -----Original Message-----
> From: Marc Lehmann [mailto:schmorp@schmorp.de]
> Sent: Saturday, August 08, 2015 9:51 PM
> To: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] f2fs for SMR drives
> 
> Hi!
> 
> Sorry if this is the wrong address to ask about "user problems".
> 
> I am currently investigating various filesystems for use on drive-managed SMR
> drives (e.g. the seagate 8TB disks). These drives have characteristics not
> unlike flash (they want to be written in large batches), but are, of course,
> still quite different.
> 
> I initially tried btrfs, ext4, xfs which, not unsurprisingly, failed rather
> miserably after a few hundred GB, down to ~30mb/s (or 20 in case of btrfs).
> 
> I also tried nilfs, which should be an almost perfect match for this
> technology, but it performed even worse (I have no clue why, maybe nilfs
> skips sectors when writing, which would explain it).
> 
> As a last resort, I tried f2fs, which initially performed absolutely great
> (average write speed ~130mb/s over multiple terabytes).
> 
> However, I am running into a number of problems, and wonder if f2fs can
> somehow be configured to work right.
> 
> First of all, I did most of my tests on linux-3.18.14, and recently
> switched to 4.1.4. The filesystems were formatted with "-s7", the idea

'-s7' means that we configure seg_per_sec into 7, so our section size will
be 7 * 2M (segment size) = 14M, so no matter how we configure '-z' (section
number per zone), our allocation unit will not alignment to 256MB, so both
allocation and release unit in f2fs may across zone boundary in SMR driver,
which may cause low performance, is that right?

> being that writes always occur in 256MB blocks as much as possible, and
> most importantly, are freed in 256MB blocks, to keep fragmentation low.
> 
> Mount options included noatime or
> noatime,inline_xattr,inline_data,inline_dentry,flush_merge,extent_cache
> (I suspect 4.1.4 doesn't implement flush_merge yet?).
> 
> My first problem considers ENOSPC problem - I was happily able to write to a
> 100% utilized filesystem with cp and rsync continuing to write, not receiving
> any error, but no write activity occuring (and the files never ending up on
> the filesystem). Is this a known bug?

I have no SMR device, so I have to use hard disk for testing, I can't reproduce
this issue with cp in such device. But for rsync, one thing I note is that:

I use rsync to copy 32g local file to f2fs partition, the partition is with
100% utilized space and with no available block for further allocation. It
took very long time for 'the copy', finally it reported us there is no space.

I did same test with ext4 filesystem, it toke very short time to report us
ENOSPC.

As I investigate, the main flow of copy used by rsync is:
1. open src file
2. create tmp file in dst partition
3. copy data from src file to tmp file
4. rename tmp file to dst

a) In ext4, we reserve space separately for data block and inode, if data
block resource is exhausted (it makes df showing utilization as 100%), in
this partition, we can't write new data, but we can still create file as
creating only grab inode space in ext4, not block space. So this makes rsync
failing in step 3, and return error immediately.
b) In f2fs, we use inode/data block space mixedly, so when data block number
is zero, we can't create any file in f2fs. It makes rsync failing in step 2,
and leads it runs into discard_receive_data function which will still
receiving the whole src file. This makes rsync process keeping writing but
generating no IO in f2fs filesystem.

Fininally, I make one block space in f2fs by removing one file, this makes
f2fs passing step 2 and return error immediately in step 3 like ext4.

Can you please help to check that in your environment the reason of rsync
without returning ENOSPC is the same as above?

If it is not, can you share more details about test steps, io info, and f2fs
status info in debugfs (/sys/kernel/debug/f2fs/status).

> 
> My second, much bigger problem, considers defragmentation. For testing,
> I created a 128GB partition and kept writing an assortment of 200kb -
> multiple megabyte files to it. To stress test it, I kept deleting random
> files to create holes. after a while (around 84% utilisation), write
> performance went down to less than 1MB/s, and is at this leve ever since
> for this filesystem.

IMO, real-timely increasing ratio of below stat value may be helpful to
investigate the degression issue. Can you share us them?

CP calls: 
GC calls: (BG:)
  - data segments : 
  - node segments : 
Try to move blocks (BG:)
  - data blocks :
  - node blocks :
IPU: blocks
SSR: blocks in  segments
LFS: blocks in  segments

Thanks,

> 
> I kept the filesystem idle for a night to hope for defragmentation, but
> nothing happened. Suspecting in-place-updates to be the culprit, I tried
> various configurations in the hope of disabling them (such as setting
> ipu_policy to 4 or 8, and/or setting min_ipu_util to 0 or 100), but that
> also doesn't seem to have any effect whatsoever.
> 
> >From the description of f2fs, it seems to be quite close to ideal for these
> drives, as it should be possible to write mostly linearly, and keep
> fragmentation low by freeing big sequentials sections of data.
> 
> Pity that it's so close and then fails so miserably after performing so
> admirably initially - can anything be done about this, in way of
> configuration, or is my understanding of how f2fs writes and garbage collects
> flawed?
> 
> Here is the output of /sys/kernel/debug/f2fs/status for the filesysstem in
> question. This was after keeping it idle for a night, then unmounting and
> remounting the volume. Before the unmount, it had very high values for in
> the GC calls section, but no reads have been observed during the night,
> just writes (using dstat -Dsdx).
> 
>    =====[ partition info(dm-9). #1 ]=====
>    [SB: 1] [CP: 2] [SIT: 6] [NAT: 114] [SSA: 130] [MAIN: 65275(OverProv:2094 Resv:1456)]
> 
>    Utilization: 84% (27320244 valid blocks)
>      - Node: 31936 (Inode: 5027, Other: 26909)
>      - Data: 27288308
>      - Inline_data Inode: 0
>      - Inline_dentry Inode: 0
> 
>    Main area: 65275 segs, 9325 secs 9325 zones
>      - COLD  data: 12063, 1723, 1723
>      - WARM  data: 12075, 1725, 1725
>      - HOT   data: 65249, 9321, 9321
>      - Dir   dnode: 65269, 9324, 9324
>      - File   dnode: 24455, 3493, 3493
>      - Indir nodes: 65260, 9322, 9322
> 
>      - Valid: 52278
>      - Dirty: 9
>      - Prefree: 0
>      - Free: 12988 (126)
> 
>    CP calls: 10843
>    GC calls: 91 (BG: 11)
>      - data segments : 21 (0)
>      - node segments : 70 (0)
>    Try to move 30355 blocks (BG: 0)
>      - data blocks : 7360 (0)
>      - node blocks : 22995 (0)
> 
>    Extent Hit Ratio: 8267 / 24892
> 
>    Extent Tree Count: 3130
> 
>    Extent Node Count: 3138
> 
>    Balancing F2FS Async:
>      - inmem:    0, wb:    0
>      - nodes:    0 in 5672
>      - dents:    0 in dirs:   0
>      - meta:    0 in 3567
>      - NATs:         0/     9757
>      - SITs:         0/    65275
>      - free_nids:       868
> 
>    Distribution of User Blocks: [ valid | invalid | free ]
>      [------------------------------------------||--------]
> 
>    IPU: 0 blocks
>    SSR: 0 blocks in 0 segments
>    LFS: 49114 blocks in 95 segments
> 
>    BDF: 64, avg. vblocks: 1254
> 
>    Memory: 48948 KB
>      - static: 11373 KB
>      - cached: 619 KB
>      - paged : 36956 KB
> 
> --
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
