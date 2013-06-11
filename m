From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 2/2 v4] f2fs: support xattr security labels
Date: Tue, 11 Jun 2013 15:54:41 +0900
Message-ID: <1370933681.3600.77.camel@kjgkr>
References: <1370584557-20592-1-git-send-email-jaegeuk.kim@samsung.com>
	<1370584557-20592-2-git-send-email-jaegeuk.kim@samsung.com>
	<1370592580.3600.42.camel@kjgkr> <1370653763.3600.55.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6281668898450608941=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UmIUy-0001bl-7V
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Jun 2013 06:56:08 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UmIUv-0001tk-Da for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Jun 2013 06:56:08 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MO700DAHV9A7750@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Jun 2013 15:55:59 +0900 (KST)
In-reply-to: <1370653763.3600.55.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net


--===============6281668898450608941==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-Wez1pmqxIGYhr8CMEslI"


--=-Wez1pmqxIGYhr8CMEslI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Change log from v3:
 o fix deadlock condition for inode block page (tested on SElinux)

Change log from v2:
 o fix description and simplify a code line (commented by Casey
Schaufler)

Change log from v1:
 o fix a bug

=46rom 2065a7282f65eb1b395c675d4a1f9c8967e60385 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Mon, 3 Jun 2013 19:46:19 +0900
Subject: [PATCH] f2fs: support xattr security labels
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
linux-f2fs-devel@lists.sourceforge.net

This patch adds the support of security labels for f2fs, which will be
used
by Linus Security Models (LSMs).

Quote from http://en.wikipedia.org/wiki/Linux_Security_Modules:
"Linux Security Modules (LSM) is a framework that allows the Linux
kernel to
support a variety of computer security models while avoiding favoritism
toward
any single security implementation. The framework is licensed under the
terms of
the GNU General Public License and is standard part of the Linux kernel
since
Linux 2.6. AppArmor, SELinux, Smack and TOMOYO Linux are the currently
accepted
modules in the official kernel.".

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/Kconfig | 12 +++++++++++
 fs/f2fs/dir.c   |  5 +++++
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/node.c  | 12 +++++++----
 fs/f2fs/xattr.c | 64
++++++++++++++++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/xattr.h | 24 ++++++++++++++--------
 6 files changed, 99 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index fd27e7e..e06e099 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -51,3 +51,15 @@ config F2FS_FS_POSIX_ACL
 	  Linux website <http://acl.bestbits.at/>.
=20
 	  If you don't know what Access Control Lists are, say N
+
+config F2FS_FS_SECURITY
+	bool "F2FS Security Labels"
+	depends on F2FS_FS_XATTR
+	help
+	  Security labels provide an access control facility to support Linux
+	  Security Models (LSMs) accepted by AppArmor, SELinux, Smack and
TOMOYO
+	  Linux. This option enables an extended attribute handler for file
+	  security labels in the f2fs filesystem, so that it requires enabling
+	  the extended attribute support in advance.
+
+	  If you are not using a security module, say N.
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 67e2d13..eaea5b5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -13,6 +13,7 @@
 #include "f2fs.h"
 #include "node.h"
 #include "acl.h"
