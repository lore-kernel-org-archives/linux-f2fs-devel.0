From: Chao Yu <chao@kernel.org>
Subject: [PATCH] fsck.f2fs: fix to repair cp_loads blocks at
 correct position
Date: Sun, 19 May 2019 13:05:52 +0800
Message-ID: <20190519050552.6333-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1hSE1m-0004NW-Vd
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 19 May 2019 05:06:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hSE1l-007ByR-9W
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 19 May 2019 05:06:30 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

From: Chao Yu <yuchao0@huawei.com>

Let's fix the wrong start offset of cp_payload blocks in
fix_checkpoint().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6075d22..10a62fd 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2104,8 +2104,8 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	ASSERT(ret >= 0);
 
 	for (i = 0; i < get_sb(cp_payload); i++) {
-		ret = dev_write_block(((unsigned char *)cp) + i * F2FS_BLKSIZE,
-								cp_blk_no++);
+		ret = dev_write_block(((unsigned char *)cp) +
+					(i + 1) * F2FS_BLKSIZE, cp_blk_no++);
 		ASSERT(ret >= 0);
 	}
 
-- 
2.18.0
