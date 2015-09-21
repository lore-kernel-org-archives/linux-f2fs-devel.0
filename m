From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 1; 512GB partition;
 very slow + unfixable corruption
Date: Mon, 21 Sep 2015 10:17:48 +0200
Message-ID: <20150921081748.GA5637@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZdwIP-0005RC-0a
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 08:17:57 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZdwIM-0002e1-Qz
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 08:17:56 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZdwIG-0000Eb-Cr
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 08:17:48 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZdwIG-00062s-7w
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 08:17:48 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZdwIG-0001U2-7S
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 10:17:48 +0200
Content-Disposition: inline
In-Reply-To: <20150920235901.GA7017@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

On Mon, Sep 21, 2015 at 01:59:01AM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> Sorry that it took me so long, I am currently conducting initial tests, and
> will hopefully be able tpo report soon, for real this time.

Ok, here is my first test result. It's primarily concerned with GC and
near-full conditions, because that is fastest to test. The test was done
on a 4.2.0 kernel and current git f2fs tools.

Summary: not good - write performance went down to 20kb/s at the 10GB free
mark, sync took hours to complete, the filesystem was corrupt afterwards
and fsck failed to repair it.

I created a 512GB partition (-s 128 -o 1), mounted it
(-onoatime,inline_xattr,inline_data,flush_merge,extent_cache, note: no
inline_dentry) and started writing files to it (again, via rsync). Every
few minutes, a simple script deleted every 80th file, to create dirty
blocks. This test didn't test write performance, but it was adequate (the
filesystem kept up with it).

I paused rsync multiple times to check delete speed - the find -type f
command I used to generate the list was rather slow (it took multiple
minutes to list ~50000 files), which is not completely surprising, and
still manageable for me.

At around 50% utilization I paused the rsync and delete to see if there is
any gc or otherwise activity. Indeed, every 30 seconds or so there was a
~100mb read and write, and no other activity.

I continuted writing. At the 10GB free mark (df -h), write speed became
rather slow (~1MB/s), and a short time later (9.8GB) I paused rsync+delete
again. The "Dirty:" value was around 11000 at the time.

>From then on performance became rather abysmal - the speed went down to a
steady 20kb/s (sic!).

After a while I started "sync", which hung for almost 2 hours, during which
the disk was mostly written at ~20kb/s, with occasional faster writes
(~40-100mb/s) for a few seconds.

The faster write periods coincided mostly with activity in the "Balancing
F2FS Async" section of the status file.

Here is the status file from when the write speed became slow:

http://ue.tst.eu/12cf94978b9f47013f5f3b5712692ed5.txt

And here is the status file maybe half an hour later:

http://ue.tst.eu/144d36137371905a43d9a100f2f6b65c.txt

I can't really explain the abysmal speed - it doesn't happen with other
filesystems, so it's unlikely to be a hardware issue, but the only way I
can imagine how this speed could be explained is by f2fs scattering random
small writes all over the disk. The disk can do about 5-15 fully random
writes per second, but should be able to buffer >20GB of random writes before
this would happen.

The reason why I am so infatuated with disk full conditions is that it will
happen sooner or later, and while a slowdown to a 1MB/s might be ok when the
disk is nearly full, the filesystem absolutely must needs recover one there
is more free space and it had some time to reorganise.

Another issue is that in one of my applications (backup), I reserve 10GB
of space for transaction storage used only temporary, and the rest for
long term storage. With f2fs, it seems this has to be at least 25GB to
avoid the performance drop (which effectively takes down the disk for
hours). This is a bit painful for two reasons: 1) f2fs already sets aside
a lot of storage.  Even with the minimum amount of reserved space (1%),
this boils down to 80GB, a lot). In this test, only 5GB were reserved, but
performance dropped when df -h still showed 10GB of free space.

Now my observations on recovery after this condition:

After sync returned, I more or less regained control of the disk, and
started thinning out files again. This was rather slow at first (but the
disk was reading and writing 1-50mb/s - I assume the GC was at work).

After about 20 minutes, the utilization went down from 97% to 96%:

http://ue.tst.eu/74dd57f9b0fe2657a1518af71de0ce38.txt

At this point I noticed "find" spewing a large number of "No such file or
directory" messages for files.

The command I used to delete was:

   find /mnt -type f | awk '0 == NR % 80' | xargs -d\\n rm -v

And I don't see how find can ever complain about "No such file or
directory", even when there are concurrent deletes, because find should
not revisit the same file multiple times, so by the time it gets deleted,
find should be done with it.

