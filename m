From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH 2/8] ext4: support project ID in ext4_setattr()
Date: Fri,  1 Mar 2019 23:05:35 +0900
Message-ID: <1551449141-7884-3-git-send-email-wshilong1991@gmail.com>
References: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1gzinc-0000ou-M8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:04 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gzina-00Gmm5-Ev
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:04 +0000
Received: by mail-pg1-f196.google.com with SMTP id e17so9450073pgd.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 01 Mar 2019 06:06:02 -0800 (PST)
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
 fs/ext4/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 34d7e0703cc6..b6c451407dcd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5537,10 +5537,12 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 			return error;
 	}
 	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
-	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
+	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid)) ||
+	    (ia_valid & ATTR_PROJID && !projid_eq(attr->ia_projid,
+						  EXT4_I(inode)->i_projid))) {
 		handle_t *handle;
 
-		/* (user+group)*(old+new) structure, inode write (sb,
+		/* (user+group+project)*(old+new) structure, inode write (sb,
 		 * inode block, ? - but truncate inode update has it) */
 		handle = ext4_journal_start(inode, EXT4_HT_QUOTA,
 			(EXT4_MAXQUOTAS_INIT_BLOCKS(inode->i_sb) +
@@ -5567,6 +5569,8 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 			inode->i_uid = attr->ia_uid;
 		if (attr->ia_valid & ATTR_GID)
 			inode->i_gid = attr->ia_gid;
+		if (attr->ia_valid & ATTR_PROJID)
+			EXT4_I(inode)->i_projid = attr->ia_projid;
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 	}
-- 
2.19.1
