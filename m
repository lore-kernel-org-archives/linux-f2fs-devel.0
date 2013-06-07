From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: support xattr security labels
Date: Fri, 07 Jun 2013 17:09:40 +0900
Message-ID: <1370592580.3600.42.camel@kjgkr>
References: <1370584557-20592-1-git-send-email-jaegeuk.kim@samsung.com>
	<1370584557-20592-2-git-send-email-jaegeuk.kim@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0919682092080704708=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UkrlL-0004rh-9X
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 08:11:07 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UkrlH-000863-96 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 08:11:07 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MO0000PJK1ZEUV0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 17:10:56 +0900 (KST)
In-reply-to: <1370584557-20592-2-git-send-email-jaegeuk.kim@samsung.com>
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


--===============0919682092080704708==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-GQNmxQQ94a9hxEEMjeIu"


--=-GQNmxQQ94a9hxEEMjeIu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Change log from v1:
 o fix a bug

=46rom 901aea226653e26aa3556edd88ca1e48fa89eb5f Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Mon, 3 Jun 2013 19:46:19 +0900
Subject: [PATCH 2/2] f2fs: support xattr security labels
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs=
-devel@lists.sourceforge.net

This patch adds the support of security labels for f2fs, which will be used
by SElinux.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/Kconfig |  9 +++++++++
 fs/f2fs/dir.c   |  5 +++++
 fs/f2fs/xattr.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 fs/f2fs/xattr.h | 12 +++++++++++-
 4 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index fd27e7e..2214cc9 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -51,3 +51,12 @@ config F2FS_FS_POSIX_ACL
 	  Linux website <http://acl.bestbits.at/>.
