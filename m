From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: release 1.12.0
Date: Wed, 21 Nov 2018 11:36:44 -0800
Message-ID: <20181121193644.8360-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gPYJ5-0004lC-Jp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Nov 2018 19:37:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gPYJ0-00Bp2B-C1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Nov 2018 19:37:03 +0000
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

This release includes:
 - add android default configuration
 - fix resgid/resuid
 - add more sanity checks
 - fix corrupted quota in clean umount
 - add superblock checksum

And, there are several bug fixes in fsck.f2fs/sload.f2fs/mkfs.f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 VERSION      | 4 ++--
 configure.ac | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/VERSION b/VERSION
index bd6aefb..7ba7212 100644
--- a/VERSION
+++ b/VERSION
@@ -1,2 +1,2 @@
-1.11.0
-2018-07-10
+1.12.0
+2018-11-12
diff --git a/configure.ac b/configure.ac
index 70583cd..b02a718 100644
--- a/configure.ac
+++ b/configure.ac
@@ -212,12 +212,12 @@ AC_CONFIG_FILES([
 ])
 
 # export library version info for mkfs/libf2fs_format_la
-AC_SUBST(FMT_CURRENT, 4)
+AC_SUBST(FMT_CURRENT, 5)
 AC_SUBST(FMT_REVISION, 0)
 AC_SUBST(FMT_AGE, 0)
 
 # export library version info for lib/libf2fs_la
-AC_SUBST(LIBF2FS_CURRENT, 5)
+AC_SUBST(LIBF2FS_CURRENT, 6)
 AC_SUBST(LIBF2FS_REVISION, 0)
 AC_SUBST(LIBF2FS_AGE, 0)
 
-- 
2.19.0.605.g01d371f741-goog
