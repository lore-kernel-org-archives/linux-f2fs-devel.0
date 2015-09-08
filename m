From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: add a judgment in add_discard_addrs
Date: Tue, 8 Sep 2015 18:51:13 +0800
Message-ID: <1441709473-21297-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZZGTg-0006ht-9O
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Sep 2015 10:50:16 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZZGTb-0007f5-Dp
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Sep 2015 10:50:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao2.yu@samsung.com, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

CP_DISCARD traverse all segments in fstrim_range to add small discards,
it is better to select entry->len bigger than trim_minlen.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78e6d06..a0dab7a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -599,7 +599,8 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			break;
 
 		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
-		__add_discard_entry(sbi, cpc, se, start, end);
+		if(force && cpc->trim_minlen >= (end - start))
+			__add_discard_entry(sbi, cpc, se, start, end);
 	}
 }
 
-- 
1.9.1


------------------------------------------------------------------------------
