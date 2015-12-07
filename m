From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: use lock_buffer when changing superblock
Date: Mon,  7 Dec 2015 14:53:25 -0800
Message-ID: <1449528805-89661-3-git-send-email-jaegeuk@kernel.org>
References: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When modifying sb contents, we need to use lock its buffer.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a018ed3..a16dfe9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1591,7 +1591,9 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 		return err;
 
 	/* update superblock with uuid */
+	lock_buffer(sbi->raw_super_buf);
 	generate_random_uuid(sbi->raw_super->encrypt_pw_salt);
+	unlock_buffer(sbi->raw_super_buf);
 
 	err = f2fs_commit_super(sbi, false);
 
-- 
2.4.9 (Apple Git-60)