+#include "xattr.h"
=20
 static unsigned long dir_blocks(struct inode *inode)
 {
@@ -334,6 +335,10 @@ static struct page *init_inode_metadata(struct
inode *inode,
 		if (err)
 			goto error;
=20
+		err =3D f2fs_init_security(inode, dir, name, page);
+		if (err)
+			goto error;
+
 		wait_on_page_writeback(page);
 	} else {
 		page =3D get_node_page(F2FS_SB(dir->i_sb), inode->i_ino);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d6e63da..4f2c209 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -968,7 +968,7 @@ int get_dnode_of_data(struct dnode_of_data *,
pgoff_t, int);
 int truncate_inode_blocks(struct inode *, pgoff_t);
 int remove_inode_page(struct inode *);
 struct page *new_inode_page(struct inode *, const struct qstr *);
-struct page *new_node_page(struct dnode_of_data *, unsigned int);
+struct page *new_node_page(struct dnode_of_data *, unsigned int, struct
page *);
 void ra_node_page(struct f2fs_sb_info *, nid_t);
 struct page *get_node_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_node_page_ra(struct page *, int);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5a59780..b02440c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -433,7 +433,7 @@ int get_dnode_of_data(struct dnode_of_data *dn,
pgoff_t index, int mode)
 			}
=20
 			dn->nid =3D nids[i];
-			npage[i] =3D new_node_page(dn, noffset[i]);
+			npage[i] =3D new_node_page(dn, noffset[i], NULL);
 			if (IS_ERR(npage[i])) {
 				alloc_nid_failed(sbi, nids[i]);
 				err =3D PTR_ERR(npage[i]);
@@ -814,10 +814,11 @@ struct page *new_inode_page(struct inode *inode,
const struct qstr *name)
 	set_new_dnode(&dn, inode, NULL, NULL, inode->i_ino);
=20
 	/* caller should f2fs_put_page(page, 1); */
-	return new_node_page(&dn, 0);
+	return new_node_page(&dn, 0, NULL);
 }
=20
-struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
+struct page *new_node_page(struct dnode_of_data *dn,
+				unsigned int ofs, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi =3D F2FS_SB(dn->inode->i_sb);
 	struct address_space *mapping =3D sbi->node_inode->i_mapping;
@@ -850,7 +851,10 @@ struct page *new_node_page(struct dnode_of_data
*dn, unsigned int ofs)
 	set_cold_node(dn->inode, page);
=20
 	dn->node_page =3D page;
-	sync_inode_page(dn);
+	if (ipage)
+		update_inode(dn->inode, ipage);
+	else
+		sync_inode_page(dn);
 	set_page_dirty(page);
 	if (ofs =3D=3D 0)
 		inc_valid_inode_count(sbi);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ae61f35..3ab07ec 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -20,6 +20,7 @@
  */
 #include <linux/rwsem.h>
 #include <linux/f2fs_fs.h>
+#include <linux/security.h>
 #include "f2fs.h"
 #include "xattr.h"
=20
@@ -43,6 +44,10 @@ static size_t f2fs_xattr_generic_list(struct dentry
*dentry, char *list,
 		prefix =3D XATTR_TRUSTED_PREFIX;
 		prefix_len =3D XATTR_TRUSTED_PREFIX_LEN;
 		break;
+	case F2FS_XATTR_INDEX_SECURITY:
+		prefix =3D XATTR_SECURITY_PREFIX;
+		prefix_len =3D XATTR_SECURITY_PREFIX_LEN;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -50,7 +55,7 @@ static size_t f2fs_xattr_generic_list(struct dentry
*dentry, char *list,
 	total_len =3D prefix_len + name_len + 1;
 	if (list && total_len <=3D list_size) {
 		memcpy(list, prefix, prefix_len);
-		memcpy(list+prefix_len, name, name_len);
+		memcpy(list + prefix_len, name, name_len);
 		list[prefix_len + name_len] =3D '\0';
 	}
 	return total_len;
@@ -70,13 +75,14 @@ static int f2fs_xattr_generic_get(struct dentry
*dentry, const char *name,
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		break;
+	case F2FS_XATTR_INDEX_SECURITY:
+		break;
 	default:
 		return -EINVAL;
 	}
 	if (strcmp(name, "") =3D=3D 0)
 		return -EINVAL;
-	return f2fs_getxattr(dentry->d_inode, type, name,
-			buffer, size);
+	return f2fs_getxattr(dentry->d_inode, type, name, buffer, size);
 }
=20
 static int f2fs_xattr_generic_set(struct dentry *dentry, const char
*name,
@@ -93,13 +99,15 @@ static int f2fs_xattr_generic_set(struct dentry
*dentry, const char *name,
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		break;
+	case F2FS_XATTR_INDEX_SECURITY:
+		break;
 	default:
 		return -EINVAL;
 	}
 	if (strcmp(name, "") =3D=3D 0)
 		return -EINVAL;
=20
-	return f2fs_setxattr(dentry->d_inode, type, name, value, size);
+	return f2fs_setxattr(dentry->d_inode, type, name, value, size, NULL);
 }
=20
 static size_t f2fs_xattr_advise_list(struct dentry *dentry, char *list,
@@ -145,6 +153,31 @@ static int f2fs_xattr_advise_set(struct dentry
*dentry, const char *name,
 	return 0;
 }
=20
+#ifdef CONFIG_F2FS_FS_SECURITY
+static int f2fs_initxattrs(struct inode *inode, const struct xattr
*xattr_array,
+		void *page)
+{
+	const struct xattr *xattr;
+	int err =3D 0;
+
+	for (xattr =3D xattr_array; xattr->name !=3D NULL; xattr++) {
+		err =3D f2fs_setxattr(inode, F2FS_XATTR_INDEX_SECURITY,
+				xattr->name, xattr->value,
+				xattr->value_len, (struct page *)page);
+		if (err < 0)
+			break;
+	}
+	return err;
+}
+
+int f2fs_init_security(struct inode *inode, struct inode *dir,
+				const struct qstr *qstr, struct page *ipage)
+{
+	return security_inode_init_security(inode, dir, qstr,
+				&f2fs_initxattrs, ipage);
+}
+#endif
+
 const struct xattr_handler f2fs_xattr_user_handler =3D {
 	.prefix	=3D XATTR_USER_PREFIX,
 	.flags	=3D F2FS_XATTR_INDEX_USER,
@@ -169,6 +202,14 @@ const struct xattr_handler
f2fs_xattr_advise_handler =3D {
 	.set    =3D f2fs_xattr_advise_set,
 };
=20
+const struct xattr_handler f2fs_xattr_security_handler =3D {
+	.prefix	=3D XATTR_SECURITY_PREFIX,
+	.flags	=3D F2FS_XATTR_INDEX_SECURITY,
+	.list	=3D f2fs_xattr_generic_list,
+	.get	=3D f2fs_xattr_generic_get,
+	.set	=3D f2fs_xattr_generic_set,
+};
+
 static const struct xattr_handler *f2fs_xattr_handler_map[] =3D {
 	[F2FS_XATTR_INDEX_USER] =3D &f2fs_xattr_user_handler,
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
@@ -176,6 +217,9 @@ static const struct xattr_handler
*f2fs_xattr_handler_map[] =3D {
 	[F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT] =3D
&f2fs_xattr_acl_default_handler,
 #endif
 	[F2FS_XATTR_INDEX_TRUSTED] =3D &f2fs_xattr_trusted_handler,
+#ifdef CONFIG_F2FS_FS_SECURITY
+	[F2FS_XATTR_INDEX_SECURITY] =3D &f2fs_xattr_security_handler,
+#endif
 	[F2FS_XATTR_INDEX_ADVISE] =3D &f2fs_xattr_advise_handler,
 };
=20
@@ -186,6 +230,9 @@ const struct xattr_handler *f2fs_xattr_handlers[] =3D
{
 	&f2fs_xattr_acl_default_handler,
 #endif
 	&f2fs_xattr_trusted_handler,
+#ifdef CONFIG_F2FS_FS_SECURITY
+	&f2fs_xattr_security_handler,
+#endif
 	&f2fs_xattr_advise_handler,
 	NULL,
 };
@@ -300,7 +347,7 @@ cleanup:
 }
=20
 int f2fs_setxattr(struct inode *inode, int name_index, const char
*name,
-					const void *value, size_t value_len)
+			const void *value, size_t value_len, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
 	struct f2fs_inode_info *fi =3D F2FS_I(inode);
@@ -339,7 +386,7 @@ int f2fs_setxattr(struct inode *inode, int
name_index, const char *name,
 		set_new_dnode(&dn, inode, NULL, NULL, fi->i_xattr_nid);
 		mark_inode_dirty(inode);
=20
-		page =3D new_node_page(&dn, XATTR_NODE_OFFSET);
+		page =3D new_node_page(&dn, XATTR_NODE_OFFSET, ipage);
 		if (IS_ERR(page)) {
 			alloc_nid_failed(sbi, fi->i_xattr_nid);
 			fi->i_xattr_nid =3D 0;
@@ -439,7 +486,10 @@ int f2fs_setxattr(struct inode *inode, int
name_index, const char *name,
 		inode->i_ctime =3D CURRENT_TIME;
 		clear_inode_flag(fi, FI_ACL_MODE);
 	}
-	update_inode_page(inode);
+	if (ipage)
+		update_inode(inode, ipage);
+	else
+		update_inode_page(inode);
 	mutex_unlock_op(sbi, ilock);
=20
 	return 0;
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 49c9558..3c0817b 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -112,21 +112,19 @@ extern const struct xattr_handler
f2fs_xattr_trusted_handler;
 extern const struct xattr_handler f2fs_xattr_acl_access_handler;
 extern const struct xattr_handler f2fs_xattr_acl_default_handler;
 extern const struct xattr_handler f2fs_xattr_advise_handler;
+extern const struct xattr_handler f2fs_xattr_security_handler;
=20
 extern const struct xattr_handler *f2fs_xattr_handlers[];
=20
-extern int f2fs_setxattr(struct inode *inode, int name_index, const
char *name,
-		const void *value, size_t value_len);
-extern int f2fs_getxattr(struct inode *inode, int name_index, const
char *name,
-		void *buffer, size_t buffer_size);
-extern ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer,
-		size_t buffer_size);
-
+extern int f2fs_setxattr(struct inode *, int, const char *,
+				const void *, size_t, struct page *);
+extern int f2fs_getxattr(struct inode *, int, const char *, void *,
size_t);
+extern ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
 #else
=20
 #define f2fs_xattr_handlers	NULL
 static inline int f2fs_setxattr(struct inode *inode, int name_index,
-	const char *name, const void *value, size_t value_len)
+		const char *name, const void *value, size_t value_len)
 {
 	return -EOPNOTSUPP;
 }
@@ -142,4 +140,14 @@ static inline ssize_t f2fs_listxattr(struct dentry
*dentry, char *buffer,
 }
 #endif
=20
+#ifdef CONFIG_F2FS_FS_SECURITY
+extern int f2fs_init_security(struct inode *, struct inode *,
+				const struct qstr *, struct page *);
+#else
+static inline int f2fs_init_security(struct inode *inode, struct inode
*dir,
+				const struct qstr *qstr, struct page *ipage)
+{
+	return 0;
+}
+#endif
 #endif /* __F2FS_XATTR_H__ */
--=20
1.8.1.3.566.gaa39828



--=20
Jaegeuk Kim
Samsung

--=-Wez1pmqxIGYhr8CMEslI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRtsmxAAoJEEAUqH6CSFDScvgP/i+XRaAAkZgKp+6MXpg3L7WH
aySX9E7nCctDWftxzPyGXPUDGnaq+67qThy3/RibKFAQm0AQPjC3/LTXygGlYDDY
zvldAzhTBDiN9HmsIJuBg2TWhRf+yCiIoXzV72vLFJ3aymGM1nhaquOTboN0fpD1
twhbj9SKmNDmn/bfQNDJaHJcJxE8all8yd7pRQatUWjGz/Lmg90r3sBB2/ckSuQp
u7bVQRnaLWFnDBzE2mK15izK+uGmxL/GzGJb5tGU4li43OLi1C8hBdyDqVFrucm4
afS77kg5YCSGlfESsmq99Z+CJt4kASbgsBHVw2wvZdTyiiHVFhjdBiAMv2I2LoAO
hhAO3wPbeENXG4hAe9303JfX/mY9T2indk23+WJqgUKgWfogxLyaWRtdQC0xaG6t
BOLhKK+Gp0dPHRvNqPp9a3cQKeoWhoCs17lGS6vjEpvvSMyvqpun6aI8FMuIRCvx
tpVUD/3CelsyL95MAVJZbLyScg+P4JCmav85U8US2UTUn5dUr/6NNARBSkiouZve
c2UybpfVjbbKIo9cdPQOfIhkmnY6d0CzF1LjgCw9IDwBcp/GES5jvSYDsht1SE5D
ojZav+APv8bYMm4I155zgaxYLwEDFMXdxR28Lb2XTve0/vpbsrCI9ZDzsKS44qRk
7UGqfb+Guvn6z/f8yBCi
=Db2t
-----END PGP SIGNATURE-----

--=-Wez1pmqxIGYhr8CMEslI--



--===============6281668898450608941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============6281668898450608941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============6281668898450608941==--
