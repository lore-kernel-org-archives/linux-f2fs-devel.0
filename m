From: Shuoran Liu <liushuoran@huawei.com>
Subject: [PATCH 1/2] f2fs: set encryption name flag in add inline
	entry path
Date: Mon, 29 Aug 2016 11:27:55 +0800
Message-ID: <1472441276-133832-1-git-send-email-liushuoran@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liushuoran@huawei.com>) id 1beDFP-0002l4-Jz
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Aug 2016 03:28:31 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1beDFI-0003bC-SR
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Aug 2016 03:28:31 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch sets encryption name flag in the add inline entry path
if filename is encrypted.

Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
---
 fs/f2fs/inline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ccea873..f9ce04a7 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -524,6 +524,8 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 			err = PTR_ERR(page);
 			goto fail;
 		}
+		if (f2fs_encrypted_inode(dir))
+			file_set_enc_name(inode);
 	}
 
 	f2fs_wait_on_page_writeback(ipage, NODE, true);
-- 
1.9.1


------------------------------------------------------------------------------
