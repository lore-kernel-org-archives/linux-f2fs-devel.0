From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs crypto: fix corrupted symlink in encrypted case
Date: Wed, 30 Mar 2016 13:26:06 -0700
Message-ID: <1459369566-62003-1-git-send-email-jaegeuk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, "stable 4 . 5+" <stable@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In the encrypted symlink case, we should check its corrupted symname after
decrypting it.
Otherwise, we can report -ENOENT incorrectly, if encrypted symname starts with
'\0'.

Cc: stable 4.5+ <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 7876f10..6214d9e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1027,12 +1027,6 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 		goto errout;
 	}
 
-	/* this is broken symlink case */
-	if (unlikely(cstr.name[0] == 0)) {
-		res = -ENOENT;
-		goto errout;
-	}
-
 	if ((cstr.len + sizeof(struct fscrypt_symlink_data) - 1) > max_size) {
 		/* Symlink data on the disk is corrupted */
 		res = -EIO;
@@ -1046,6 +1040,12 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	if (res < 0)
 		goto errout;
 
+	/* this is broken symlink case */
+	if (unlikely(pstr.name[0] == 0)) {
+		res = -ENOENT;
+		goto errout;
+	}
+
 	paddr = pstr.name;
 
 	/* Null-terminate the name */
-- 
2.6.3
