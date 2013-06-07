From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 2/2] f2fs: support xattr security labels
Date: Fri, 07 Jun 2013 14:55:57 +0900
Message-ID: <1370584557-20592-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1370584557-20592-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Ukpg2-0004Rx-Hb
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 05:57:30 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ukpg1-0004aK-0K for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 05:57:30 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MO000AGLDV8EWJ0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 14:57:20 +0900 (KST)
In-reply-to: <1370584557-20592-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch adds the support of security labels for f2fs, which will be used
by SElinux.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/Kconfig |  9 +++++++++
 fs/f2fs/dir.c   |  5 +++++
 fs/f2fs/xattr.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/xattr.h | 12 +++++++++++-
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index fd27e7e..2214cc9 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -51,3 +51,12 @@ config F2FS_FS_POSIX_ACL
 	  Linux website <http://acl.bestbits.at/>.
 
 	  If you don't know what Access Control Lists are, say N
+
+config F2FS_FS_SECURITY
+	bool "F2FS Security Labels"
+	depends on F2FS_FS_XATTR
+	help
+	  Security labels provide acls used by the security modules
+	  like SELinux. This option should be used with the xattr mode.
+
+	  If you are not using a security module, say N.
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 67e2d13..81a1d6f 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -13,6 +13,7 @@
 #include "f2fs.h"
 #include "node.h"
 #include "acl.h"
+#include "xattr.h"
 
 static unsigned long dir_blocks(struct inode *inode)
 {
@@ -334,6 +335,10 @@ static struct page *init_inode_metadata(struct inode *inode,
 		if (err)
 			goto error;
 
+		err = f2fs_init_security(inode, dir, name);
+		if (err)
+			goto error;
+
 		wait_on_page_writeback(page);
 	} else {
 		page = get_node_page(F2FS_SB(dir->i_sb), inode->i_ino);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ae61f35..b5292fa 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -20,6 +20,7 @@
  */
 #include <linux/rwsem.h>
 #include <linux/f2fs_fs.h>
+#include <linux/security.h>
 #include "f2fs.h"
 #include "xattr.h"
 
@@ -43,6 +44,10 @@ static size_t f2fs_xattr_generic_list(struct dentry *dentry, char *list,
 		prefix = XATTR_TRUSTED_PREFIX;
 		prefix_len = XATTR_TRUSTED_PREFIX_LEN;
 		break;
+	case F2FS_XATTR_INDEX_SECURITY:
+		prefix = XATTR_SECURITY_PREFIX;
+		prefix_len = XATTR_SECURITY_PREFIX_LEN;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -70,13 +75,14 @@ static int f2fs_xattr_generic_get(struct dentry *dentry, const char *name,
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		break;
+	case F2FS_XATTR_INDEX_SECURITY:
+		break;
 	default:
 		return -EINVAL;
 	}
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return f2fs_getxattr(dentry->d_inode, type, name,
-			buffer, size);
+	return f2fs_getxattr(dentry->d_inode, type, name, buffer, size);
 }
 
 static int f2fs_xattr_generic_set(struct dentry *dentry, const char *name,
@@ -93,6 +99,8 @@ static int f2fs_xattr_generic_set(struct dentry *dentry, const char *name,
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		break;
+	case F2FS_XATTR_INDEX_SECURITY:
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -145,6 +153,40 @@ static int f2fs_xattr_advise_set(struct dentry *dentry, const char *name,
 	return 0;
 }
 
+#ifdef CONFIG_F2FS_FS_SECURITY
+static int f2fs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
+		void *fs_info)
+{
+	const struct xattr *xattr;
+	char *name;
+	int err = 0;
+
+	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
+		name = kmalloc(XATTR_SECURITY_PREFIX_LEN +
+			       strlen(xattr->name) + 1, GFP_NOFS);
+		if (!name) {
+			err = -ENOMEM;
+			break;
+		}
+		strcpy(name, XATTR_SECURITY_PREFIX);
+		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
+		err = f2fs_setxattr(inode, F2FS_XATTR_INDEX_SECURITY, name,
+					xattr->value, xattr->value_len);
+		kfree(name);
+		if (err < 0)
+			break;
+	}
+	return err;
+}
+
+int f2fs_init_security(struct inode *inode, struct inode *dir,
+				const struct qstr *qstr)
+{
+	return security_inode_init_security(inode, dir, qstr,
+				&f2fs_initxattrs, NULL);
+}
+#endif
+
 const struct xattr_handler f2fs_xattr_user_handler = {
 	.prefix	= XATTR_USER_PREFIX,
 	.flags	= F2FS_XATTR_INDEX_USER,
@@ -169,6 +211,13 @@ const struct xattr_handler f2fs_xattr_advise_handler = {
 	.set    = f2fs_xattr_advise_set,
 };
 
+const struct xattr_handler f2fs_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.list	= f2fs_xattr_generic_list,
+	.get	= f2fs_xattr_generic_get,
+	.set	= f2fs_xattr_generic_set,
+};
+
 static const struct xattr_handler *f2fs_xattr_handler_map[] = {
 	[F2FS_XATTR_INDEX_USER] = &f2fs_xattr_user_handler,
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
@@ -177,6 +226,9 @@ static const struct xattr_handler *f2fs_xattr_handler_map[] = {
 #endif
 	[F2FS_XATTR_INDEX_TRUSTED] = &f2fs_xattr_trusted_handler,
 	[F2FS_XATTR_INDEX_ADVISE] = &f2fs_xattr_advise_handler,
+#ifdef CONFIG_F2FS_FS_SECURITY
+	[F2FS_XATTR_INDEX_SECURITY] = &f2fs_xattr_security_handler,
+#endif
 };
 
 const struct xattr_handler *f2fs_xattr_handlers[] = {
@@ -187,6 +239,9 @@ const struct xattr_handler *f2fs_xattr_handlers[] = {
 #endif
 	&f2fs_xattr_trusted_handler,
 	&f2fs_xattr_advise_handler,
+#ifdef CONFIG_F2FS_FS_SECURITY
+	&f2fs_xattr_security_handler,
+#endif
 	NULL,
 };
 
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 49c9558..14e1329 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -112,6 +112,7 @@ extern const struct xattr_handler f2fs_xattr_trusted_handler;
 extern const struct xattr_handler f2fs_xattr_acl_access_handler;
 extern const struct xattr_handler f2fs_xattr_acl_default_handler;
 extern const struct xattr_handler f2fs_xattr_advise_handler;
+extern const struct xattr_handler f2fs_xattr_security_handler;
 
 extern const struct xattr_handler *f2fs_xattr_handlers[];
 
@@ -121,7 +122,6 @@ extern int f2fs_getxattr(struct inode *inode, int name_index, const char *name,
 		void *buffer, size_t buffer_size);
 extern ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer,
 		size_t buffer_size);
-
 #else
 
 #define f2fs_xattr_handlers	NULL
@@ -142,4 +142,14 @@ static inline ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer,
 }
 #endif
 
+#ifdef CONFIG_F2FS_FS_SECURITY
+extern int f2fs_init_security(struct inode *inode, struct inode *dir,
+				const struct qstr *qstr);
+#else
+static inline int f2fs_init_security(struct inode *inode, struct inode *dir,
+				const struct qstr *qstr)
+{
+	return 0;
+}
+#endif
 #endif /* __F2FS_XATTR_H__ */
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
