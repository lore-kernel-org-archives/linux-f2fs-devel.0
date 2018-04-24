From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v3] f2fs: move mnt_want_write_file after range
 check
Date: Tue, 24 Apr 2018 18:58:45 +0800
Message-ID: <1524567525-20682-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1fAvsv-0004Bv-04
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Apr 2018 11:13:21 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fAvsp-007C7L-Vu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Apr 2018 11:13:20 +0000
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
 fs/f2fs/file.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 16dad2b..6b79b8a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2061,15 +2061,14 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	end = range.start + range.len;
+	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi))
+		return -EINVAL;
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
