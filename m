From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/3] f2fs: pass flags field to setxattr functions
Date: Wed, 23 Apr 2014 14:23:31 +0900
Message-ID: <1398230612-7062-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1398230612-7062-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Wcpgv-0000a4-HA
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Apr 2014 05:25:53 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wcpgu-0003Ff-2f
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Apr 2014 05:25:53 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4G00LYSXQVB490@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Apr 2014 14:25:43 +0900 (KST)
In-reply-to: <1398230612-7062-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch passes the "flags" field to the low level setxattr functions
to use XATTR_REPLACE in the following patches.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/acl.c   |  2 +-
 fs/f2fs/xattr.c | 13 +++++++------
 fs/f2fs/xattr.h |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index e93e4ec..dbe2141 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -240,7 +240,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 		}
 	}
 
-	error = f2fs_setxattr(inode, name_index, "", value, size, ipage);
+	error = f2fs_setxattr(inode, name_index, "", value, size, ipage, 0);
 
 	kfree(value);
 	if (!error)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 1de057d..bbe9c2b 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -108,7 +108,8 @@ static int f2fs_xattr_generic_set(struct dentry *dentry, const char *name,
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
 
-	return f2fs_setxattr(dentry->d_inode, type, name, value, size, NULL);
+	return f2fs_setxattr(dentry->d_inode, type, name,
+					value, size, NULL, flags);
 }
 
 static size_t f2fs_xattr_advise_list(struct dentry *dentry, char *list,
@@ -157,7 +158,7 @@ static int f2fs_xattr_advise_set(struct dentry *dentry, const char *name,
 #ifdef CONFIG_F2FS_FS_SECURITY
 static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
-			struct page *ipage);
+			struct page *ipage, int);
 
 static int f2fs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 		void *page)
@@ -168,7 +169,7 @@ static int f2fs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 		err = __f2fs_setxattr(inode, F2FS_XATTR_INDEX_SECURITY,
 				xattr->name, xattr->value,
-				xattr->value_len, (struct page *)page);
+				xattr->value_len, (struct page *)page, 0);
 		if (err < 0)
 			break;
 	}
@@ -479,7 +480,7 @@ cleanup:
 
 static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
-			struct page *ipage)
+			struct page *ipage, int flags)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_xattr_entry *here, *last;
@@ -586,7 +587,7 @@ exit:
 
 int f2fs_setxattr(struct inode *inode, int index, const char *name,
 				const void *value, size_t size,
-				struct page *ipage)
+				struct page *ipage, int flags)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	int err;
@@ -596,7 +597,7 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	f2fs_lock_op(sbi);
 	/* protect xattr_ver */
 	down_write(&F2FS_I(inode)->i_sem);
-	err = __f2fs_setxattr(inode, index, name, value, size, ipage);
+	err = __f2fs_setxattr(inode, index, name, value, size, ipage, flags);
 	up_write(&F2FS_I(inode)->i_sem);
 	f2fs_unlock_op(sbi);
 
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 79bc2bb..34ab7db 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -114,14 +114,14 @@ extern const struct xattr_handler f2fs_xattr_security_handler;
 extern const struct xattr_handler *f2fs_xattr_handlers[];
 
 extern int f2fs_setxattr(struct inode *, int, const char *,
-				const void *, size_t, struct page *);
+				const void *, size_t, struct page *, int);
 extern int f2fs_getxattr(struct inode *, int, const char *, void *, size_t);
 extern ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
 #else
 
 #define f2fs_xattr_handlers	NULL
 static inline int f2fs_setxattr(struct inode *inode, int index,
-		const char *name, const void *value, size_t size)
+		const char *name, const void *value, size_t size, int flags)
 {
 	return -EOPNOTSUPP;
 }
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
