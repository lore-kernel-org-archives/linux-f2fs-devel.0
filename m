From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: return early when trying to read null
	nid
Date: Wed, 23 Dec 2015 18:15:18 -0800
Message-ID: <1450923320-41113-2-git-send-email-jaegeuk@kernel.org>
References: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBvRE-0001I9-G0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:15:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBvRD-0006Mk-Qf for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:15:32 +0000
In-Reply-To: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
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

If get_node_page() gets zero nid, we can return early without getting a wrong
page. For example, get_dnode_of_data() can try to do that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 341de5d..e17128d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1059,6 +1059,9 @@ struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
 {
 	struct page *page;
 	int err;
+
+	if (!nid)
+		return ERR_PTR(-ENOENT);
 repeat:
 	page = grab_cache_page(NODE_MAPPING(sbi), nid);
 	if (!page)
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
