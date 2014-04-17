From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to enable readahead last NAT block
Date: Thu, 17 Apr 2014 17:20:18 +0800
Message-ID: <000101cf5a1e$5c051770$140f4650$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WaiVP-00063u-G8
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 09:21:15 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WaiVN-00072G-FA
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 09:21:15 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N460027C4N5TEB0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 18:21:05 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We skip reading last one of NAT blocks when readahead them since max value of
valid block is calculated incorrectly. We should fix this problem to avoid it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 744c68b..75189b1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -77,7 +77,7 @@ inline int get_max_meta_blks(struct f2fs_sb_info *sbi, int type)
 {
 	switch (type) {
 	case META_NAT:
-		return NM_I(sbi)->max_nid / NAT_ENTRY_PER_BLOCK;
+		return (NM_I(sbi)->max_nid + 3) / NAT_ENTRY_PER_BLOCK;
 	case META_SIT:
 		return SIT_BLK_CNT(sbi);
 	case META_SSA:
-- 
1.7.9.5



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
