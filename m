From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH 3/8] f2fs: support project ID in f2fs_setattr()
Date: Fri,  1 Mar 2019 23:05:36 +0900
Message-ID: <1551449141-7884-4-git-send-email-wshilong1991@gmail.com>
References: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1gzine-0000pU-Bo
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:06 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gzinc-006oMk-TD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:06 +0000
Received: by mail-pg1-f193.google.com with SMTP id 196so11492754pgf.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 01 Mar 2019 06:06:04 -0800 (PST)
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
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bba56b39dcc5..8eaca056e857 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -789,7 +789,9 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	if ((attr->ia_valid & ATTR_UID &&
 		!uid_eq(attr->ia_uid, inode->i_uid)) ||
 		(attr->ia_valid & ATTR_GID &&
-		!gid_eq(attr->ia_gid, inode->i_gid))) {
+		!gid_eq(attr->ia_gid, inode->i_gid)) ||
+		(attr->ia_valid & ATTR_PROJID &&
+		!projid_eq(attr->ia_projid, F2FS_I(inode)->i_projid))) {
 		f2fs_lock_op(F2FS_I_SB(inode));
 		err = dquot_transfer(inode, attr);
 		if (err) {
@@ -806,6 +808,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			inode->i_uid = attr->ia_uid;
 		if (attr->ia_valid & ATTR_GID)
 			inode->i_gid = attr->ia_gid;
+		if (attr->ia_valid & ATTR_PROJID)
+			F2FS_I(inode)->i_projid = attr->ia_projid;
 		f2fs_mark_inode_dirty_sync(inode, true);
 		f2fs_unlock_op(F2FS_I_SB(inode));
 	}
-- 
2.19.1
