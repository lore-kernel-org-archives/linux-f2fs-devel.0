From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2] f2fs: add a bug_on in is_alive
Date: Wed, 22 Mar 2017 11:59:29 +0800
Message-ID: <20170322035930.20657-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cqXNM-0003nt-Ru
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 03:55:56 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqXNK-0007ZV-G8
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 03:55:56 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch add a bug_on in is_alive in case of infinite loop.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 418fd98..c01168c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -550,6 +550,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	get_node_info(sbi, nid, dni);
 
 	if (sum->version != dni->version) {
+		f2fs_bug_on(sbi, (sum->version + 1) != dni->version);
 		f2fs_put_page(node_page, 1);
 		return false;
 	}
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
