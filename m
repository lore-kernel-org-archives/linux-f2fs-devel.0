From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: no need inc dirty pages under inode lock
Date: Fri, 13 May 2016 14:57:43 +0800
Message-ID: <1463122663-6144-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1b170X-0007Nz-3s
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 May 2016 06:55:33 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b170T-0002yp-4Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 May 2016 06:55:33 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao@huawei.com
Cc: heyunlei@huwei.com

No need inc dirty pages under inode lock

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6402e93..3da6499 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -787,9 +787,9 @@ void update_dirty_page(struct inode *inode, struct page *page)
 
 	spin_lock(&sbi->inode_lock[type]);
 	__add_dirty_inode(inode, type);
-	inode_inc_dirty_pages(inode);
 	spin_unlock(&sbi->inode_lock[type]);
 
+	inode_inc_dirty_pages(inode);
 	SetPagePrivate(page);
 	f2fs_trace_pid(page);
 }
-- 
1.9.1


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
