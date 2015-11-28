From: Yunlei He <heyunlei@huawei.com>
Subject: [f2fs-linux 3.10][PATCH] f2fs: Fix a system panic caused
	by f2fs_follow_link
Date: Sat, 28 Nov 2015 14:38:40 +0800
Message-ID: <1448692720-16658-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1a2Z8N-00021N-E8
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 06:37:23 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a2Z8F-0004W7-ON
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 06:37:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao2.yu@samsung.com
Cc: Shuoran Liu <liushuoran@huawei.com>

In linux 3.10, we can not make sure the return value of nd_get_link function
is valid. So this patch add a check before use it.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Shuoran Liu <liushuoran@huawei.com>

---
 fs/f2fs/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 336d43d..bfaec10 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -319,13 +319,18 @@ fail:
 static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct page *page;
+	char *link;
 
 	page = page_follow_link_light(dentry, nd);
 	if (IS_ERR(page))
 		return page;
 
+	link = nd_get_link(nd);
+	if (IS_ERR(link))
+		return link;
+
 	/* this is broken symlink case */
-	if (*nd_get_link(nd) == 0) {
+	if (*link == 0) {
 		kunmap(page);
 		page_cache_release(page);
 		return ERR_PTR(-ENOENT);
-- 
1.9.1


------------------------------------------------------------------------------
