From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/6] f2fs-tools: build tools selectively
Date: Thu, 30 Nov 2017 21:51:52 -0800
Message-ID: <20171201055157.72846-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eKeFG-0008M7-71
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eKeFF-0008Qt-EA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:18 +0000
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

This patch enables to build tools except mkfs.f2fs selectively.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c       | 11 ++++++++++-
 include/f2fs_fs.h |  5 +++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 543c10f..9d9cc0c 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -637,23 +637,32 @@ fsck_again:
 	case FSCK:
 		do_fsck(sbi);
 		break;
+#ifdef WITH_DUMP
 	case DUMP:
 		do_dump(sbi);
 		break;
-#ifndef WITH_ANDROID
+#endif
+#ifdef WITH_DEFRAG
 	case DEFRAG:
 		ret = do_defrag(sbi);
 		if (ret)
 			goto out_err;
 		break;
+#endif
+#ifdef WITH_RESIZE
 	case RESIZE:
 		if (do_resize(sbi))
 			goto out_err;
 		break;
+#endif
+#ifdef WITH_SLOAD
 	case SLOAD:
 		do_sload(sbi);
 		break;
 #endif
+	default:
+		ERR_MSG("Wrong program name\n");
+		ASSERT(0);
 	}
 
 	f2fs_do_umount(sbi);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 2b39d12..7e766a8 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -22,6 +22,11 @@
 
 #ifdef WITH_ANDROID
 #include <android_config.h>
+#else
+#define WITH_DUMP
+#define WITH_DEFRAG
+#define WITH_RESIZE
+#define WITH_SLOAD
 #endif
 
 #include <inttypes.h>
-- 
2.15.0.403.gc27cc4dac6-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
