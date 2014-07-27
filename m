From: Dongho Sim <dh.sim@samsung.com>
Subject: [PATCH] Remove an unnecessary line in
	allocate_data_block.
Date: Sun, 27 Jul 2014 23:03:01 +0000 (GMT)
Message-ID: <5225212.3741406502181304.JavaMail.weblogic@epv6ml08>
Reply-To: dh.sim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dh.sim@samsung.com>) id 1XBXTI-0004c4-JU
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Jul 2014 23:03:16 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XBXTG-0002Bi-5C
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Jul 2014 23:03:16 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N9E006DM812BJA0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Jul 2014 08:03:02 +0900 (KST)
MIME-version: 1.0
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi. There was an unnecessary line in function, allocate_data_block.
It is already done in 
   refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);

Thanks.

Signed-off-by: Dongho Sim <dh.sim@samsung.com>
---
 fs/f2fs/segment.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8a6e57d..a3c7aae 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1001,7 +1001,6 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 * since SSR needs latest valid block information.
 	 */
 	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
-	locate_dirty_segment(sbi, old_cursegno);
 
 	mutex_unlock(&sit_i->sentry_lock);
 
-- 
1.9.1
------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
