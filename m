From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: remove dead macro PGOFS_OF_NEXT_DNODE
Date: Tue, 28 Feb 2017 21:34:37 +0800
Message-ID: <695b54f3-1039-b783-a65f-03e3e525c2e6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cihvc-0004C9-PH
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 13:34:56 +0000
Received: from mail-io0-f194.google.com ([209.85.223.194])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cihvc-0005uM-3Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 13:34:56 +0000
Received: by mail-io0-f194.google.com with SMTP id n76so1421363ioe.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 28 Feb 2017 05:34:56 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Fixes: 3cf4574705 ("f2fs: introduce get_next_page_offset to speed up SEEK_DATA")
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/f2fs.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7e29249..da738c8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2032,12 +2032,6 @@ static inline void *f2fs_kvzalloc(size_t size, gfp_t flags)
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
 
-/* get offset of first page in next direct node */
-#define PGOFS_OF_NEXT_DNODE(pgofs, inode)				\
-	((pgofs < ADDRS_PER_INODE(inode)) ? ADDRS_PER_INODE(inode) :	\
-	(pgofs - ADDRS_PER_INODE(inode) + ADDRS_PER_BLOCK) /	\
-	ADDRS_PER_BLOCK * ADDRS_PER_BLOCK + ADDRS_PER_INODE(inode))
-
 /*
  * file.c
  */
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
