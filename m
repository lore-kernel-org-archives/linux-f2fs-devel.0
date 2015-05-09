From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/18] f2fs crypto: add f2fs encryption Kconfig
Date: Fri,  8 May 2015 21:20:39 -0700
Message-ID: <1431145253-2019-4-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Michael Halcrow <mhalcrow@google.com>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds f2fs encryption config.

Signed-off-by: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 05f0f66..28f21fe 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -72,6 +72,24 @@ config F2FS_CHECK_FS
 
 	  If you want to improve the performance, say N.
 
+config F2FS_FS_ENCRYPTION
+	bool "F2FS Encryption"
+	depends on F2FS_FS
+	depends on F2FS_FS_XATTR
+	select CRYPTO_AES
+	select CRYPTO_CBC
+	select CRYPTO_ECB
+	select CRYPTO_XTS
+	select CRYPTO_CTS
+	select CRYPTO_SHA256
+	select KEYS
+	select ENCRYPTED_KEYS
+	help
+	  Enable encryption of f2fs files and directories.  This
+	  feature is similar to ecryptfs, but it is more memory
+	  efficient since it avoids caching the encrypted and
+	  decrypted pages in the page cache.
+
 config F2FS_IO_TRACE
 	bool "F2FS IO tracer"
 	depends on F2FS_FS
-- 
2.1.1

