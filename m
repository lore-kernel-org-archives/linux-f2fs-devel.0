From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: use a page temporarily for encrypted
	gced page
Date: Tue, 14 Jul 2015 12:18:22 -0700
Message-ID: <1436901502-78825-2-git-send-email-jaegeuk@kernel.org>
References: <1436901502-78825-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZF5is-0006o1-8z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jul 2015 19:18:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZF5ir-0001Vc-Fs for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jul 2015 19:18:34 +0000
In-Reply-To: <1436901502-78825-1-git-send-email-jaegeuk@kernel.org>
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

That encrypted page is used temporarily, so we don't need to mark it accessed.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index db11861..ca562df 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -552,7 +552,10 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	fio.page = page;
 	fio.blk_addr = dn.data_blkaddr;
 
-	fio.encrypted_page = grab_cache_page(META_MAPPING(fio.sbi), fio.blk_addr);
+	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi),
+					fio.blk_addr,
+					FGP_LOCK|FGP_CREAT,
+					GFP_NOFS);
 	if (!fio.encrypted_page)
 		goto put_out;
 
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
