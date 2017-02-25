From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 1/3] f2fs: Don't update the xattr data that same
	as the exist
Date: Sat, 25 Feb 2017 19:23:27 +0800
Message-ID: <caf61193-9d2a-ae74-c92e-a48cba67f6f0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1chaRz-0004oU-1B
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 11:23:43 +0000
Received: from mail-io0-f193.google.com ([209.85.223.193])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1chaRy-0002Zd-C3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 11:23:43 +0000
Received: by mail-io0-f193.google.com with SMTP id d198so1466679ioe.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 25 Feb 2017 03:23:42 -0800 (PST)
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

f2fs removes the old xattr data and appends the new data although
the new data is same as the exist.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/xattr.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index b50f6b5..dbfd5cb 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -545,6 +545,13 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	return error;
 }
 
+static bool f2fs_xattr_value_same(struct f2fs_xattr_entry *entry,
+					const void *value, size_t size)
+{
+	void *pval = entry->e_name + entry->e_name_len;
+	return (entry->e_value_size == size) && !memcmp(pval, value, size);
+}
+
 static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
 			struct page *ipage, int flags)
@@ -579,12 +586,17 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 
 	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
 
-	if ((flags & XATTR_REPLACE) && !found) {
+	if (found) {
+		if ((flags & XATTR_CREATE)) {
+			error = -EEXIST;
+			goto exit;
+		}
+
+		if (f2fs_xattr_value_same(here, value, size))
+			goto exit;
+	} else if ((flags & XATTR_REPLACE)) {
 		error = -ENODATA;
 		goto exit;
-	} else if ((flags & XATTR_CREATE) && found) {
-		error = -EEXIST;
-		goto exit;
 	}
 
 	last = here;
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
