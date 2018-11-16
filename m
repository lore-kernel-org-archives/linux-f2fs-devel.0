From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs-tools: show versions if exist
Date: Thu, 15 Nov 2018 22:06:02 -0800
Message-ID: <20181116060603.51965-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gNXGh-0000CC-AT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Nov 2018 06:06:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gNXGg-005EYe-2F
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Nov 2018 06:06:15 +0000
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

If it's not defined, we need to skip to show the definition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index cdf54e5..65cc8fd 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1326,7 +1326,11 @@ static inline int is_qf_ino(struct f2fs_super_block *sb, nid_t ino)
 
 static inline void show_version(const char *prog)
 {
+#if defined(F2FS_TOOLS_VERSION) && defined(F2FS_TOOLS_DATE)
 	MSG(0, "%s %s (%s)\n", prog, F2FS_TOOLS_VERSION, F2FS_TOOLS_DATE);
+#else
+	MSG(0, "%s -- version not supported\n", prog);
+#endif
 }
 
 struct feature {
-- 
2.19.0.605.g01d371f741-goog
