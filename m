From: JP Abgrall <jpa@google.com>
Subject: [fsck.f2fs] Not seeing the main bitmap getting written
	back out?
Date: Thu, 13 Nov 2014 12:05:49 -0800
Message-ID: <CAKP4w2Q6p1HAAhAB521=_=7p0Kf_rGNEmSKyoEGWtePD1rmhyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jpa@google.com>) id 1Xp0em-0004OY-Ml
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Nov 2014 20:06:16 +0000
Received: from mail-qa0-f46.google.com ([209.85.216.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Xp0el-00032z-TJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Nov 2014 20:06:16 +0000
Received: by mail-qa0-f46.google.com with SMTP id n8so10534894qaq.5
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 13 Nov 2014 12:06:10 -0800 (PST)
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

With a top-of-tree master f2fs-tools.

232ce7671ea505dfbb9f0ca7be74516ca9687a7b tries to fix the wrong segment types.

Running fsck more than twice shows the same errors...

# fsck.f2fs -f /dev/block/platform/sdhci-tegra.3/by-name/UDA

...
[FIX] (f2fs_set_main_bitmap:  36)  --> Wrong segment type [0x15e9] 4 -> 3
[FIX] (f2fs_set_main_bitmap:  36)  --> Wrong segment type [0x16d] 1 -> 0
[FIX] (f2fs_set_main_bitmap:  36)  --> Wrong segment type [0x15e9] 3 -> 4
[FIX] (f2fs_set_main_bitmap:  29)  --> Wrong segment type [0x16d] 0 -> 1

[FSCK] Unreachable nat entries                        [Ok..] [0x0]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Ok..] [0x2a1d4]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x5cf]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x5cf]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x298]
[FSCK] free segment_count matched with CP             [Ok..] [0x145b]
[FSCK] next block offset is free                      [Ok..]
[FSCK] other corrupted bugs                           [Fail]

Done.



When "other corrupted bugs" is displayed, it sets config.bug_on and
seems to try to write back the fixes. Is there some other change not
yet available to do it?

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
