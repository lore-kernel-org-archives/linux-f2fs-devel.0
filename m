From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: enforce fsync_mode=strict for renamed
 directory
Date: Tue, 24 Apr 2018 23:46:13 -0600
Message-ID: <20180425054613.2700-5-jaegeuk@kernel.org>
References: <20180425054613.2700-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fBDGO-0007nU-UN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 05:46:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBDGM-00B26g-Ds
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 05:46:43 +0000
In-Reply-To: <20180425054613.2700-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This is to give a option for user to be able to recover B/foo in the below
case.

mkdir A
sync()
rename(A, B)
creat (B/foo)
fsync (B/foo)
---crash---

Sugessted-by: Velayudhan Pillai <vijay@cs.utexas.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b5f404674cad..fef6e3ab2135 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -973,8 +973,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			f2fs_put_page(old_dir_page, 0);
 		f2fs_i_links_write(old_dir, false);
 	}
-	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
+	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
+		if (S_ISDIR(old_inode->i_mode))
+			add_ino_entry(sbi, old_inode->i_ino, TRANS_DIR_INO);
+	}
 
 	f2fs_unlock_op(sbi);
 
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
