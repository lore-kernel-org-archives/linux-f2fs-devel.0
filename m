From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: copy all valid xattr data includes the
	last zero
Date: Sat, 18 Mar 2017 09:23:27 +0800
Message-ID: <b70f5f84-a4e9-c0e2-d654-5a257eeffa35@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cp35m-0002za-5s
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 01:23:38 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cp35l-0007Fh-AF
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 01:23:38 +0000
Received: by mail-it0-f68.google.com with SMTP id g138so7119149itb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 18:23:37 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

It's better coping all valid xattr data includes the last zero. 

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/xattr.c | 4 ++--
 fs/f2fs/xattr.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index aff7619..41785c9 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -249,7 +249,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	void *cur_addr, *txattr_addr, *last_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
-	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
+	unsigned int size = xnid ? MAX_XATTR_BLOCK_SIZE : 0;
 	unsigned int inline_size = 0;
 	int err = 0;
 
@@ -328,7 +328,7 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_header *header;
-	size_t size = PAGE_SIZE, inline_size = 0;
+	size_t size = MAX_XATTR_BLOCK_SIZE, inline_size = 0;
 	void *txattr_addr;
 	int err;
 
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index d5a9492..629c8ae 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -73,9 +73,9 @@ struct f2fs_xattr_entry {
 				!IS_XATTR_LAST_ENTRY(entry);\
 				entry = XATTR_NEXT_ENTRY(entry))
 #define MAX_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
-#define VALID_XATTR_BLOCK_SIZE	(MAX_XATTR_BLOCK_SIZE - sizeof(__u32))
+/* A __u32 is reserved for the last entry as zero */
 #define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
-						VALID_XATTR_BLOCK_SIZE)
+				MAX_XATTR_BLOCK_SIZE - sizeof(__u32))
 
 #define MAX_VALUE_LEN(i)	(MIN_OFFSET(i) -			\
 				sizeof(struct f2fs_xattr_header) -	\
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
