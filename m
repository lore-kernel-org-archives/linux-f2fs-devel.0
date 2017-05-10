From: Raouf Rokhjavan <rokhjavan.r@gmail.com>
Subject: Re: f2fs Crash Consistency Problem
Date: Wed, 10 May 2017 22:21:00 +0430
Message-ID: <bfeb7627-cd9c-6074-1655-38e87166a30b@gmail.com>
References: <d5ab8383-25f3-ffd6-c506-20993348c499@gmail.com>
	<20170413211935.GA3826@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rokhjavan.r@gmail.com>) id 1d8Vlb-0005wa-97
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 17:51:15 +0000
Received: from mail-wm0-f68.google.com ([74.125.82.68])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d8VlX-0005je-9B
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 17:51:15 +0000
Received: by mail-wm0-f68.google.com with SMTP id y10so1426494wmh.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 10 May 2017 10:51:11 -0700 (PDT)
In-Reply-To: <20170413211935.GA3826@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net



On 04/14/17 01:49, Jaegeuk Kim wrote:
> Hello,
>
> On 04/13, Raouf Rokhjavan wrote:
>> Hi
>>
>> The Flash friendly features of f2fs has motivated me to make use of
>> these characteristics as rootfs in my project. Since one of my main
>> considerations is the resilience in the face of power failure, I've been
>> looking for some techniques to prove this assertion. Finally, I ended up
>> finding a wonderful device-mapper target, developed by Josef Bacik who
>> is btrfs developer, for this purpose..
>>
>> As you know, log-writes target logs all bios which are passed to the
>> block layer and keeps the order of logging to simulate the file system
>> logic of maintaining the consistency. To take advantage of this helpful
>> tool to verify the consistency of f2fs file system after power failure,
>> I combined xfstests test suite with log-writes. According to the LFS
>> based nature of f2fs, I expected that I would never encounter with
>> inconsistency problem, but test results shows something else.
>>
>> To clarify further this notion, this is my test environment:
>>
>>       - Fedora 24
>>
>>       - kernel 4.9.8 - f2fs was compiled as module which all features
>>
>>           - mount options: default + noatime
>>
>>       - f2fs-tools 1.8.0
>>
>>       - xfstests  1.1.1 - from https://github.com/jaegeuk/xfstests-f2fs
>>
>>       - device-mapper 1.02.122
>>
>> In my test environment, I run each generic test of xfstests on
>> log-writes device with newly created f2fs. After that, I replay the log
>> after the mkfs one by one and check the consistency of file system with
>> fsck.f2fs. In test #009 which is fallocate test with
>> FALLOC_FL_ZERO_RANGE mode, after a while, fsck.f2fs complains this:
> I just ran log-writer with fsstress and found one issue when replaying IOs.
> If you replay after mkfs.f2fs, you get the wrong valid checkpoint which was
> overwritten by previous run. IOWs, at the beginning of replay, there was
> no *correct* checkpoint representing that initial moment. So, I think you
> need to replay the log including mkfs.
>
> You can verify the below CKPT version info.
>
>> Info: [/dev/sdc] Disk Model: VMware Virtual S1.0
>> Info: Segments per section = 1
>> Info: Sections per zone = 1
>> Info: sector size = 512
>> Info: total sectors = 2097152 (1024 MB)
>> Info: MKFS version
>>     "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version
>> 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST
>> 2017"
>> Info: FSCK version
>>     from "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version
>> 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST
>> 2017"
>>       to "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version
>> 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST
>> 2017"
>> Info: superblock features = 0 :
>> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
>> Info: total FS sectors = 2097152 (1024 MB)
>> Info: CKPT version = 2a4679e0
>> Info: checkpoint state = 45 :  compacted_summary unmount
>>
>> NID[0x4c] is unreachable
>> NID[0x4d] is unreachable
>> [FSCK] Unreachable nat entries                        [Fail] [0x2]
>> [FSCK] SIT valid block bitmap checking                [Ok..]
>> [FSCK] Hard link checking for regular file            [Ok..] [0x0]
>> [FSCK] valid_block_count matching with CP             [Ok..] [0x2]
>> [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x1]
>> [FSCK] valid_node_count matcing with CP (nat lookup)  [Fail] [0x3]
>> [FSCK] valid_inode_count matched with CP              [Ok..] [0x1]
>> [FSCK] free segment_count matched with CP             [Ok..] [0x1f0]
>> [FSCK] next block offset is free                      [Ok..]
>> [FSCK] fixing SIT types
>> [FSCK] other corrupted bugs                           [Fail]
>>
>> Do you want to restore lost files into ./lost_found/? [Y/N] Y
>>    - File name         : 009.48244.2
>>    - File size         : 20,480 (bytes)
>> Do you want to fix this partition? [Y/N] Y
>>
>> The interesting side of this is that when I issue fsck.f2fs with -p
>> option, fsck.f2fs doesn't complain !!!
>>
>> Would you please tell me why fsck.f2fs reports an inconsistency which
>> needs to be fixed? Does it violate the crash consistency promise of f2fs?
> As I mentioned above, I guess you did with "--start-mark mkfs" which will lose
> the initial checkpoint.
>
>> Moreover, Why is fsck.f2fs silent with -p option? Does it mean whether
>> f2fs kernel module finds it not serious?
> The -p [level] and default level is zero, which checks the image iif runtime
> f2fs reported any bug case before. Otherwise, it simply returns. If you set
> level 1, fsck.f2fs will check basic FS metadata parts.
>
> Thanks,
>
>> I really appreciate for your help.
>>
>> Thanks
>>
Hello,

