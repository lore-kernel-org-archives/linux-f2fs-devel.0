From: Max Muster <tastky@gmail.com>
Subject: [Bug] Inaccessible, unerasable file
Date: Sat, 19 Oct 2013 19:36:31 +0200
Message-ID: <CAPs1ukwgeqL1SFUGUPaM-aE=88dXS4GeaDDALG5WFLcoMvqg_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tastky@gmail.com>) id 1VXaS7-0006RC-F1
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Oct 2013 17:36:39 +0000
Received: from mail-la0-f66.google.com ([209.85.215.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VXaS6-0006kT-LY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Oct 2013 17:36:39 +0000
Received: by mail-la0-f66.google.com with SMTP id er20so484179lab.5
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 19 Oct 2013 10:36:32 -0700 (PDT)
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

There's a broken, ie. inaccessible and unerasable file on my f2fs
partition (2nd partition with 21GB on a Corsair Flash Voyager GT USB 3.0
32GB). ls reports:

 >cannot access shared.h: Input/output error
 >total 0
 >-????????? ? ? ? ?            ? shared.h

The file has been on the partition for a couple of months already. I
didn't report sooner as I could/can move its folder (but not the file
itself) where it doesn't bug me and it doesn't appear to affect anything
else.

(I'm currently running Linux v3.12-rc5 with post-3.12 f2fs patches
applied manually.)

The partition is used primarily to store source code and as cache for
ccache. I don't recall ever fiddling with this file directly; it
probably happened during updating its repository or deleting just that.

f2fs-tools's fsck (current git 2ad1fcd800) doesn't appear to do anything
and aborts after some 30 seconds with:

 >Info: sector size = 512
 >Info: total sectors = 42106880 (in 512bytes)
 >[fsck_chk_node_blk: 195] block addr [0xa40ae59]
 >
 >Assertion failed!
 >[fsck_chk_node_blk: 195] ni.blk_addr < F2FS_RAW_SUPER(sbi)->block_count

If you would like me to post further info, please tell me which; I've
got no idea how to further debug this.

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
