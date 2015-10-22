From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: fix error path of ->symlink
Date: Thu, 22 Oct 2015 18:23:08 +0800
Message-ID: <031901d10cb3$bdff27b0$39fd7710$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Now, in ->symlink of f2fs, we kept the fixed invoking order between
f2fs_add_link and page_symlink since we should init node info firstly
in f2fs_add_link, then such node info can be used in page_symlink.

But we didn't fix to release meta info which was done before page_symlink
in our error path, so this will leave us corrupt symlink entry in its
parent's dentry page. Fix this issue by adding f2fs_unlink in the error
path for removing such linking.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index dfa01c8..e48b80c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -410,11 +410,14 @@ err_out:
 	 * If the symlink path is stored into inline_data, there is no
 	 * performance regression.
 	 */
-	if (!err)
+	if (!err) {
 		filemap_write_and_wait_range(inode->i_mapping, 0, p_len - 1);
 
-	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+		if (IS_DIRSYNC(dir))
+			f2fs_sync_fs(sbi->sb, 1);
+	} else {
+		f2fs_unlink(dir, dentry);
+	}
 
 	kfree(sd);
 	f2fs_fname_crypto_free_buffer(&disk_link);
-- 
2.6.1
