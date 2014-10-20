From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/11] f2fs: reuse core function in f2fs_readdir
	for inline_dentry
Date: Sun, 19 Oct 2014 22:19:35 -0700
Message-ID: <1413782379-11758-7-git-send-email-jaegeuk@kernel.org>
References: <1413782379-11758-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Nw-0004wN-Tp
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:20:00 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Nv-0004ei-UO for linux-f2fs-devel@lists.sourceforge.net;
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

This patch introduces a core function, f2fs_fill_dentries, to remove
redundant code in f2fs_readdir and f2fs_read_inline_dir.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c    | 64 +++++++++++++++++++++++++++++++++-----------------------
 fs/f2fs/f2fs.h   |  3 +++
 fs/f2fs/inline.c | 39 +++++++---------------------------
 3 files changed, 48 insertions(+), 58 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 334e227..721d061 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -705,23 +705,50 @@ bool f2fs_empty_dir(struct inode *dir)
 	return true;
 }
 
+bool f2fs_fill_dentries(struct dir_context *ctx,
+			const void *bitmap, struct f2fs_dir_entry *dentry,
+			__u8 (*filenames)[F2FS_SLOT_LEN], int max,
+			unsigned int start_pos)
+{
+	unsigned char d_type = DT_UNKNOWN;
+	unsigned int bit_pos;
+	struct f2fs_dir_entry *de = NULL;
+
+	bit_pos = ((unsigned long)ctx->pos % max);
+
+	while (bit_pos < max) {
+		bit_pos = find_next_bit_le(bitmap, max, bit_pos);
+		if (bit_pos >= max)
+			break;
+
+		de = &dentry[bit_pos];
+		if (de->file_type < F2FS_FT_MAX)
+			d_type = f2fs_filetype_table[de->file_type];
+		else
+			d_type = DT_UNKNOWN;
+		if (!dir_emit(ctx, filenames[bit_pos],
+					le16_to_cpu(de->name_len),
+					le32_to_cpu(de->ino), d_type))
+			return true;
+
+		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
+		ctx->pos = start_pos + bit_pos;
+	}
+	return false;
+}
+
 static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
 	unsigned long npages = dir_blocks(inode);
-	unsigned int bit_pos = 0;
 	struct f2fs_dentry_block *dentry_blk = NULL;
-	struct f2fs_dir_entry *de = NULL;
 	struct page *dentry_page = NULL;
 	struct file_ra_state *ra = &file->f_ra;
 	unsigned int n = ((unsigned long)ctx->pos / NR_DENTRY_IN_BLOCK);
-	unsigned char d_type = DT_UNKNOWN;
 
 	if (f2fs_has_inline_dentry(inode))
 		return f2fs_read_inline_dir(file, ctx);
 
-	bit_pos = ((unsigned long)ctx->pos % NR_DENTRY_IN_BLOCK);
-
 	/* readahead for multi pages of dir */
 	if (npages - n > 1 && !ra_has_index(ra, n))
 		page_cache_sync_readahead(inode->i_mapping, ra, file, n,
@@ -733,28 +760,13 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 			continue;
 
 		dentry_blk = kmap(dentry_page);
-		while (bit_pos < NR_DENTRY_IN_BLOCK) {
-			bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
-							NR_DENTRY_IN_BLOCK,
-							bit_pos);
-			if (bit_pos >= NR_DENTRY_IN_BLOCK)
-				break;
-
-			de = &dentry_blk->dentry[bit_pos];
-			if (de->file_type < F2FS_FT_MAX)
-				d_type = f2fs_filetype_table[de->file_type];
-			else
-				d_type = DT_UNKNOWN;
-			if (!dir_emit(ctx,
-					dentry_blk->filename[bit_pos],
-					le16_to_cpu(de->name_len),
-					le32_to_cpu(de->ino), d_type))
-				goto stop;
 
-			bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
-			ctx->pos = n * NR_DENTRY_IN_BLOCK + bit_pos;
-		}
-		bit_pos = 0;
+		if (f2fs_fill_dentries(ctx,
+				&dentry_blk->dentry_bitmap, dentry_blk->dentry,
+				dentry_blk->filename,
+				NR_DENTRY_IN_BLOCK, n * NR_DENTRY_IN_BLOCK))
+			goto stop;
+
 		ctx->pos = (n + 1) * NR_DENTRY_IN_BLOCK;
 		kunmap(dentry_page);
 		f2fs_put_page(dentry_page, 1);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9c4c8d1..3b0f490 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1247,6 +1247,9 @@ extern unsigned char f2fs_filetype_table[F2FS_FT_MAX];
 void set_de_type(struct f2fs_dir_entry *, struct inode *);
 struct f2fs_dir_entry *find_target_dentry(struct qstr *, int *, const void *,
 			struct f2fs_dir_entry *, __u8 (*)[F2FS_SLOT_LEN]);
+bool f2fs_fill_dentries(struct dir_context *,
+			const void *, struct f2fs_dir_entry *,
+			__u8 (*)[F2FS_SLOT_LEN], int, unsigned int);
 struct page *init_inode_metadata(struct inode *, struct inode *,
 			const struct qstr *, struct page *);
 void update_parent_metadata(struct inode *, struct inode *, unsigned int);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 633d5e8..403c8f7 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -519,49 +519,24 @@ bool f2fs_empty_inline_dir(struct inode *dir)
 int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	unsigned int bit_pos = 0;
 	struct f2fs_inline_dentry *inline_dentry = NULL;
-	struct f2fs_dir_entry *de = NULL;
 	struct page *ipage = NULL;
-	unsigned char d_type = DT_UNKNOWN;
 
 	if (ctx->pos == NR_INLINE_DENTRY)
 		return 0;
 
-	ipage = get_node_page(sbi, inode->i_ino);
+	ipage = get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
-	bit_pos = ((unsigned long)ctx->pos % NR_INLINE_DENTRY);
-
 	inline_dentry = inline_data_addr(ipage);
-	while (bit_pos < NR_INLINE_DENTRY) {
-		bit_pos = find_next_bit_le(&inline_dentry->dentry_bitmap,
-						NR_INLINE_DENTRY,
-						bit_pos);
-		if (bit_pos >= NR_INLINE_DENTRY)
-			break;
-
-		de = &inline_dentry->dentry[bit_pos];
-		if (de->file_type < F2FS_FT_MAX)
-			d_type = f2fs_filetype_table[de->file_type];
-		else
-			d_type = DT_UNKNOWN;
-
-		if (!dir_emit(ctx,
-				inline_dentry->filename[bit_pos],
-				le16_to_cpu(de->name_len),
-				le32_to_cpu(de->ino), d_type))
-			goto out;
-
-		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
-		ctx->pos = bit_pos;
-	}
 
-	ctx->pos = NR_INLINE_DENTRY;
-out:
-	f2fs_put_page(ipage, 1);
+	if (!f2fs_fill_dentries(ctx, &inline_dentry->dentry_bitmap,
+				inline_dentry->dentry,
+				inline_dentry->filename,
+				NR_INLINE_DENTRY, 0))
+		ctx->pos = NR_INLINE_DENTRY;
 
+	f2fs_put_page(ipage, 1);
 	return 0;
 }
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
