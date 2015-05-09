From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 15/18] f2fs crypto: add filename encryption for
	roll-forward recovery
Date: Fri,  8 May 2015 21:20:50 -0700
Message-ID: <1431145253-2019-15-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGt-0002YD-7W
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGs-0003so-1r for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:51 +0000
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

This patch adds a bit flag to indicate whether or not i_name in the inode
is encrypted.

If this name is encrypted, we can't do recover_dentry during roll-forward.
So, f2fs_sync_file() needs to do checkpoint, if this will be needed in future.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c      |  8 +++++++-
 fs/f2fs/f2fs.h     |  5 ++++-
 fs/f2fs/file.c     |  4 +++-
 fs/f2fs/namei.c    | 20 +++++++++++++++-----
 fs/f2fs/recovery.c | 13 ++++++++++++-
 5 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 5e10d9d..12f6869 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -314,10 +314,14 @@ static void init_dent_inode(const struct qstr *name, struct page *ipage)
 	set_page_dirty(ipage);
 }
 
-int update_dent_inode(struct inode *inode, const struct qstr *name)
+int update_dent_inode(struct inode *inode, struct inode *to,
+					const struct qstr *name)
 {
 	struct page *page;
 
+	if (file_enc_name(to))
+		return 0;
+
 	page = get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	if (IS_ERR(page))
 		return PTR_ERR(page);
@@ -597,6 +601,8 @@ add_dentry:
 			err = PTR_ERR(page);
 			goto fail;
 		}
+		if (f2fs_encrypted_inode(dir))
+			file_set_enc_name(inode);
 	}
 
 	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6898331..fda040b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -378,6 +378,7 @@ struct f2fs_map_blocks {
 #define FADVISE_COLD_BIT	0x01
 #define FADVISE_LOST_PINO_BIT	0x02
 #define FADVISE_ENCRYPT_BIT	0x04
+#define FADVISE_ENC_NAME_BIT	0x08
 
 #define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
 #define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
@@ -388,6 +389,8 @@ struct f2fs_map_blocks {
 #define file_is_encrypt(inode)	is_file(inode, FADVISE_ENCRYPT_BIT)
 #define file_set_encrypt(inode)	set_file(inode, FADVISE_ENCRYPT_BIT)
 #define file_clear_encrypt(inode) clear_file(inode, FADVISE_ENCRYPT_BIT)
+#define file_enc_name(inode)	is_file(inode, FADVISE_ENC_NAME_BIT)
+#define file_set_enc_name(inode) set_file(inode, FADVISE_ENC_NAME_BIT)
 
 /* Encryption algorithms */
 #define F2FS_ENCRYPTION_MODE_INVALID		0
@@ -1602,7 +1605,7 @@ struct f2fs_dir_entry *f2fs_parent_dir(struct inode *, struct page **);
 ino_t f2fs_inode_by_name(struct inode *, struct qstr *);
 void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
 				struct page *, struct inode *);
-int update_dent_inode(struct inode *, const struct qstr *);
+int update_dent_inode(struct inode *, struct inode *, const struct qstr *);
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *,
 			const struct qstr *, f2fs_hash_t , unsigned int);
 int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *, nid_t,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d7daff8..14eb4f7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -106,7 +106,7 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
 	if (!dentry)
 		return 0;
 
-	if (update_dent_inode(inode, &dentry->d_name)) {
+	if (update_dent_inode(inode, inode, &dentry->d_name)) {
 		dput(dentry);
 		return 0;
 	}
@@ -123,6 +123,8 @@ static inline bool need_do_checkpoint(struct inode *inode)
 
 	if (!S_ISREG(inode->i_mode) || inode->i_nlink != 1)
 		need_cp = true;
+	else if (file_enc_name(inode) && need_dentry_mark(sbi, inode->i_ino))
+		need_cp = true;
 	else if (file_wrong_pino(inode))
 		need_cp = true;
 	else if (!space_for_roll_forward(sbi))
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index bc8992e..c857f82 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -517,7 +517,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (err)
 			goto put_out_dir;
 
-		if (update_dent_inode(old_inode, &new_dentry->d_name)) {
+		if (update_dent_inode(old_inode, new_inode,
+						&new_dentry->d_name)) {
 			release_orphan_inode(sbi);
 			goto put_out_dir;
 		}
@@ -557,6 +558,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	down_write(&F2FS_I(old_inode)->i_sem);
 	file_lost_pino(old_inode);
+	if (new_inode && file_enc_name(new_inode))
+		file_set_enc_name(old_inode);
 	up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_inode->i_ctime = CURRENT_TIME;
@@ -659,13 +662,17 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_lock_op(sbi);
 
-	err = update_dent_inode(old_inode, &new_dentry->d_name);
+	err = update_dent_inode(old_inode, new_inode, &new_dentry->d_name);
 	if (err)
 		goto out_unlock;
+	if (file_enc_name(new_inode))
+		file_set_enc_name(old_inode);
 
-	err = update_dent_inode(new_inode, &old_dentry->d_name);
+	err = update_dent_inode(new_inode, old_inode, &old_dentry->d_name);
 	if (err)
 		goto out_undo;
+	if (file_enc_name(old_inode))
+		file_set_enc_name(new_inode);
 
 	/* update ".." directory entry info of old dentry */
 	if (old_dir_entry)
@@ -723,8 +730,11 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 out_undo:
-	/* Still we may fail to recover name info of f2fs_inode here */
-	update_dent_inode(old_inode, &old_dentry->d_name);
+	/*
+	 * Still we may fail to recover name info of f2fs_inode here
+	 * Drop it, once its name is set as encrypted
+	 */
+	update_dent_inode(old_inode, old_inode, &old_dentry->d_name);
 out_unlock:
 	f2fs_unlock_op(sbi);
 out_new_dir:
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index f77a1be..9de2587 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -83,6 +83,11 @@ static int recover_dentry(struct inode *inode, struct page *ipage)
 		goto out;
 	}
 
+	if (file_enc_name(inode)) {
+		iput(dir);
+		return 0;
+	}
+
 	name.len = le32_to_cpu(raw_inode->i_namelen);
 	name.name = raw_inode->i_name;
 
@@ -143,6 +148,7 @@ out:
 static void recover_inode(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *raw = F2FS_INODE(page);
+	char *name;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
 	i_size_write(inode, le64_to_cpu(raw->i_size));
@@ -153,8 +159,13 @@ static void recover_inode(struct inode *inode, struct page *page)
 	inode->i_ctime.tv_nsec = le32_to_cpu(raw->i_ctime_nsec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
 
+	if (file_enc_name(inode))
+		name = "<encrypted>";
+	else
+		name = F2FS_INODE(page)->i_name;
+
 	f2fs_msg(inode->i_sb, KERN_NOTICE, "recover_inode: ino = %x, name = %s",
-			ino_of_node(page), F2FS_INODE(page)->i_name);
+			ino_of_node(page), name);
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
