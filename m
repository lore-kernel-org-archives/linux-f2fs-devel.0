From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [oops, 4.4-rc8] warn + oops during generic/204
Date: Fri, 22 Jan 2016 09:52:59 +0800
Message-ID: <20160122015259.GB53329@jaegeuk>
References: <20160120213102.GF20456@dastard>
	<008501d15441$68c7d870$3a578950$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aMQuk-0006bI-VR
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Jan 2016 01:53:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aMQuj-0006rh-QJ for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Jan 2016 01:53:26 +0000
Content-Disposition: inline
In-Reply-To: <008501d15441$68c7d870$3a578950$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Dave Chinner' <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net

On Thu, Jan 21, 2016 at 07:46:10PM +0800, Chao Yu wrote:
> Hi Dave,
> 
> > -----Original Message-----
> > From: Dave Chinner [mailto:david@fromorbit.com]
> > Sent: Thursday, January 21, 2016 5:31 AM
> > To: linux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] [oops, 4.4-rc8] warn + oops during generic/204
> > 
> > Hi f2fs folks,
> > 
> > I just ran xfstests on f2fs using defaults and a pair of 4GB ram
> > disks for the test and scratch devices, and it hard locked the
> > machine with this failure in generic/204:
> 
> Thanks for your report! :)
> 
> Hi all,
> 
> We didn't handle well with the case of inline data storm which floods
> full disk. Actually the reason is: if we have 10M free space, and user
> fillings the disk with ~10M inline data, then in memory there are ~10M
> dirty inline datas and ~10M dirty inodes, once inodes were writebacked
> before inline datas, all free space will be occupied, then we have to
> write these dirty inline datas to ovp area which doesn't have enough
> space there normally.

Well, I think the user block count was wrong which is determined by mkfs.f2fs.
When writing inline_data, gc should activate to reclaim the space, but it
seems it couldn't do that cause there is no victim.
So, when taking a look at mkfs, I suspect that the number of total user blocks
does not consider our current segments, which is 6 by default.
IOWs, we gave more blocks to users, which turns out actually gc couldn't get a
victim from them in this case.

I could reproduce this issue, and once I reduced the number by 6 segments,
I could avoid the issue.

Here the change of f2fs-tools.

>From 411166a44009bb138eca937376863e9ce673278a Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 21 Jan 2016 05:16:37 -0800
Subject: [PATCH] mkfs.f2fs: adjust current segments for total usable blocks

When calculating total number of user blocks, we should reserve the current
segments.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 2c81ecc..b25a490 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -474,7 +474,12 @@ static int f2fs_write_check_point_pack(void)
 
 	/* main segments - reserved segments - (node + data segments) */
 	set_cp(free_segment_count, get_sb(segment_count_main) - 6);
-	set_cp(user_block_count, ((get_cp(free_segment_count) + 6 -
+	if (get_cp(free_segment_count) <= get_cp(overprov_segment_count)) {
+		MSG(0, "Error: Too small size\n");
+		goto free_sum_compact;
+	}
+
+	set_cp(user_block_count, ((get_cp(free_segment_count) -
 			get_cp(overprov_segment_count)) * config.blks_per_seg));
 	/* cp page (2), data summaries (1), node summaries (3) */
 	set_cp(cp_pack_total_block_count, 6 + get_sb(cp_payload));
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
