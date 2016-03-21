From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
Date: Mon, 21 Mar 2016 11:18:35 +0800
Message-ID: <00d401d18320$75f94e80$61ebeb80$@samsung.com>
References: <56EEC766.2030503@davizone.at>
	<20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ahqNP-0003Av-7y
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 03:19:31 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ahqNN-0002HN-6H
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 03:19:31 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O4D02933D80P860@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 12:19:21 +0900 (KST)
In-reply-to: <20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'David Gnedt' <david.gnedt@davizone.at>, 'Matthias Prager' <linux@matthiasprager.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi all,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Monday, March 21, 2016 6:47 AM
> To: David Gnedt
> Cc: Chao Yu
> Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
> 
> Hello,
> 
> As you pointed out, it seems there is a bug in sanity check routine, which
> doesn't cover the large section case.

Actually, there is a bug in f2fs-tools 1.6.0, it will trigger sanity check failure
in f2fs kernel module since in mkfs.f2fs we will align segment_count and
segment_count_main with different size if parameter -s or -z is configured larger
than 1.

Following commit in dev branch of f2fs-tools has fixed this issue, could you test this
patch firstly?
("mkfs.f2fs: set segment_count in super block correctly")

Thanks,

> 
> Could you test the attached patch?
> 
> Thanks,
> 
> On Sun, Mar 20, 2016 at 04:53:10PM +0100, David Gnedt wrote:
> > Hello,
> >
> > I have a problem with mounting a very big f2fs volume (8TB Seagate SMR drive) in
> > kernel 4.5. It works without any problems in 4.4.6, but with 4.5 I get errors
> > during mount (see attached file smr_log.txt).
> >
> > I have created the volume with f2fs-tools 1.6.0 and also a fsck works without
> > any problems (see attached file smr_fsck.txt).
> >
> > I suspect the following commit to be the cause:
> >
> > commit 9a59b62fd88196844cee5fff851bee2cfd7afb6e
> > f2fs: do more integrity verification for superblock
> >
> >
> https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/fs/f2fs/super.c?id=9a
> 59b62fd88196844cee5fff851bee2cfd7afb6e
> >
> > I haven't had time to dig deeper, but my guess is that the volume is too big, so
> > that the 32bit integers overflow during the new check routine
> > sanity_check_area_boundary().
> >
> > Please let me know, if you need any more information. F2fs is currently the only
> > filesystem that really works on those SMR drives, therefore it is an important
> > issue to me.
> >
> > Best regards,
> > David Gnedt
> 
> > [437136.843299] F2FS-fs (dm-7): Wrong MAIN_AREA boundary, start(4063232) end(1953505792)
> blocks(1949433856)
> > [437136.843302] F2FS-fs (dm-7): Can't find valid F2FS filesystem in 1th superblock
> > [437136.843418] F2FS-fs (dm-7): Wrong MAIN_AREA boundary, start(4063232) end(1953505792)
> blocks(1949433856)
> > [437136.843419] F2FS-fs (dm-7): Can't find valid F2FS filesystem in 2th superblock
> > [437136.843420] F2FS-fs (dm-7): Wrong MAIN_AREA boundary, start(4063232) end(1953505792)
> blocks(1949433856)
> > [437136.843421] F2FS-fs (dm-7): Can't find valid F2FS filesystem in 1th superblock
> > [437136.843422] F2FS-fs (dm-7): Wrong MAIN_AREA boundary, start(4063232) end(1953505792)
> blocks(1949433856)
> > [437136.843422] F2FS-fs (dm-7): Can't find valid F2FS filesystem in 2th superblock
> 
> > Info: sector size = 512
> > Info: total sectors = 15628046336 (7630882 MB)
> > Info: MKFS version
> >   "Linux version 4.4.0-040400-generic (kernel@gomeisa) (gcc version 5.2.1 20151010 (Ubuntu
> 5.2.1-22ubuntu2) ) #201601101930 SMP Mon Jan 11 00:32:41 UTC 2016"
> > Info: FSCK version
> >   from "Linux version 4.4.0-040400-generic (kernel@gomeisa) (gcc version 5.2.1 20151010
> (Ubuntu 5.2.1-22ubuntu2) ) #201601101930 SMP Mon Jan 11 00:32:41 UTC 2016"
> >     to "Linux version 4.5.0-040500-generic (kernel@tangerine) (gcc version 5.2.1 20151010
> (Ubuntu 5.2.1-22ubuntu2) ) #201603140130 SMP Mon Mar 14 05:32:22 UTC 2016"
> > Info: superblock features = 0 :
> > Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> > Info: total FS sectors = 15628046336 (7630882 MB)
> > Info: CKPT version = 122a
> > Info: checkpoint state = 1 :  unmount
> >
> > [FSCK] Unreachable nat entries                        [Ok..] [0x0]
> > [FSCK] SIT valid block bitmap checking                [Ok..]
> > [FSCK] Hard link checking for regular file            [Ok..] [0x0]
> > [FSCK] valid_block_count matching with CP             [Ok..] [0x57cea239]
> > [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x61b3bd]
> > [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x61b3bd]
> > [FSCK] valid_inode_count matched with CP              [Ok..] [0x4c0a61]
> > [FSCK] free segment_count matched with CP             [Ok..] [0xe31ac]
> > [FSCK] next block offset is free                      [Ok..]
> > [FSCK] fixing SIT types
> > [FSCK] other corrupted bugs                           [Ok..]
> >
> > Done.



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
