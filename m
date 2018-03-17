From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 3/4] mkfs.f2fs: remove 'a' from cold_ext_lists[]
Date: Sun, 18 Mar 2018 00:02:56 +0900
Message-ID: <20180317150257.123927-3-qkrwngud825@gmail.com>
References: <20180317150257.123927-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1exDNi-00061N-0G
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:04:26 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-pl0-f66.google.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1exDNa-00BmIt-JW
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:04:25 +0000
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so3924097plq.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Mar 2018 08:04:18 -0700 (PDT)
In-Reply-To: <20180317150257.123927-1-qkrwngud825@gmail.com>
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

While '.a' are archive files,
there are many other file types starting with 'a'.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 mkfs/f2fs_format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 47834a6..10ccca0 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -69,7 +69,7 @@ const char *cold_ext_lists[] = {
 
 	/* archive */
 	"7z",
-	"a",
+	// "a", there are many other file types starting with 'a'.
 	"deb",
 	"gz",
 	"iso",
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
