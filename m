From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: set .so to cold files
Date: Thu,  2 Nov 2017 20:13:15 -0700
Message-ID: <20171103031315.10959-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1eASQA-0006Sm-As
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 03:13:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eASQ6-00062p-GR
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 03:13:26 +0000
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

This patch adds .so in cold file extention list.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 2103f9d..2ba8dd3 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -62,6 +62,7 @@ const char *media_ext_lists[] = {
 	"jpeg",
 	"video",
 	"apk",	/* for android system */
+	"so",	/* for android system */
 	NULL
 };
 
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
