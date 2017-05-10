From: Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH v2] f2fs: make sure f2fs_gc returns consistent
	errno
Date: Thu, 11 May 2017 04:28:00 +0800
Message-ID: <20170510202800.101013-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guoweichao@huawei.com>) id 1d8Ql7-00071e-0v
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 12:30:25 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d8Ql3-0001v8-O8
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 12:30:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao@kernel.org, jaegeuk@kernel.org
Cc: Weichao Guo <guoweichao@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

By default, f2fs_gc returns -EINVAL in general error cases, e.g., no victim
was selected. However, the default errno may be overwritten in two cases:
gc_more and BG_GC -> FG_GC. We should return consistent errno in such cases.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
---
 fs/f2fs/gc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0265221..965fbf5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -955,7 +955,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 {
 	int gc_type = sync ? FG_GC : BG_GC;
 	int sec_freed = 0;
-	int ret = -EINVAL;
+	int ret;
 	struct cp_control cpc;
 	unsigned int init_segno = segno;
 	struct gc_inode_list gc_list = {
@@ -965,8 +965,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 
 	cpc.reason = __get_cp_reason(sbi);
 gc_more:
-	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE)))
+	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE))) {
+		ret = -EINVAL;
 		goto stop;
+	}
 	if (unlikely(f2fs_cp_error(sbi))) {
 		ret = -EIO;
 		goto stop;
@@ -987,6 +989,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 			gc_type = FG_GC;
 	}
 
+	ret = -EINVAL;
 	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
 	if (gc_type == BG_GC && !background)
 		goto stop;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
