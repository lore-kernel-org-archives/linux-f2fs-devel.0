From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH v2] f2fs: only set project inherit bit for
 directory
Date: Thu, 13 Jun 2019 16:29:53 +0900
Message-ID: <1560410993-26330-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1hbKBX-0003QE-Cf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 07:30:11 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hbKBT-00BDaj-Sf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 07:30:09 +0000
Received: by mail-pg1-f196.google.com with SMTP id d30so10421842pgm.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Jun 2019 00:30:07 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Andreas Dilger <adilger@dilger.ca>, Wang Shilong <wshilong@ddn.com>

From: Wang Shilong <wshilong@ddn.com>

It doesn't make any sense to have project inherit bits
for regular files, even though this won't cause any
problem, but it is better fix this.

Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
v1->v2:
don't return project inherit flags for regular files
---
 fs/f2fs/f2fs.h  | 3 ++-
 fs/f2fs/inode.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9bd2bf0f559b..ab176a92fa55 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2385,7 +2385,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 			   F2FS_PROJINHERIT_FL)
 
 /* Flags that are appropriate for regular files (all but dir-specific ones). */
-#define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL))
+#define F2FS_REG_FLMASK 	(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL |\
+				   F2FS_PROJINHERIT_FL))
 
 /* Flags that are appropriate for non-directories/regular files. */
 #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ccb02226dd2c..8838e55e7416 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -343,6 +343,8 @@ static int do_read_inode(struct inode *inode)
 					le16_to_cpu(ri->i_gc_failures);
 	fi->i_xattr_nid = le32_to_cpu(ri->i_xattr_nid);
 	fi->i_flags = le32_to_cpu(ri->i_flags);
+	if (S_ISREG(inode->i_mode))
+		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
 	fi->flags = 0;
 	fi->i_advise = ri->i_advise;
 	fi->i_pino = le32_to_cpu(ri->i_pino);
-- 
2.21.0
