From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 10/11] f2fs: reuse make_empty_dir code for
	inline_dentry
Date: Sun, 19 Oct 2014 22:19:38 -0700
Message-ID: <1413782379-11758-10-git-send-email-jaegeuk@kernel.org>
References: <1413782379-11758-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Nw-0004wD-Ff
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:20:00 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Nv-0006iD-Gz for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:20:00 +0000
In-Reply-To: <1413782379-11758-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch introduces do_make_empty_dir to mitigate code redundancy
for inline_dentry.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c    | 42 ++++++++++++++++++++++++++----------------
 fs/f2fs/f2fs.h   |  2 ++
 fs/f2fs/inline.c | 20 +++-----------------
 3 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 80665ce..b751f94 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -322,12 +322,35 @@ int update_dent_inode(struct inode *inode, const struct qstr *name)
 	return 0;
 }
 
+void do_make_empty_dir(struct inode *inode, struct inode *parent,
+					struct f2fs_dentry_ptr *d)
+{
+	struct f2fs_dir_entry *de;
+
+	de = &d->dentry[0];
+	de->name_len = cpu_to_le16(1);
+	de->hash_code = 0;
+	de->ino = cpu_to_le32(inode->i_ino);
+	memcpy(d->filename[0], ".", 1);
+	set_de_type(de, inode);
+
+	de = &d->dentry[1];
+	de->hash_code = 0;
+	de->name_len = cpu_to_le16(2);
+	de->ino = cpu_to_le32(parent->i_ino);
+	memcpy(d->filename[1], "..", 2);
+	set_de_type(de, inode);
+
+	test_and_set_bit_le(0, (void *)d->bitmap);
+	test_and_set_bit_le(1, (void *)d->bitmap);
+}
+
 static int make_empty_dir(struct inode *inode,
 		struct inode *parent, struct page *page)
 {
 	struct page *dentry_page;
 	struct f2fs_dentry_block *dentry_blk;
-	struct f2fs_dir_entry *de;
+	struct f2fs_dentry_ptr d;
 
 	if (f2fs_has_inline_dentry(inode))
 		return make_empty_inline_dir(inode, parent, page);
@@ -338,22 +361,9 @@ static int make_empty_dir(struct inode *inode,
 
 	dentry_blk = kmap_atomic(dentry_page);
 
-	de = &dentry_blk->dentry[0];
-	de->name_len = cpu_to_le16(1);
-	de->hash_code = 0;
-	de->ino = cpu_to_le32(inode->i_ino);
-	memcpy(dentry_blk->filename[0], ".", 1);
-	set_de_type(de, inode);
-
-	de = &dentry_blk->dentry[1];
-	de->hash_code = 0;
-	de->name_len = cpu_to_le16(2);
-	de->ino = cpu_to_le32(parent->i_ino);
-	memcpy(dentry_blk->filename[1], "..", 2);
-	set_de_type(de, inode);
+	make_dentry_ptr(&d, dentry_blk, NULL, 1);
+	do_make_empty_dir(inode, parent, &d);
 
-	test_and_set_bit_le(0, &dentry_blk->dentry_bitmap);
-	test_and_set_bit_le(1, &dentry_blk->dentry_bitmap);
 	kunmap_atomic(dentry_blk);
 
 	set_page_dirty(dentry_page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0856a38..267d54e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1274,6 +1274,8 @@ struct f2fs_dir_entry *find_target_dentry(struct qstr *, int *,
 			struct f2fs_dentry_ptr *);
 bool f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
 			unsigned int);
+void do_make_empty_dir(struct inode *, struct inode *,
+			struct f2fs_dentry_ptr *);
 struct page *init_inode_metadata(struct inode *, struct inode *,
 			const struct qstr *, struct page *);
 void update_parent_metadata(struct inode *, struct inode *, unsigned int);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index edacfa1..825995f 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -314,26 +314,12 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 							struct page *ipage)
 {
 	struct f2fs_inline_dentry *dentry_blk;
-	struct f2fs_dir_entry *de;
+	struct f2fs_dentry_ptr d;
 
 	dentry_blk = inline_data_addr(ipage);
 
-	de = &dentry_blk->dentry[0];
-	de->name_len = cpu_to_le16(1);
-	de->hash_code = 0;
-	de->ino = cpu_to_le32(inode->i_ino);
-	memcpy(dentry_blk->filename[0], ".", 1);
-	set_de_type(de, inode);
-
-	de = &dentry_blk->dentry[1];
-	de->hash_code = 0;
-	de->name_len = cpu_to_le16(2);
-	de->ino = cpu_to_le32(parent->i_ino);
-	memcpy(dentry_blk->filename[1], "..", 2);
-	set_de_type(de, inode);
-
-	test_and_set_bit_le(0, &dentry_blk->dentry_bitmap);
-	test_and_set_bit_le(1, &dentry_blk->dentry_bitmap);
+	make_dentry_ptr(&d, NULL, dentry_blk, 2);
+	do_make_empty_dir(inode, parent, &d);
 
 	set_page_dirty(ipage);
 
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
