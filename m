From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH v2] f2fs: avoid freqeunt write_inode calls
Date: Tue, 11 Jun 2013 18:11:35 +0900
Message-ID: <1370941895.3600.81.camel@kjgkr>
References: <1370933734-343-1-git-send-email-jaegeuk.kim@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-XBUKe0qmdIx0c7EUz/4L"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1370933734-343-1-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net


--=-XBUKe0qmdIx0c7EUz/4L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Change log from v1:
 o declare *static* to f2fs_dirty_inode (reported by kbuild-test-robot)

=46rom 6b523242fa7b301653e83496fb065d5c0cbe7968 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Mon, 10 Jun 2013 09:17:01 +0900
Subject: [PATCH] f2fs: avoid freqeunt write_inode calls
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
linux-f2fs-devel@lists.sourceforge.net

If update_inode is called, we don't need to do write_inode.
So, let's use a *dirty* flag for each inode.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  |  1 +
 fs/f2fs/inode.c |  4 ++++
 fs/f2fs/super.c | 12 ++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 27edf59..a05aa65 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -856,6 +856,7 @@ static inline int f2fs_clear_bit(unsigned int nr,
char *addr)
 /* used for f2fs_inode_info->flags */
 enum {
 	FI_NEW_INODE,		/* indicate newly allocated inode */
+	FI_DIRTY_INODE,		/* indicate inode is dirty or not */
 	FI_INC_LINK,		/* need to increment i_nlink */
 	FI_ACL_MODE,		/* indicate acl mode */
 	FI_NO_ALLOC,		/* should not allocate any blocks */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2f649b8..fda226f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -147,6 +147,7 @@ int f2fs_sync_file(struct file *file, loff_t start,
loff_t end, int datasync)
 	} else {
 		/* if there is no written node page, write its inode page */
 		while (!sync_node_pages(sbi, inode->i_ino, &wbc)) {
+			mark_inode_dirty_sync(inode);
 			ret =3D f2fs_write_inode(inode, NULL);
 			if (ret)
 				goto out;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b44a4c1..2b2d45d1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -192,6 +192,7 @@ void update_inode(struct inode *inode, struct page
*node_page)
=20
 	set_cold_node(inode, node_page);
 	set_page_dirty(node_page);
+	clear_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
 }
=20
 int update_inode_page(struct inode *inode)
@@ -217,6 +218,9 @@ int f2fs_write_inode(struct inode *inode, struct
writeback_control *wbc)
 			inode->i_ino =3D=3D F2FS_META_INO(sbi))
 		return 0;
=20
+	if (!is_inode_flag_set(F2FS_I(inode), FI_DIRTY_INODE))
+		return 0;
+
 	if (wbc)
 		f2fs_balance_fs(sbi);
=20
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4fdcdff..ba56549 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -112,6 +112,17 @@ static int f2fs_drop_inode(struct inode *inode)
 	return generic_drop_inode(inode);
 }
=20
+/*
+ * f2fs_dirty_inode() is called from __mark_inode_dirty()
+ *
+ * We should call set_dirty_inode to write the dirty inode through
write_inode.
+ */
+static void f2fs_dirty_inode(struct inode *inode, int flags)
+{
+	set_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
+	return;
+}
+
 static void f2fs_i_callback(struct rcu_head *head)
 {
 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
@@ -249,6 +260,7 @@ static struct super_operations f2fs_sops =3D {
 	.drop_inode	=3D f2fs_drop_inode,
 	.destroy_inode	=3D f2fs_destroy_inode,
 	.write_inode	=3D f2fs_write_inode,
+	.dirty_inode	=3D f2fs_dirty_inode,
 	.show_options	=3D f2fs_show_options,
 	.evict_inode	=3D f2fs_evict_inode,
 	.put_super	=3D f2fs_put_super,
--=20
1.8.1.3.566.gaa39828



--=20
Jaegeuk Kim
Samsung

--=-XBUKe0qmdIx0c7EUz/4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRtunHAAoJEEAUqH6CSFDSCbsP/2Rz8RyX/243HPN15h2fdsah
EZhlZkaaZjUzickYaXSWkMKgo8AWm6kM59Reg0FiAd+hITf8VseSlInDoakDkYTI
srxEnAlP+IqWBWUtFQUHsBvGkyheguPNC+tE5AOUeZnpZruaO0sVHIXkdVF4urMq
vlHf+OpkWEI2L4JRZgcqDPCv+8zTq3j2YEXixWh6gYmc5oQELdiMLXWP7w0g00Qy
O/3q1INSSfLOqRmuhRz2kHf0FJ36xiT2yLM2pLHfkApbCg+JUKJxOcAdiBSgmr96
1jcgNB5hlbFos8oPrdDCFTAd9Eke3pfVRpk61vVz6lUTiDpowJRh5o98qLcMhAMS
1JhNil6DOnxgi8CwUakpETEOi2vjXFLnPbQ1b2Kat1IQqrKOsvzZzhIpQtJk10K+
/0tMquT536oxeOsmP8EpbugYUhx6nprrAF+CLkAhr2PV4eiJTpplrZkxlj67oJak
5blkl5g23DCL9670vZGDh9cOz4sqWaS9/RLXCBH4DcIBmGKWxanUXDwDHXl944x7
QFXR8V9LNYHlVl6/VQrVF6drNOITXA3jZLvLHjfiOaJRyPmFtxoKoSFb2g6eWgyI
JRBXKg2z0UoKztnUxPLrhfTTzBa/loCY7DCIyd3kXEuGBKjsSx0qE8devFLX8lsJ
9otyS2/I8T+mM3pHpO00
=mVEU
-----END PGP SIGNATURE-----

--=-XBUKe0qmdIx0c7EUz/4L--
