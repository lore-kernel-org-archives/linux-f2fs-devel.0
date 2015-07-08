From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: Don't try to split extents shorter than
 F2FS_MIN_EXTENT_LEN
Date: Wed, 08 Jul 2015 16:02:54 +0800
Message-ID: <000b01d0b954$943ecf00$bcbc6d00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1ZCkKT-0002ui-IC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jul 2015 08:03:41 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZCkKR-0000Ah-AG
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jul 2015 08:03:41 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NR502808T1VU9D0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jul 2015 17:03:31 +0900 (KST)
References: 
In-reply-to: 
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Since only parts of extents longer than F2FS_MIN_EXTENT_LEN will 
be kept in extent cache after split, extents already shorter than 
F2FS_MIN_EXTENT_LEN don't need to try split at all.


Signed-off-by: Fan Li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 37a2632..e2996cb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -585,7 +585,7 @@ static bool f2fs_update_extent_tree(struct inode *inode,
pgoff_t fofs,
 	__detach_extent_node(sbi, et, en);
 
 	/* 2. if extent can be split more, split and insert the left part */
-	if (dei.len > 1) {
+	if (dei.len > F2FS_MIN_EXTENT_LEN) {
 		/*  insert left part of split extent into cache */
 		if (fofs - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
 			set_extent_info(&ei, dei.fofs, dei.blk,
-- 
1.7.9.5


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
