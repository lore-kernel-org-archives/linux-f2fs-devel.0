From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 2/2] f2fs: avoid new_inode's flags overwrite the
	old_node
Date: Sat, 4 Mar 2017 21:44:04 +0800
Message-ID: <fdfcad9e-36e6-a163-e42b-abe414c2ca9d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1ck9yw-0006CR-OM
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Mar 2017 13:44:22 +0000
Received: from mail-io0-f194.google.com ([209.85.223.194])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ck9yv-0006OO-Tz
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Mar 2017 13:44:22 +0000
Received: by mail-io0-f194.google.com with SMTP id f103so9420728ioi.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 04 Mar 2017 05:44:21 -0800 (PST)
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

Note, rename with old_inode (enc_name) and new_inode (no_enc_name),
the result will be old_indoe(enc_name) and new_inode(enc_name).

Needs swap the enc_name flags?
If needed, this patch needs update of clear the flags.
otherwise, this patch only fix the logic with any result changing.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/namei.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3231a0a..db2ab7f 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -846,6 +846,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct page *old_page, *new_page;
 	struct f2fs_dir_entry *old_dir_entry = NULL, *new_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry, *new_entry;
+	bool old_inode_enc = false, new_inode_enc = false;
 	int old_nlink = 0, new_nlink = 0;
 	int err = -ENOENT;
 
@@ -917,17 +918,16 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_lock_op(sbi);
 
+	old_inode_enc = file_enc_name(old_inode);
+	new_inode_enc = file_enc_name(new_inode);
+
 	err = update_dent_inode(old_inode, new_inode, &new_dentry->d_name);
 	if (err)
 		goto out_unlock;
-	if (file_enc_name(new_inode))
-		file_set_enc_name(old_inode);
 
 	err = update_dent_inode(new_inode, old_inode, &old_dentry->d_name);
 	if (err)
 		goto out_undo;
-	if (file_enc_name(old_inode))
-		file_set_enc_name(new_inode);
 
 	/* update ".." directory entry info of old dentry */
 	if (old_dir_entry)
@@ -942,6 +942,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	down_write(&F2FS_I(old_inode)->i_sem);
 	file_lost_pino(old_inode);
+	if (new_inode_enc)
+		file_set_enc_name(old_inode);
 	up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_dir->i_ctime = current_time(old_dir);
@@ -957,6 +959,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	down_write(&F2FS_I(new_inode)->i_sem);
 	file_lost_pino(new_inode);
+	if (old_inode_enc)
+		file_set_enc_name(new_inode);
 	up_write(&F2FS_I(new_inode)->i_sem);
 
 	new_dir->i_ctime = current_time(new_dir);
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
