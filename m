From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs-tools: add c++ for UNUSED
Date: Mon,  4 Mar 2019 14:17:16 -0800
Message-ID: <20190304221716.36174-2-jaegeuk@kernel.org>
References: <20190304221716.36174-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1h0vtm-0007Kg-0a
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 22:17:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h0vtk-003Sbr-BQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 22:17:25 +0000
In-Reply-To: <20190304221716.36174-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@google.com>

From: Jaegeuk Kim <jaegeuk@google.com>

This can avoid build failure for f2fscrypt.

Change-Id: I33eddc62eea486dc219c25d089112e011864dd4f
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 include/f2fs_fs.h       | 2 ++
 tools/f2fs_io/f2fs_io.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index a730688..8d1490c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -52,6 +52,8 @@
 # define UNUSED(x) UNUSED_ ## x __attribute__((unused))
 #elif defined(__LCLINT__)
 # define UNUSED(x) x
+#elif defined(__cplusplus)
+# define UNUSED(x)
 #else
 # define UNUSED(x) x
 #endif
diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
index 6b619bd..95fd5be 100644
--- a/tools/f2fs_io/f2fs_io.h
+++ b/tools/f2fs_io/f2fs_io.h
@@ -17,6 +17,8 @@
 # define UNUSED(x) UNUSED_ ## x __attribute__((unused))
 #elif defined(__LCLINT__)
 # define UNUSED(x) x
+#elif defined(__cplusplus)
+# define UNUSED(x)
 #else
 # define UNUSED(x) x
 #endif
-- 
2.19.0.605.g01d371f741-goog
