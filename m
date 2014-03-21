From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/3] f2fs: avoid RECLAIM_FS-ON-W warning
Date: Fri, 21 Mar 2014 11:01:15 +0900
Message-ID: <1395367275-1674-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1395367275-1674-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WQonr-0001Ys-H3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Mar 2014 02:03:23 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WQono-0002vi-5j
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Mar 2014 02:03:23 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2R00D6XKD6JQB0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Mar 2014 11:03:06 +0900 (KST)
In-reply-to: <1395367275-1674-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch should resolve the following possible bug.

RECLAIM_FS-ON-W at:
 mark_held_locks+0xb9/0x140
 lockdep_trace_alloc+0x85/0xf0
 __kmalloc+0x53/0x1d0
 read_all_xattrs+0x3d1/0x3f0 [f2fs]
 f2fs_getxattr+0x4f/0x100 [f2fs]
 f2fs_get_acl+0x4c/0x290 [f2fs]
 get_acl+0x4f/0x80
 posix_acl_create+0x72/0x180
 f2fs_init_acl+0x29/0xcc [f2fs]
 __f2fs_add_link+0x259/0x710 [f2fs]
 f2fs_create+0xad/0x1c0 [f2fs]
 vfs_create+0xed/0x150
 do_last+0xd36/0xed0
 path_openat+0xc5/0x680
 do_filp_open+0x43/0xa0
 do_sys_open+0x13c/0x230
 SyS_creat+0x1e/0x20
 system_call_fastpath+0x16/0x1b

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/acl.c   | 2 +-
 fs/f2fs/xattr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index fa8da4c..a285715 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -174,7 +174,7 @@ struct posix_acl *f2fs_get_acl(struct inode *inode, int type)
 
 	retval = f2fs_getxattr(inode, name_index, "", NULL, 0);
 	if (retval > 0) {
-		value = kmalloc(retval, GFP_KERNEL);
+		value = kmalloc(retval, GFP_F2FS_ZERO);
 		if (!value)
 			return ERR_PTR(-ENOMEM);
 		retval = f2fs_getxattr(inode, name_index, "", value, retval);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 8419130..0121e45 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -275,7 +275,7 @@ static void *read_all_xattrs(struct inode *inode, struct page *ipage)
 
 	inline_size = inline_xattr_size(inode);
 
-	txattr_addr = kzalloc(inline_size + size, GFP_KERNEL);
+	txattr_addr = kzalloc(inline_size + size, GFP_F2FS_ZERO);
 	if (!txattr_addr)
 		return NULL;
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
