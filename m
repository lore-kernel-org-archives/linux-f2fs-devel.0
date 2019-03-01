From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH 8/8] xfs: support project in xfs_getattr()
Date: Fri,  1 Mar 2019 23:05:41 +0900
Message-ID: <1551449141-7884-9-git-send-email-wshilong1991@gmail.com>
References: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1gzinq-0004N0-Bq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:18 +0000
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gzino-006oNy-Ul
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:18 +0000
Received: by mail-pg1-f175.google.com with SMTP id 196so11493041pgf.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 01 Mar 2019 06:06:16 -0800 (PST)
In-Reply-To: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: adilger@dilger.ca, lixi@ddn.com, Wang Shilong <wshilong@ddn.com>

From: Wang Shilong <wshilong@ddn.com>

From: Wang Shilong <wshilong@ddn.com>

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 fs/xfs/xfs_iops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index c10466fe6ed4..a2f8c0f048cf 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -501,6 +501,7 @@ xfs_vn_getattr(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
+	stat->projid = xfs_projid_to_kprojid(xfs_get_projid(ip));
 	stat->size = XFS_ISIZE(ip);
 	stat->dev = inode->i_sb->s_dev;
 	stat->mode = inode->i_mode;
@@ -528,6 +529,8 @@ xfs_vn_getattr(
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
 		stat->attributes |= STATX_ATTR_NODUMP;
+	if (ip->i_d.di_flags & XFS_DIFLAG_PROJINHERIT)
+		stat->attributes |= STATX_ATTR_PROJINHERIT;
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFBLK:
-- 
2.19.1
