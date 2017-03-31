From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix a infinite loop in gc_node_segment
Date: Fri, 31 Mar 2017 18:53:25 +0800
Message-ID: <20170331105325.22040-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ctu7e-0005Vl-VN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Mar 2017 10:49:38 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ctu7d-000866-4V
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Mar 2017 10:49:38 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Similar as this problem:
	f2fs: relax node version check for victim data in gc

But this patch fix wrong SSA nid.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c52656c..1d0fd04 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -499,6 +499,25 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 		get_node_info(sbi, nid, &ni);
 		if (ni.blk_addr != start_addr + off) {
 			f2fs_put_page(node_page, 1);
+			node_page = pagecache_get_page(META_MAPPING(sbi), start_addr + off,
+								FGP_LOCK | FGP_CREAT, GFP_NOFS);
+			if (!node_page)
+				continue;
+
+			lock_page(node_page);
+			if (unlikely(node_page->mapping != META_MAPPING(sbi))
+							|| unlikely(!PageUptodate(node_page))) {
+				f2fs_put_page(node_page, 1);
+				continue;
+			}
+
+			get_node_info(sbi, nid_of_node(node_page), &ni);
+			if (ni.blk_addr == start_addr + off) {
+				entry->nid = cpu_to_le32(ni.nid);
+			else
+				f2fs_bug_on(sbi, 1);
+
+			f2fs_put_page(node_page, 1);
 			continue;
 		}
 
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
