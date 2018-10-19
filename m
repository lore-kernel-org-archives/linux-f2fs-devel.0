From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: give WITH_KERNEL_VERSION to check
 kernel version only
Date: Fri, 19 Oct 2018 15:43:57 -0700
Message-ID: <20181019224357.11121-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gDdV0-0003q6-Ea
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Oct 2018 22:44:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gDdUz-008R0w-6u
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Oct 2018 22:44:06 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds a build option to relax kernel version and release string to
trigger full scan.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index fd3e006..bf2830d 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -744,8 +744,13 @@ void get_kernel_uname_version(__u8 *version)
 	if (uname(&buf))
 		return;
 
+#if !defined(WITH_KERNEL_VERSION)
 	snprintf((char *)version,
 		VERSION_LEN, "%s %s", buf.release, buf.version);
+#else
+	snprintf((char *)version,
+		VERSION_LEN, "%s", buf.release);
+#endif
 #else
 	memset(version, 0, VERSION_LEN);
 #endif
-- 
2.19.0.605.g01d371f741-goog
