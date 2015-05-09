From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 12/18] f2fs crypto: add filename encryption for
	f2fs_add_link
Date: Fri,  8 May 2015 21:20:47 -0700
Message-ID: <1431145253-2019-12-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGk-0002X1-BJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGj-0004fB-Fn for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:42 +0000
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds filename encryption support for f2fs_add_link.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f7293a2..750a688 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -507,24 +507,33 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 	unsigned long bidx, block;
 	f2fs_hash_t dentry_hash;
 	unsigned int nbucket, nblock;
-	size_t namelen = name->len;
 	struct page *dentry_page = NULL;
 	struct f2fs_dentry_block *dentry_blk = NULL;
 	struct f2fs_dentry_ptr d;
-	int slots = GET_DENTRY_SLOTS(namelen);
 	struct page *page = NULL;
-	int err = 0;
+	struct f2fs_filename fname;
+	struct qstr new_name;
+	int slots, err;
+
+	err = f2fs_fname_setup_filename(dir, name, 0, &fname);
+	if (err)
+		return err;
+
+	new_name.name = fname_name(&fname);
+	new_name.len = fname_len(&fname);
 
 	if (f2fs_has_inline_dentry(dir)) {
-		err = f2fs_add_inline_entry(dir, name, inode, ino, mode);
+		err = f2fs_add_inline_entry(dir, &new_name, inode, ino, mode);
 		if (!err || err != -EAGAIN)
-			return err;
+			goto out;
 		else
 			err = 0;
 	}
 
-	dentry_hash = f2fs_dentry_hash(name);
 	level = 0;
+	slots = GET_DENTRY_SLOTS(new_name.len);
+	dentry_hash = f2fs_dentry_hash(&new_name);
+
 	current_depth = F2FS_I(dir)->i_current_depth;
 	if (F2FS_I(dir)->chash == dentry_hash) {
 		level = F2FS_I(dir)->clevel;
@@ -532,8 +541,10 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 	}
 
 start:
-	if (unlikely(current_depth == MAX_DIR_HASH_DEPTH))
-		return -ENOSPC;
+	if (unlikely(current_depth == MAX_DIR_HASH_DEPTH)) {
+		err = -ENOSPC;
+		goto out;
+	}
 
 	/* Increase the depth, if required */
 	if (level == current_depth)
@@ -547,8 +558,10 @@ start:
 
 	for (block = bidx; block <= (bidx + nblock - 1); block++) {
 		dentry_page = get_new_data_page(dir, NULL, block, true);
-		if (IS_ERR(dentry_page))
-			return PTR_ERR(dentry_page);
+		if (IS_ERR(dentry_page)) {
+			err = PTR_ERR(dentry_page);
+			goto out;
+		}
 
 		dentry_blk = kmap(dentry_page);
 		bit_pos = room_for_filename(&dentry_blk->dentry_bitmap,
@@ -568,7 +581,7 @@ add_dentry:
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
-		page = init_inode_metadata(inode, dir, name, NULL);
+		page = init_inode_metadata(inode, dir, &new_name, NULL);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			goto fail;
@@ -576,7 +589,7 @@ add_dentry:
 	}
 
 	make_dentry_ptr(&d, (void *)dentry_blk, 1);
-	f2fs_update_dentry(ino, mode, &d, name, dentry_hash, bit_pos);
+	f2fs_update_dentry(ino, mode, &d, &new_name, dentry_hash, bit_pos);
 
 	set_page_dirty(dentry_page);
 
@@ -598,6 +611,8 @@ fail:
 	}
 	kunmap(dentry_page);
 	f2fs_put_page(dentry_page, 1);
+out:
+	f2fs_fname_free_filename(&fname);
 	return err;
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
