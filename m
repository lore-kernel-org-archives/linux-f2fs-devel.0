From: Jan Kara <jack@suse.cz>
Subject: [PATCH] f2fs: Remove pointless bit testing in
	f2fs_delete_entry()
Date: Thu, 23 Oct 2014 14:40:20 +0200
Message-ID: <1414068020-20907-1-git-send-email-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jack@suse.cz>) id 1XhHh1-0004Gj-89
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Oct 2014 12:40:39 +0000
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XhHgz-0007nm-Ej
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Oct 2014 12:40:39 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net

There's no point in using test_and_clear_bit_le() when we don't use the
return value of the function. Just use clear_bit_le() instead.

Coverity-id: 1016434
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/f2fs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index b54f87149c09..c49f83956773 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -579,7 +579,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	dentry_blk = page_address(page);
 	bit_pos = dentry - dentry_blk->dentry;
 	for (i = 0; i < slots; i++)
-		test_and_clear_bit_le(bit_pos + i, &dentry_blk->dentry_bitmap);
+		clear_bit_le(bit_pos + i, &dentry_blk->dentry_bitmap);
 
 	/* Let's check and deallocate this dentry page */
 	bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
-- 
1.8.1.4


------------------------------------------------------------------------------
