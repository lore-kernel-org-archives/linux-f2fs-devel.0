From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [bug report] f2fs: fix to avoid reading out
 encrypted data in page cache
Date: Tue, 12 Jul 2016 09:44:46 -0700
Message-ID: <20160712164446.GA14203@jaegeuk>
References: <20160712132938.GA20260@mwanda>
	<04413f72-1c7c-7a87-5746-08dc3d9f362f@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bN0nm-0005gS-4R
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Jul 2016 16:44:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bN0nl-0000wf-9Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Jul 2016 16:44:54 +0000
Content-Disposition: inline
In-Reply-To: <04413f72-1c7c-7a87-5746-08dc3d9f362f@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-f2fs-devel@lists.sourceforge.net

Hello,

It seems we can write just one patch to resolve this.
Thoughts?

>From f2bd632963409ff969aa2567a38f42f4b493a4b4 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 12 Jul 2016 09:38:48 -0700
Subject: [PATCH] f2fs: fix ERR_PTR returned by bio

This is to fix wrong error pointer handling flow reported by Dan.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9017366..991ce21 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1137,8 +1137,10 @@ submit_and_realloc:
 		}
 		if (bio == NULL) {
 			bio = f2fs_grab_bio(inode, block_nr, nr_pages);
-			if (IS_ERR(bio))
+			if (IS_ERR(bio)) {
+				bio = NULL;
 				goto set_error_page;
+			}
 		}
 
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
