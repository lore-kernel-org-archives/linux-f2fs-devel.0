From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: increase the number of max hard
 links
Date: Fri, 14 Aug 2015 16:22:45 -0700
Message-ID: <20150814232245.GA24897@jaegeuk-mac02.mot.com>
References: <1439256205-8906-1-git-send-email-jaegeuk@kernel.org>
	<00b601d0d4e3$4d71e940$e855bbc0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZQOKV-0002U7-8X
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Aug 2015 23:24:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZQOKS-000438-UZ for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Aug 2015 23:24:07 +0000
Content-Disposition: inline
In-Reply-To: <00b601d0d4e3$4d71e940$e855bbc0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Change log from v1:
 o increase to the maximum since we have 32 bit structure

>From 448ffa6a623cae1c3537114b9d10f92d1ddf03f5 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 10 Aug 2015 15:01:12 -0700
Subject: [PATCH] f2fs: increase the number of max hard links

This patch increases the number of maximum hard links for one file.

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a55169a..00591f7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -322,7 +322,7 @@ enum {
 					 */
 };
 
-#define F2FS_LINK_MAX		32000	/* maximum link count per file */
+#define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
 
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
 
-- 
2.1.1

------------------------------------------------------------------------------
