From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/8] fs crypto: add Makefile and Kconfig
Date: Mon, 15 Feb 2016 18:13:10 -0800
Message-ID: <1455588792-87825-6-git-send-email-jaegeuk@kernel.org>
References: <1455588792-87825-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aVVAY-0002Kx-D3
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 Feb 2016 02:15:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aVVAX-0007oK-LH
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 Feb 2016 02:15:14 +0000
In-Reply-To: <1455588792-87825-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds a facility to enable per-file encryption.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/Kconfig         |  2 ++
 fs/Makefile        |  1 +
 fs/crypto/Kconfig  | 16 ++++++++++++++++
 fs/crypto/Makefile |  2 ++
 4 files changed, 21 insertions(+)
 create mode 100644 fs/crypto/Kconfig
 create mode 100644 fs/crypto/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 9adee0d..9d75767 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -84,6 +84,8 @@ config MANDATORY_FILE_LOCKING
 
 	  To the best of my knowledge this is dead code that no one cares about.
 
+source "fs/crypto/Kconfig"
+
 source "fs/notify/Kconfig"
 
 source "fs/quota/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 79f5225..47571e2 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_EVENTFD)		+= eventfd.o
 obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
 obj-$(CONFIG_AIO)               += aio.o
 obj-$(CONFIG_FS_DAX)		+= dax.o
+obj-y				+= crypto/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
 obj-$(CONFIG_COMPAT)		+= compat.o compat_ioctl.o
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
new file mode 100644
index 0000000..fc5a4f9
--- /dev/null
+++ b/fs/crypto/Kconfig
@@ -0,0 +1,16 @@
+config FS_ENCRYPTION
+	bool "FS Encryption (Per-file encryption)"
+	select CRYPTO_AES
+	select CRYPTO_CBC
+	select CRYPTO_ECB
+	select CRYPTO_XTS
+	select CRYPTO_CTS
+	select CRYPTO_CTR
+	select CRYPTO_SHA256
+	select KEYS
+	select ENCRYPTED_KEYS
+	help
+	  Enable encryption of files and directories.  This
+	  feature is similar to ecryptfs, but it is more memory
+	  efficient since it avoids caching the encrypted and
+	  decrypted pages in the page cache.
diff --git a/fs/crypto/Makefile b/fs/crypto/Makefile
new file mode 100644
index 0000000..f9f68cd
--- /dev/null
+++ b/fs/crypto/Makefile
@@ -0,0 +1,2 @@
+obj-y += fname.o
+obj-$(CONFIG_FS_ENCRYPTION)	+= crypto.o policy.o keyinfo.o
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