=20
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
=20
 static unsigned long dir_blocks(struct inode *inode)
 {
@@ -334,6 +335,10 @@ static struct page *init_inode_metadata(struct inode *=
inode,
 		if (err)
 			goto error;
=20
+		err =3D f2fs_init_security(inode, dir, name);
+		if (err)
+			goto error;
+
 		wait_on_page_writeback(page);
 	} else {
 		page =3D get_node_page(F2FS_SB(dir->i_sb), inode->i_ino);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ae61f35..67ef1a5 100644
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
@@ -43,6 +44,10 @@ static size_t f2fs_xattr_generic_list(struct dentry *den=
try, char *list,
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
@@ -70,13 +75,14 @@ static int f2fs_xattr_generic_get(struct dentry *dentry=
, const char *name,
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
 static int f2fs_xattr_generic_set(struct dentry *dentry, const char *name,
@@ -93,6 +99,8 @@ static int f2fs_xattr_generic_set(struct dentry *dentry, =
const char *name,
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		break;
+	case F2FS_XATTR_INDEX_SECURITY:
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -145,6 +153,40 @@ static int f2fs_xattr_advise_set(struct dentry *dentry=
, const char *name,
 	return 0;
 }
=20
+#ifdef CONFIG_F2FS_FS_SECURITY
+static int f2fs_initxattrs(struct inode *inode, const struct xattr *xattr_=
array,
+		void *fs_info)
+{
+	const struct xattr *xattr;
+	char *name;
+	int err =3D 0;
+
+	for (xattr =3D xattr_array; xattr->name !=3D NULL; xattr++) {
+		name =3D kmalloc(XATTR_SECURITY_PREFIX_LEN +
+			       strlen(xattr->name) + 1, GFP_NOFS);
+		if (!name) {
+			err =3D -ENOMEM;
+			break;
+		}
+		strcpy(name, XATTR_SECURITY_PREFIX);
+		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
+		err =3D f2fs_setxattr(inode, F2FS_XATTR_INDEX_SECURITY, name,
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
 const struct xattr_handler f2fs_xattr_user_handler =3D {
 	.prefix	=3D XATTR_USER_PREFIX,
 	.flags	=3D F2FS_XATTR_INDEX_USER,
@@ -169,6 +211,14 @@ const struct xattr_handler f2fs_xattr_advise_handler =
=3D {
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
@@ -176,6 +226,9 @@ static const struct xattr_handler *f2fs_xattr_handler_m=
ap[] =3D {
 	[F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT] =3D &f2fs_xattr_acl_default_handler,
 #endif
 	[F2FS_XATTR_INDEX_TRUSTED] =3D &f2fs_xattr_trusted_handler,
+#ifdef CONFIG_F2FS_FS_SECURITY
+	[F2FS_XATTR_INDEX_SECURITY] =3D &f2fs_xattr_security_handler,
+#endif
 	[F2FS_XATTR_INDEX_ADVISE] =3D &f2fs_xattr_advise_handler,
 };
=20
@@ -186,6 +239,9 @@ const struct xattr_handler *f2fs_xattr_handlers[] =3D {
 	&f2fs_xattr_acl_default_handler,
 #endif
 	&f2fs_xattr_trusted_handler,
+#ifdef CONFIG_F2FS_FS_SECURITY
+	&f2fs_xattr_security_handler,
+#endif
 	&f2fs_xattr_advise_handler,
 	NULL,
 };
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 49c9558..14e1329 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -112,6 +112,7 @@ extern const struct xattr_handler f2fs_xattr_trusted_ha=
ndler;
 extern const struct xattr_handler f2fs_xattr_acl_access_handler;
 extern const struct xattr_handler f2fs_xattr_acl_default_handler;
 extern const struct xattr_handler f2fs_xattr_advise_handler;
+extern const struct xattr_handler f2fs_xattr_security_handler;
=20
 extern const struct xattr_handler *f2fs_xattr_handlers[];
=20
@@ -121,7 +122,6 @@ extern int f2fs_getxattr(struct inode *inode, int name_=
index, const char *name,
 		void *buffer, size_t buffer_size);
 extern ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer,
 		size_t buffer_size);
-
 #else
=20
 #define f2fs_xattr_handlers	NULL
@@ -142,4 +142,14 @@ static inline ssize_t f2fs_listxattr(struct dentry *de=
ntry, char *buffer,
 }
 #endif
=20
+#ifdef CONFIG_F2FS_FS_SECURITY
+extern int f2fs_init_security(struct inode *inode, struct inode *dir,
+				const struct qstr *qstr);
+#else
+static inline int f2fs_init_security(struct inode *inode, struct inode *di=
r,
+				const struct qstr *qstr)
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

--=-GQNmxQQ94a9hxEEMjeIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRsZVEAAoJEEAUqH6CSFDSYVUP/1lBZ5ig2fnxKW33HWdSn4Oo
Em+XzgrSqDzihfUWaPQvfgXiwiYDlW32EnOK0szK5IWrGMF+nJ5EaB+/jklZPspv
0uPXIe2wtygEj2jpWo407NWfF5KmRA1NWWR60kS8Ft2Nb5MzrAWcXGIDTWGcosUb
0egYVjbkPwwjFA6/XeTqW77i6SqT2XjV5IEoinjiQXRyy+O9g2+oZM+ChhzaE5Ms
IXeFGKFcw9qqeOolPpdlp9w0frPD8nf3EcvcOGAza+AdH6gioUM3kzAU+Uq6VmMD
eG3MAVgGI1HEeM3Wrwxze5D86s7qIJe78fdNW1tAmLiQZ4ZZIG8YoRpGDp7e98CJ
/FCQybDoLrQ1Xfn+2BhtkAJOWakICcPBwuTlip5Mr/O4yW1wrDHInwiZMThX5DXh
8/1mxNL3/Kpsae371gfiI0ltyVSSeH/2oZc7Dw2wI3hBQeqYDsCVaCKurozJqOLM
ctp3jhA1sWIwECnxdFInpijIAoyLFCh4Bgjk8wJ/dGrHgoiM+lcHmVZohwH3A9BV
jrm1b39vgMIrFMXlOjba7uvNb1vNAdwXvdLdaVm/g+vJXrTgd5kyeUY6qiDh9CjJ
mfuZQYYYaJFTAAdBuZC8jeuxcCjA5oo8C97i5b4HSMMI9Pt9A9zy5HpHweI1nq+k
K41w3Dq8Fz7x9u/ZBQD5
=nwz2
-----END PGP SIGNATURE-----

--=-GQNmxQQ94a9hxEEMjeIu--



--===============0919682092080704708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
--===============0919682092080704708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============0919682092080704708==--
