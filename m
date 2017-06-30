From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: avoid unnecessary function call
Date: Sat, 1 Jul 2017 07:02:54 +0800 (CST)
Message-ID: <22a88618.4a1.15cfb3e2aeb.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1dR4wN-0006zG-Tg
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Jun 2017 23:03:08 +0000
Received: from m15-62.126.com ([220.181.15.62])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1dR4wM-0002bX-5f for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Jun 2017 23:03:07 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

It should call the function fscrypt_fname_free_buffer() in the exception
handling only after the function fscrypt_fname_alloc_buffer() returns 0,
otherwise it is unnecessary.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c31b40e..3225a82 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1036,12 +1036,12 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 
 	res = fscrypt_fname_disk_to_usr(inode, 0, 0, &cstr, &pstr);
 	if (res)
-		goto errout;
+		goto out;
 
 	/* this is broken symlink case */
 	if (unlikely(pstr.name[0] == 0)) {
 		res = -ENOENT;
-		goto errout;
+		goto out;
 	}
 
 	paddr = pstr.name;
@@ -1052,8 +1052,9 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	put_page(cpage);
 	set_delayed_call(done, kfree_link, paddr);
 	return paddr;
-errout:
+out:
 	fscrypt_fname_free_buffer(&pstr);
+errout:
 	put_page(cpage);
 	return ERR_PTR(res);
 }
-- 
1.8.3.1
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
