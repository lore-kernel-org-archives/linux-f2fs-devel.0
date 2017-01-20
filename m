From: KARBOWSKI Piotr <piotr.karbowski@gmail.com>
Subject: Re: f2fs corruption due to f2fs_gc crash.
Date: Fri, 20 Jan 2017 07:05:44 +0100
Message-ID: <d229c9e2-1b33-57f2-04fb-c63277ca862a@gmail.com>
References: <ae02335a-e8ac-9891-5ebe-015315250899@gmail.com>
	<20170119234300.GB42028@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <piotr.karbowski@gmail.com>) id 1cUSKg-0003Y5-2T
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Jan 2017 06:05:54 +0000
Received: from mail-wm0-f45.google.com ([74.125.82.45])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cUSKf-0003qv-6i
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Jan 2017 06:05:54 +0000
Received: by mail-wm0-f45.google.com with SMTP id r126so23695552wmr.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 19 Jan 2017 22:05:53 -0800 (PST)
In-Reply-To: <20170119234300.GB42028@jaegeuk.local>
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

Hi,

On 01/20/2017 12:43 AM, Jaegeuk Kim wrote:
> If possible, could you share the fsck log whether it repaired something?
> That message is caused by wrong summary type, which is able to be fixed by
> fsck.

Yes, of course. Please find the log below.

+ fsck.f2fs -a /dev/mapper/sd_stash
Info: Fix the reported corruption.
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 384497664 (187743 MB)
Info: MKFS version
   "Linux version 4.8.9-frontier1 (root@kurogane) (gcc version 5.4.0 
(Gentoo 5.4.0 p1.0, pie-0.6.5) ) #5 SMP Mon Dec 19 16:57:47 CET 2016"
Info: FSCK version
   from "Linux version 4.9.4 (root@kurogane) (gcc version 5.4.0 (Gentoo 
5.4.0-r2 p1.2, pie-0.6.5) ) #1 SMP Wed Jan 18 23:38:00 CET 2017"
     to "Linux version 4.9.4 (root@kurogane) (gcc version 5.4.0 (Gentoo 
5.4.0-r2 p1.2, pie-0.6.5) ) #1 SMP Wed Jan 18 23:38:00 CET 2017"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 384497664 (187743 MB)
Info: CKPT version = dac
Info: checkpoint state = 51 :  fsck unmount

[FSCK] Unreachable nat entries                        [Ok..] [0x0]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x7]
[FSCK] valid_block_count matching with CP             [Ok..] [0x1f34b71]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x9aef]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x9aef]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x1260]
[FSCK] free segment_count matched with CP             [Ok..] [0x73d3]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Ok..]

Done.
+ mount LABEL=sd_stash

-- Piotr.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
