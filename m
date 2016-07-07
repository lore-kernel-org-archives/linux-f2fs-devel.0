From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: avoid mismatching block range for discard
Date: Thu, 7 Jul 2016 12:13:33 +0800
Message-ID: <1467864813-3556-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1bL0dh-0004GL-5B
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 Jul 2016 04:10:13 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bL0dd-0004bG-Di
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 Jul 2016 04:10:13 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao@huawei.com
Cc: heyunlei@huwei.com

This patch skip discard block range smaller than trim_minlen,
and can not be merged by neighbour

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6d16ecf..9e13db0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -672,6 +672,10 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			break;
 
 		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
+		if (force && start && end != max_blocks
+					&& (end - start) < cpc->trim_minlen)
+			continue;
+
 		__add_discard_entry(sbi, cpc, se, start, end);
 	}
 }
-- 
1.9.1


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
