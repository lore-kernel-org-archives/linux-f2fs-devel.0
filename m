From: Liu Xue <liuxueliu.liu@huawei.com>
Subject: [PATCH] fsck.f2fs: always fix seg entry type if it is
	not DATA
Date: Tue, 24 Jan 2017 10:45:47 +0800
Message-ID: <20170124024547.14406-1-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuxueliu.liu@huawei.com>) id 1cVqxS-0008KF-06
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 02:35:42 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cVqxP-0000tY-Ex
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 02:35:41 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, piotr.karbowski@gmail.com
Cc: linux-f2fs-devel@lists.sourceforge.net

If the segment type and sum footer type are node, but its
sit type is corrupted as cold data, this will always trigger
type error crash in do_garbage_collect but not get fixed by fsck,
so fix seg entry type when it is not DATA.

Reported-by: KARBOWSKI Piotr <piotr.karbowski@gmail.com>
Signed-off-by: Liu Xue <liuxueliu.liu@huawei.com>
---
 fsck/fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 0e5aa7c..854c1e3 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1843,7 +1843,8 @@ int check_sit_types(struct f2fs_sb_info *sbi)
 
 		se = get_seg_entry(sbi, i);
 		if (se->orig_type != se->type) {
-			if (se->orig_type == CURSEG_COLD_DATA) {
+			if (se->orig_type == CURSEG_COLD_DATA &&
+					se->type <= CURSEG_COLD_DATA) {
 				se->type = se->orig_type;
 			} else {
 				FIX_MSG("Wrong segment type [0x%x] %x -> %x",
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
