From: Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH] f2fs: make sure f2fs_gc returns consistent errno
Date: Tue, 9 May 2017 19:37:54 +0800
Message-ID: <20170509113754.53173-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guoweichao@huawei.com>) id 1d7w1O-0008IN-KK
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 May 2017 03:41:10 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d7w1K-0000qV-Ha
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 May 2017 03:41:10 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: Weichao Guo <guoweichao@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

By default, f2fs_gc returns -EINVAL in general error cases, e.g., no victim
was selected. However, the default errno may be overwritten in two cases:
gc_more and BG_GC -> FG_GC. We should return consistent errno in such cases.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0265221..32c9463 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -965,6 +965,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 
 	cpc.reason = __get_cp_reason(sbi);
 gc_more:
+	ret = -EINVAL;
 	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE)))
 		goto stop;
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -982,6 +983,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 			ret = write_checkpoint(sbi, &cpc);
 			if (ret)
 				goto stop;
+			else
+				ret = -EINVAL;
 		}
 		if (has_not_enough_free_secs(sbi, 0, 0))
 			gc_type = FG_GC;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
