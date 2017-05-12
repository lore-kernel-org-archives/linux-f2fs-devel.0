From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs Crash Consistency Problem
Date: Thu, 11 May 2017 17:14:31 -0700
Message-ID: <20170512001431.GA9575@jaegeuk.local>
References: <d5ab8383-25f3-ffd6-c506-20993348c499@gmail.com>
	<20170413211935.GA3826@jaegeuk.local>
	<bfeb7627-cd9c-6074-1655-38e87166a30b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d8yEA-0004rg-JB
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 May 2017 00:14:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d8yE9-0001xS-Ho
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 May 2017 00:14:38 +0000
Content-Disposition: inline
In-Reply-To: <bfeb7627-cd9c-6074-1655-38e87166a30b@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Raouf Rokhjavan <rokhjavan.r@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On 05/10, Raouf Rokhjavan wrote:
...

> As you told to use snapshot mechanism to prevent changing ckpt number after
> each mount, I ran again generic tests of xfstests framework on top of
> log-writes target with f2fs file system. In order to automate reporting an
> inconsistency situation, I add a parameter to fsck.f2fs to return(-1) when
> c.bug_on condition is met. To evaluate how f2fs react in case of crash
> consistency, I replay each log and check the consistency of f2fs with a my
> own modified version of fsck.f2fs.  Accordingly, all tests passed smoothly
> except these tests:
> 
> [FAIL] Running generic/013 failed. (consistency_single)

Could you check whether any IO made by mkfs was added in the replay log?
If so, fsck.f2fs should be failed when replaying them.

> [FAIL] Running generic/070 failed. (consistency_single)
> [FAIL] Running generic/113 failed. (consistency_single)

I added a mark to replay in the beginning of generic/113, and ran the test.
But, I couldn't find any error given test_dev as a log_dev. (I tested this
in the latest f2fs/dev-test branch.)

> [FAIL] Running generic/241 failed. (consistency_single)
> 
> In other words, in these tests, c.bug_on() was true. Would you please
> describe why they become inconsistent?
> 
> Besides, I ran sysbench for database benchmark with 1 thread, 1000 records,
> and 100 transactions on top of log-writes target with f2fs. Interestingly, I
> encountered a weird inconsistency. After replaying about 100 logs, fsck.f2fs
> complains about inconsistency with the following messages:

Can you share the parameter for sysbench?

Thanks,

> 
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 512
> Info: total sectors = 2097152 (1024 MB)
> Info: MKFS version
>   "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 4.8.5
> 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 2017"
> Info: FSCK version
>   from "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version
> 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST
> 2017"
>     to "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version
> 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST
> 2017"
> Info: superblock features = 0 :
> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> Info: total FS sectors = 2097152 (1024 MB)
> Info: CKPT version = 2b59c128
> Info: checkpoint state = 44 :  compacted_summary sudden-power-off
> [ASSERT] (sanity_check_nid: 388)  --> nid[0x6] nat_entry->ino[0x6]
> footer.ino[0x0]
> 
> NID[0x6] is unreachable
> NID[0x7] is unreachable
> [FSCK] Unreachable nat entries                        [Fail] [0x2]
> [FSCK] SIT valid block bitmap checking                [Fail]
> [FSCK] Hard link checking for regular file            [Ok..] [0x0]
> [FSCK] valid_block_count matching with CP             [Fail] [0x6dc9]
> [FSCK] valid_node_count matcing with CP (de lookup)   [Fail] [0xe3]
> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0xe5]
> [FSCK] valid_inode_count matched with CP              [Fail] [0x63]
> [FSCK] free segment_count matched with CP             [Ok..] [0x1c6]
> [FSCK] next block offset is free                      [Ok..]
> [FSCK] fixing SIT types
> [FSCK] other corrupted bugs                           [Fail]
> 
> After canceling the test by using Ctrl-C without answering any YES/NO
> questions, on another terminal I run fsck.f2fs again, but the output is
> completely different:
> [root@localhost CrashConsistencyTest]# ./locals/usr/local/sbin/fsck.f2fs
> /dev/sdc
> Info: [/dev/sdc] Disk Model: VMware Virtual S1.0
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 512
> Info: total sectors = 2097152 (1024 MB)
> Info: MKFS version
>   "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 4.8.5
> 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 2017"
> Info: FSCK version
>   from "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version
> 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST
> 2017"
>     to "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version
> 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST
> 2017"
> Info: superblock features = 0 :
> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> Info: total FS sectors = 2097152 (1024 MB)
> Info: CKPT version = 2b59c128
> Info: checkpoint state = 44 :  compacted_summary sudden-power-off
> 
> [FSCK] Unreachable nat entries                        [Ok..] [0x0]
> [FSCK] SIT valid block bitmap checking                [Ok..]
> [FSCK] Hard link checking for regular file            [Ok..] [0x0]
> [FSCK] valid_block_count matching with CP             [Ok..] [0x6dcf]
> [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0xe5]
> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0xe5]
> [FSCK] valid_inode_count matched with CP              [Ok..] [0x64]
> [FSCK] free segment_count matched with CP             [Ok..] [0x1c6]
> [FSCK] next block offset is free                      [Ok..]
> [FSCK] fixing SIT types
> [FSCK] other corrupted bugs                           [Ok..]
> 
> This situation raises a couple of questions:
> 1. How  does an inconsistent file system turn into a consistent one in this
> case?
> 2. Why does an inconsistency occur in different log numbers; in other words,
> why is it unpredictable?  Does ordering of logs have to do with disk
> controller and I/O scheduler?
> 
> I do appreciate for your help.
> Regards

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
