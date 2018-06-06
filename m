From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: check mount option before turn quota on
Date: Wed, 6 Jun 2018 10:12:02 +0800
Message-ID: <1528251122-24907-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1fQOAv-000458-IE
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jun 2018 02:27:49 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fQOAt-00AOWc-Bn
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jun 2018 02:27:49 +0000
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

This patch add a mount option check before turn quota on,
which is same as ext4 does. BTW, both f2fs and ext4 have
no mount options check to enable limits quota on sys file,
is there no need to do this?

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 25863cec..a0264a5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1792,6 +1792,9 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 	struct inode *inode;
 	int err;
 
+	if (!test_opt(sb, QUOTA))
+		return -EINVAL;
+
 	err = f2fs_quota_sync(sb, type);
 	if (err)
 		return err;
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
