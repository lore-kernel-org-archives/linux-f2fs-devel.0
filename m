From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: don't reserve additional space in
	xattr block
Date: Thu, 23 Mar 2017 13:38:26 +0800
Message-ID: <20170323053826.37176-2-yuchao0@huawei.com>
References: <20170323053826.37176-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqvSg-0000IN-Eh
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Mar 2017 05:39:02 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqvSe-0003WQ-Oo
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Mar 2017 05:39:02 +0000
In-Reply-To: <20170323053826.37176-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In this patch, we change xattr block disk layout as below:

Before:
			xattr node block layout
+---------------------------------------------+---------------+-------------+
|           node block xattr entries          |   reserved    | node footer |
|                  4068 Bytes                 |    4 Bytes    |  24 Bytes   |

			In memory layout
+--------------------+---------------------------------+--------------------+
|    inline xattr    |     node block xattr entries    |      reserved      |
|     200 Bytes      |         4068 Bytes              |      4 Bytes       |

After:
			xattr node block layout
+-------------------------------------------------------------+-------------+
|                  node block xattr entries                   | node footer |
|                         4072 Bytes                          |  24 Bytes   |

			In memory layout
+--------------------+---------------------------------+--------------------+
|    inline xattr    |     node block xattr entries    |      reserved      |
|     200 Bytes      |         4072 Bytes              |      4 Bytes       |

With this change, we don't need to reserve additional space in node block,
just keep reserved space in logical in-memory layout. So that it would help
to enlarge valid free space of xattr node block.

As tested, generic/026 shows max stored xattr entires number increases from
531 to 532 when inline_xattr option is enabled.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 6 +++---
 fs/f2fs/xattr.h | 5 ++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 528aed399814..832c5110abab 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -256,7 +256,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	if (!size && !inline_size)
 		return -ENODATA;
 
-	txattr_addr = kzalloc(inline_size + size + RESERVED_XATTR_SIZE,
+	txattr_addr = kzalloc(inline_size + size + XATTR_PADDING_SIZE,
 							GFP_F2FS_ZERO);
 	if (!txattr_addr)
 		return -ENOMEM;
@@ -332,7 +332,7 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 	void *txattr_addr;
 	int err;
 
-	txattr_addr = kzalloc(inline_size + size + RESERVED_XATTR_SIZE,
+	txattr_addr = kzalloc(inline_size + size + XATTR_PADDING_SIZE,
 							GFP_F2FS_ZERO);
 	if (!txattr_addr)
 		return -ENOMEM;
@@ -451,7 +451,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 	}
 
 	xattr_addr = page_address(xpage);
-	memcpy(xattr_addr, txattr_addr + inline_size, MAX_XATTR_BLOCK_SIZE);
+	memcpy(xattr_addr, txattr_addr + inline_size, VALID_XATTR_BLOCK_SIZE);
 	set_page_dirty(xpage);
 	f2fs_put_page(xpage, 1);
 
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 1e7db8d0806e..6afcee35ebeb 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -72,9 +72,8 @@ struct f2fs_xattr_entry {
 		for (entry = XATTR_FIRST_ENTRY(addr);\
 				!IS_XATTR_LAST_ENTRY(entry);\
 				entry = XATTR_NEXT_ENTRY(entry))
-#define MAX_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
-#define RESERVED_XATTR_SIZE	(sizeof(__u32))
-#define VALID_XATTR_BLOCK_SIZE	(MAX_XATTR_BLOCK_SIZE - RESERVED_XATTR_SIZE)
+#define VALID_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
+#define XATTR_PADDING_SIZE	(sizeof(__u32))
 #define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
 						VALID_XATTR_BLOCK_SIZE)
 
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
