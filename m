From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs crypto: preallocate BIO_MAX_PAGES for writeback
Date: Thu, 21 May 2015 17:40:25 -0700
Message-ID: <1432255225-76792-3-git-send-email-jaegeuk@kernel.org>
References: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch changes the number of preallocated pages to BIO_MAX_PAGES to prepare
writeback encryption.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 2ceee68..cfe5a04 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -48,7 +48,7 @@
 
 /* Encryption added and removed here! (L: */
 
-static unsigned int num_prealloc_crypto_pages = 32;
+static unsigned int num_prealloc_crypto_pages = BIO_MAX_PAGES;
 static unsigned int num_prealloc_crypto_ctxs = 128;
 
 module_param(num_prealloc_crypto_pages, uint, 0444);
-- 
2.1.1
