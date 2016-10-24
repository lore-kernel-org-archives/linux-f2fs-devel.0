From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 2/2] fsck.f2fs: do not check the first seg in a
	sec in find_next_free_block
Date: Mon, 24 Oct 2016 10:16:04 +0800
Message-ID: <20161024021604.5218-2-shengyong1@huawei.com>
References: <20161024021604.5218-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1byUxC-0007dl-QM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Oct 2016 02:25:34 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1byUxB-0004Mk-TK
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Oct 2016 02:25:34 +0000
In-Reply-To: <20161024021604.5218-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com

The first segment is already checked, so there is no need to check it
again if we want to make sure the whole section is freed.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index ca7f6dd..0a47bf7 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1573,7 +1573,7 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 			struct seg_entry *se2;
 			unsigned int i;
 
-			for (i = 0; i < sbi->segs_per_sec; i++) {
+			for (i = 1; i < sbi->segs_per_sec; i++) {
 				se2 = get_seg_entry(sbi, segno + i);
 				if (se2->valid_blocks)
 					break;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
