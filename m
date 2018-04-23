From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: move mnt_want_write_file after range check
Date: Mon, 23 Apr 2018 10:37:23 +0800
Message-ID: <1524451043-22501-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1fARa9-00055f-Mw
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 02:51:57 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fARa6-0086zK-U0
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 02:51:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

This patch move mnt_want_write_file after range check,
it's needless to check arguments with it.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/file.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 16dad2b..165a60f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2061,15 +2061,18 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	end = range.start + range.len;
+	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi)) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"range should be located in (%u, %u]",
+			MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi));
+		return -EINVAL;
+	}
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
 
-	end = range.start + range.len;
-	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi)) {
-		ret = -EINVAL;
-		goto out;
-	}
 do_more:
 	if (!range.sync) {
 		if (!mutex_trylock(&sbi->gc_mutex)) {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
