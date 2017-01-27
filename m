From: DongOh Shin <doscode.kr@gmail.com>
Subject: [PATCH 2/5] Fix coding style error in f2fs.h
Date: Fri, 27 Jan 2017 10:29:37 -0800
Message-ID: <20170127182940.11389-3-doscode.kr@gmail.com>
References: <20170127182940.11389-1-doscode.kr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <doscode.kr@gmail.com>) id 1cXBHw-0003so-Kn
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:20 +0000
Received: from mail-pg0-f68.google.com ([74.125.83.68])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cXBHv-0007zw-RG
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:20 +0000
Received: by mail-pg0-f68.google.com with SMTP id 75so25582554pgf.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2017 10:30:19 -0800 (PST)
In-Reply-To: <20170127182940.11389-1-doscode.kr@gmail.com>
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
Cc: doscode.kr@gmail.com, linux-f2fs-devel@lists.sourceforge.net

A coding style error below has been resolved:
"space prohibited before that ',' (ctx:WxW)"

Signed-off-by: DongOh Shin <doscode.kr@gmail.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5d257a9..85bd8c1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2023,7 +2023,7 @@ void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
 				struct page *, struct inode *);
 int update_dent_inode(struct inode *, struct inode *, const struct qstr *);
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *,
-			const struct qstr *, f2fs_hash_t , unsigned int);
+			const struct qstr *, f2fs_hash_t, unsigned int);
 int f2fs_add_regular_entry(struct inode *, const struct qstr *,
 			const struct qstr *, struct inode *, nid_t, umode_t);
 int __f2fs_do_add_link(struct inode *, struct fscrypt_name*, struct inode *,
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
