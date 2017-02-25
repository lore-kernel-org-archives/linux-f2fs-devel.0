From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 2/3] f2fs: drop the duplicate pval in
	f2fs_getxattr
Date: Sat, 25 Feb 2017 19:23:40 +0800
Message-ID: <3c7eac62-9873-b7fd-17e6-0bd592442130@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1chaS6-0004Jx-GC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 11:23:50 +0000
Received: from mail-it0-f66.google.com ([209.85.214.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1chaS5-0002Zv-PW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 11:23:50 +0000
Received: by mail-it0-f66.google.com with SMTP id 203so6798501ith.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 25 Feb 2017 03:23:49 -0800 (PST)
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

Fixes: ba38c27eb9 ("f2fs: enhance lookup xattr")
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/xattr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index dbfd5cb..7298a44 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -467,7 +467,6 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	struct f2fs_xattr_entry *entry = NULL;
 	int error = 0;
 	unsigned int size, len;
-	char *pval;
 	void *base_addr = NULL;
 
 	if (name == NULL)
@@ -489,8 +488,6 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 		goto out;
 	}
 
-	pval = entry->e_name + entry->e_name_len;
-
 	if (buffer) {
 		char *pval = entry->e_name + entry->e_name_len;
 		memcpy(buffer, pval, size);
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
