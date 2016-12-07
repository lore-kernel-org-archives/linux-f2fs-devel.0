From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: free meta pages if sanity check for
	ckpt is failed
Date: Tue,  6 Dec 2016 17:16:25 -0800
Message-ID: <20161207011625.15591-2-jaegeuk@kernel.org>
References: <20161207011625.15591-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cEQqa-0007RW-3u
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Dec 2016 01:16:36 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cEQqZ-0002ux-GT
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Dec 2016 01:16:36 +0000
In-Reply-To: <20161207011625.15591-1-jaegeuk@kernel.org>
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

This fixes missing freeing meta pages in the error case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 35601b0d077f..698b13ae261c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -770,7 +770,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 
 	/* Sanity checking of checkpoint */
 	if (sanity_check_ckpt(sbi))
-		goto fail_no_cp;
+		goto free_fail_no_cp;
 
 	if (cur_page == cp1)
 		sbi->cur_cp_pack = 1;
@@ -798,6 +798,9 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_put_page(cp2, 1);
 	return 0;
 
+free_fail_no_cp:
+	f2fs_put_page(cp1, 1);
+	f2fs_put_page(cp2, 1);
 fail_no_cp:
 	kfree(sbi->ckpt);
 	return -EINVAL;
-- 
2.11.0


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/xeonphi