At this point I stopped the find/rm - the disk then only showed large
reads and writes with a fgew second pauses between them. I then and ran
the find command manually, and fair enough, find gives thousands of "No such
file or directory" messages like these:

   find: `/mnt/ebook-export/eng/Pyrotools.txt': No such file or directory

And indeed, the filesysstem is completely corrupted at this point, with
lots of directory entries that cannot be stat'ed.

   root@shag:~# echo /mnt/ebook-export/eng/Pyrotools*
   /mnt/ebook-export/eng/Pyrotools.txt
   root@shag:~# ls -ld /mnt/ebook-export/eng/Pyrotools*
   ls: cannot access /mnt/ebook-export/eng/Pyrotools.txt: No such file or directory

Since you warned me about the inline_dentry/extent_cache options, I
will re-run this test tomorrow with noinline_dentry,noextent_cache (not
documented, if they even exist - but inline_dentry seems to be on by
default?).

For completeness, I ran fsck.f2fs, which gave me a lot of these:

   [ASSERT] (fsck_chk_inode_blk: 525)  --> ino: 0xc4e9 has i_blocks: 0000009e, but has 1 blocks
   [ASSERT] (fsck_chk_inode_blk: 391)  --> [0xc79a] needs more i_links=0x1
   [ASSERT] (fsck_chk_inode_blk: 525)  --> ino: 0xc79a has i_blocks: 0000005c, but has 1 blocks
   [ASSERT] (fsck_chk_inode_blk: 391)  --> [0xc845] needs more i_links=0x1
   [ASSERT] (fsck_chk_inode_blk: 525)  --> ino: 0xc845 has i_blocks: 000002d5, but has 1 blocks
   [ASSERT] (sanity_check_nid: 261)  --> Duplicated node blk. nid[0x34fa5][0x7fe07b3]

   [ASSERT] (fsck_chk_inode_blk: 391)  --> [0xccdc] needs more i_links=0x1
   [ASSERT] (fsck_chk_inode_blk: 525)  --> ino: 0xccdc has i_blocks: 00000063, but has 1 blocks
   [ASSERT] (fsck_chk_inode_blk: 391)  --> [0xcebc] needs more i_links=0x1
   [ASSERT] (fsck_chk_inode_blk: 525)  --> ino: 0xcebc has i_blocks: 000000b0, but has 1 blocks
   [ASSERT] (fsck_chk_inode_blk: 391)  --> [0xcf12] needs more i_links=0x1
   [ASSERT] (fsck_chk_inode_blk: 525)  --> ino: 0xcf12 has i_blocks: 00001b18, but has 1 blocks

I then tried fsck.f2fs -a, which completed without much output, almost
instantly (what does it do?). I then tried fsck.f2fs -f, which seemed to
do something:

   [ASSERT] (fsck_chk_inode_blk: 391)  --> [0x5c524] needs more i_links=0x1
   [FIX] (fsck_chk_inode_blk: 398)  --> File: 0x5c524 i_links= 0x1 -> 0x2
   [ASSERT] (fsck_chk_inode_blk: 525)  --> ino: 0x5c524 has i_blocks: 00000019, but has 1 blocks
   [FIX] (fsck_chk_inode_blk: 530)  --> [0x5c524] i_blocks=0x00000019 -> 0x1
   [ASSERT] (fsck_chk_inode_blk: 391)  --> [0x671ba] needs more i_links=0x1
   [FIX] (fsck_chk_inode_blk: 398)  --> File: 0x671ba i_links= 0x1 -> 0x2

   ...

   [FIX] (fsck_chk_inode_blk: 530)  --> [0x1a7bf] i_blocks=0x000000ca -> 0x1
   [ASSERT] (IS_VALID_BLK_ADDR: 344)  --> block addr [0x0]

   [ASSERT] (sanity_check_nid: 212)  --> blkaddres is not valid. [0x0]
   [FIX] (__chk_dentries: 779)  --> Unlink [0x1a7d8] - E B Jones.epub len[0x33], type[0x1]
   [ASSERT] (IS_VALID_BLK_ADDR: 344)  --> block addr [0x0]

   ...

   NID[0x679e2] is unreachable
   NID[0x679e3] is unreachable
   NID[0x6bc52] is unreachable
   NID[0x6bc53] is unreachable
   NID[0x6bc54] is unreachable
   [FSCK] Unreachable nat entries                        [Fail] [0x2727]
   [FSCK] SIT valid block bitmap checking                [Fail]
   [FSCK] Hard link checking for regular file            [Ok..] [0x0]
   [FSCK] valid_block_count matching with CP             [Fail] [0x6a6bc8a]
   [FSCK] valid_node_count matcing with CP (de lookup)   [Fail] [0x6808d]
   [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x6a7b4]
   [FSCK] valid_inode_count matched with CP              [Fail] [0x55bb8]
   [FSCK] free segment_count matched with CP             [Ok..] [0x8f5d]
   [FSCK] next block offset is free                      [Ok..]
   [FSCK] fixing SIT types
   [FIX] (check_sit_types:1056)  --> Wrong segment type [0x3fc6a] 3 -> 4
   [FIX] (check_sit_types:1056)  --> Wrong segment type [0x3fc6b] 3 -> 4
   [FSCK] other corrupted bugs                           [Fail]

Doesn't look good to me, however, the filesystem was mountable without
error afterwards, but find showed similar errors, so fsck.f2fs did not
result in a working filesystem either.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
