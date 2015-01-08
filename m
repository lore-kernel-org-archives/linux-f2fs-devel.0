From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/6] f2fs: fix wrong unlock_page call
Date: Thu,  8 Jan 2015 10:10:56 -0800
Message-ID: <1420740661-72288-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y9HYE-0003K2-Pb
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Jan 2015 18:11:18 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y9HY9-0003ZZ-2d for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Jan 2015 18:11:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch removes wrongly called unlock_page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b48b355..a7b905c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -837,7 +837,6 @@ write:
 	/* we should bypass data pages to proceed the kworkder jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		SetPageError(page);
-		unlock_page(page);
 		goto out;
 	}
 
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
