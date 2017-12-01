From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] mkfs.f2fs: show debug message for quota data
 writes
Date: Thu, 30 Nov 2017 21:51:53 -0800
Message-ID: <20171201055157.72846-2-jaegeuk@kernel.org>
References: <20171201055157.72846-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eKeFG-0008OL-Jv
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eKeFF-0004B0-RW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:18 +0000
In-Reply-To: <20171201055157.72846-1-jaegeuk@kernel.org>
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

This patch shows debugging message for quota.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 9fc0398..45963c8 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1118,7 +1118,8 @@ static int f2fs_write_default_quota(int qtype, unsigned int blkaddr)
 		free(filebuf);
 		return -1;
 	}
-
+	DBG(1, "\tWriting quota data, at offset %08x, %08x\n",
+					blkaddr, blkaddr + 1);
 	free(filebuf);
 	return 0;
 }
-- 
2.15.0.403.gc27cc4dac6-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
