From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: more reasonable mem_size calculating of
	ino_entry
Date: Sat, 18 Mar 2017 09:26:13 +0800
Message-ID: <6c1f71a2-358a-fcb1-7159-200c417539a8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cp38U-0007b0-MO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 01:26:26 +0000
Received: from mail-it0-f66.google.com ([209.85.214.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cp38S-0004sR-Vg
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 01:26:26 +0000
Received: by mail-it0-f66.google.com with SMTP id r141so7165454ita.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 18:26:24 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cc7ef45..2962e23 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -63,8 +63,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 		int i;
 
 		for (i = 0; i <= UPDATE_INO; i++)
-			mem_size += (sbi->im[i].ino_num *
-				sizeof(struct ino_entry)) >> PAGE_SHIFT;
+			mem_size += sbi->im[i].ino_num * sizeof(struct ino_entry);
+		mem_size >>= PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
 	} else if (type == EXTENT_CACHE) {
 		mem_size = (atomic_read(&sbi->total_ext_tree) *
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
