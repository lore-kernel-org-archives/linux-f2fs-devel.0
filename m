From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 17/18] f2fs crypto: fix missing key when reading a page
Date: Fri,  8 May 2015 21:20:52 -0700
Message-ID: <1431145253-2019-17-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

1. mount $mnt
2. cp data $mnt/
3. umount $mnt
4. log out
5. log in
6. cat $mnt/data

-> panic, due to no i_crypt_info.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 38c005c..509d19a 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -131,7 +131,9 @@ struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 	unsigned long flags;
 	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
 
-	BUG_ON(ci == NULL);
+	if (ci == NULL)
+		return ERR_PTR(-EACCES);
+
 	/*
 	 * We first try getting the ctx from a free list because in
 	 * the common case the ctx will have an allocated and
-- 
2.1.1
