From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: clean up opened code with f2fs_update_dentry
Date: Wed, 9 Mar 2016 22:07:28 +0800
Message-ID: <56E02E20.2060302@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

Just clean up opened code with existing function, no logic change.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/dir.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index da77e45..e37e0d5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -347,24 +347,14 @@ int update_dent_inode(struct inode *inode, struct inode *to,
 void do_make_empty_dir(struct inode *inode, struct inode *parent,
 					struct f2fs_dentry_ptr *d)
 {
-	struct f2fs_dir_entry *de;
-
-	de = &d->dentry[0];
-	de->name_len = cpu_to_le16(1);
-	de->hash_code = 0;
-	de->ino = cpu_to_le32(inode->i_ino);
-	memcpy(d->filename[0], ".", 1);
-	set_de_type(de, inode->i_mode);
+	struct qstr dot = QSTR_INIT(".", 1);
+	struct qstr dotdot = QSTR_INIT("..", 2);

-	de = &d->dentry[1];
-	de->hash_code = 0;
-	de->name_len = cpu_to_le16(2);
-	de->ino = cpu_to_le32(parent->i_ino);
-	memcpy(d->filename[1], "..", 2);
-	set_de_type(de, parent->i_mode);
+	/* update dirent of "." */
+	f2fs_update_dentry(inode->i_ino, inode->i_mode, d, &dot, 0, 0);

-	test_and_set_bit_le(0, (void *)d->bitmap);
-	test_and_set_bit_le(1, (void *)d->bitmap);
+	/* update dirent of ".." */
+	f2fs_update_dentry(parent->i_ino, parent->i_mode, d, &dotdot, 0, 1);
 }

 static int make_empty_dir(struct inode *inode,
-- 
2.7.2
