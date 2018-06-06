From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: don't acquire orphan ino during
 recovery
Date: Wed,  6 Jun 2018 23:55:01 +0800
Message-ID: <20180606155502.11619-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fQamp-0001l2-MX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jun 2018 15:55:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fQaml-00CdSN-Qc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jun 2018 15:55:47 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

During orphan inode recovery, checkpoint should never succeed due to
SBI_POR_DOING flag, so we don't need acquire orphan ino which only be
used by checkpoint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9f825a5a5c9f..ae0a06a8dec1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -578,12 +578,7 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct inode *inode;
 	struct node_info ni;
-	int err = f2fs_acquire_orphan_inode(sbi);
-
-	if (err)
-		goto err_out;
-
-	__add_ino_entry(sbi, ino, 0, ORPHAN_INO);
+	int err;
 
 	inode = f2fs_iget_retry(sbi->sb, ino);
 	if (IS_ERR(inode)) {
@@ -613,7 +608,6 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 		err = -EIO;
 		goto err_out;
 	}
-	__remove_ino_entry(sbi, ino, ORPHAN_INO);
 	return 0;
 
 err_out:
-- 
2.16.2.17.g38e79b1fd


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
