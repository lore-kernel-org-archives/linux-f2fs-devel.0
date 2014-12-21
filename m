From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/6] f2fs: avoid double lock for cp_rwsem
Date: Sun, 21 Dec 2014 08:35:23 -0800
Message-ID: <1419179723-3234-6-git-send-email-jaegeuk@kernel.org>
References: <1419179723-3234-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y2jTp-0006QU-DS
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:35:41 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y2jTo-0001j6-N2 for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:35:41 +0000
In-Reply-To: <1419179723-3234-1-git-send-email-jaegeuk@kernel.org>
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

The __f2fs_add_link is covered by cp_rwsem all the time.
This calls init_inode_metadata, which conducts some acl operations including
memory allocation with GFP_KERNEL previously.
But, under memory pressure, f2fs_write_data_page can be called, which also
grabs cp_mutex too.
Basically, it's safe since down_read was used in both of cases, but it'd
better avoid this situation in advance.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 1ccb26b..7f12d28 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -62,7 +62,7 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
 	if (count == 0)
 		return NULL;
 
-	acl = posix_acl_alloc(count, GFP_KERNEL);
+	acl = posix_acl_alloc(count, GFP_NOFS);
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
 
@@ -116,7 +116,7 @@ static void *f2fs_acl_to_disk(const struct posix_acl *acl, size_t *size)
 	int i;
 
 	f2fs_acl = kmalloc(sizeof(struct f2fs_acl_header) + acl->a_count *
-			sizeof(struct f2fs_acl_entry), GFP_KERNEL);
+			sizeof(struct f2fs_acl_entry), GFP_NOFS);
 	if (!f2fs_acl)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