As you told to use snapshot mechanism to prevent changing ckpt number 
after each mount, I ran again generic tests of xfstests framework on top 
of log-writes target with f2fs file system. In order to automate 
reporting an inconsistency situation, I add a parameter to fsck.f2fs to 
return(-1) when c.bug_on condition is met. To evaluate how f2fs react in 
case of crash consistency, I replay each log and check the consistency 
of f2fs with a my own modified version of fsck.f2fs.  Accordingly, all 
tests passed smoothly except these tests:

[FAIL] Running generic/013 failed. (consistency_single)
[FAIL] Running generic/070 failed. (consistency_single)
[FAIL] Running generic/113 failed. (consistency_single)
[FAIL] Running generic/241 failed. (consistency_single)

In other words, in these tests, c.bug_on() was true. Would you please 
describe why they become inconsistent?

Besides, I ran sysbench for database benchmark with 1 thread, 1000 
records, and 100 transactions on top of log-writes target with f2fs. 
Interestingly, I encountered a weird inconsistency. After replaying 
about 100 logs, fsck.f2fs complains about inconsistency with the 
following messages:

Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 2097152 (1024 MB)
Info: MKFS version
   "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 
4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 
2017"
Info: FSCK version
   from "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 
4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 
2017"
     to "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 
4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 
2017"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 2097152 (1024 MB)
Info: CKPT version = 2b59c128
Info: checkpoint state = 44 :  compacted_summary sudden-power-off
[ASSERT] (sanity_check_nid: 388)  --> nid[0x6] nat_entry->ino[0x6] 
footer.ino[0x0]

NID[0x6] is unreachable
NID[0x7] is unreachable
[FSCK] Unreachable nat entries                        [Fail] [0x2]
[FSCK] SIT valid block bitmap checking                [Fail]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Fail] [0x6dc9]
[FSCK] valid_node_count matcing with CP (de lookup)   [Fail] [0xe3]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0xe5]
[FSCK] valid_inode_count matched with CP              [Fail] [0x63]
[FSCK] free segment_count matched with CP             [Ok..] [0x1c6]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Fail]

After canceling the test by using Ctrl-C without answering any YES/NO 
questions, on another terminal I run fsck.f2fs again, but the output is 
completely different:
[root@localhost CrashConsistencyTest]# ./locals/usr/local/sbin/fsck.f2fs 
/dev/sdc
Info: [/dev/sdc] Disk Model: VMware Virtual S1.0
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 2097152 (1024 MB)
Info: MKFS version
   "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 
4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 
2017"
Info: FSCK version
   from "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 
4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 
2017"
     to "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 
4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 
2017"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 2097152 (1024 MB)
Info: CKPT version = 2b59c128
Info: checkpoint state = 44 :  compacted_summary sudden-power-off

[FSCK] Unreachable nat entries                        [Ok..] [0x0]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Ok..] [0x6dcf]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0xe5]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0xe5]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x64]
[FSCK] free segment_count matched with CP             [Ok..] [0x1c6]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Ok..]

This situation raises a couple of questions:
1. How  does an inconsistent file system turn into a consistent one in 
this case?
2. Why does an inconsistency occur in different log numbers; in other 
words, why is it unpredictable?  Does ordering of logs have to do with 
disk controller and I/O scheduler?

I do appreciate for your help.
Regards

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
