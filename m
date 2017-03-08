From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 1/2] f2fs: use parameter max_items instead of
	PIDVEC_SIZE
Date: Wed, 8 Mar 2017 10:47:11 +0800
Message-ID: <20170308024712.18167-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1clRq3-0007yK-Qz
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 03:00:31 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1clRq1-0001zr-Md
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 03:00:31 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index 73b4e1d..c82ab40 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -138,7 +138,7 @@ static unsigned int gang_lookup_pids(pid_t *results, unsigned long first_index,
 
 	radix_tree_for_each_slot(slot, &pids, &iter, first_index) {
 		results[ret] = iter.index;
-		if (++ret == PIDVEC_SIZE)
+		if (++ret == max_items)
 			break;
 	}
 	return ret;
-- 
2.10.1


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
