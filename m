From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: allow zeroed name length during find_dentry
Date: Wed, 15 Jul 2015 15:38:12 -0700
Message-ID: <1436999892-86682-3-git-send-email-jaegeuk@kernel.org>
References: <1436999892-86682-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436999892-86682-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Since find_dentry doesn't lock its dentry page, it can traverse intermediate
bit positions consisting of a big dentry.
For these bit positions, this patch fills the intermediate name length fields
as zeros and skips them during look-up.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a34ebd8..71195f5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -141,11 +141,15 @@ struct f2fs_dir_entry *find_target_dentry(struct f2fs_filename *fname,
 			*max_slots = max_len;
 		max_len = 0;
 
-		/* remain bug on condition */
-		if (unlikely(!de->name_len))
-			d->max = -1;
-
-		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
+		/*
+		 * While a large dentry is adding, it can traverse its valid bit
+		 * positions, since find_entry does not lock its dentry page.
+		 * In that case, let's skip the bit position.
+		 */
+		if (de_name.len == 0)
+			bit_pos++;
+		else
+			bit_pos += GET_DENTRY_SLOTS(de_name.len);
 	}
 
 	de = NULL;
@@ -505,8 +509,12 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 	memcpy(d->filename[bit_pos], name->name, name->len);
 	de->ino = cpu_to_le32(ino);
 	set_de_type(de, mode);
-	for (i = 0; i < slots; i++)
+	for (i = 0; i < slots; i++) {
+		/* fill zeros for intermediate name_len slots */
+		if (i >= 1)
+			d->dentry[bit_pos + i].name_len = 0;
 		test_and_set_bit_le(bit_pos + i, (void *)d->bitmap);
+	}
 }
 
 /*
-- 
2.1.1
