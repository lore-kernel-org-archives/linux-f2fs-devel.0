From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH V1 01/14] ext4: Clear BH_Uptodate flag on
 decryption error
Date: Wed, 24 Apr 2019 10:07:17 +0530
Message-ID: <20190424043730.13683-2-chandan@linux.ibm.com>
References: <20190424043730.13683-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hJ9ec-000258-UA
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 04:37:06 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJ9eb-009K6k-HD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 04:37:06 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3O4XQEw013958
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 00:36:59 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2s2f2d4ap2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 00:36:58 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Wed, 24 Apr 2019 05:36:51 +0100
In-Reply-To: <20190424043730.13683-1-chandan@linux.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org
Cc: tytso@mit.edu, ebiggers@kernel.org, Chandan Rajendra <chandan@linux.ibm.com>, adilger.kernel@dilger.ca, jaegeuk@kernel.org

On an error return from fscrypt_decrypt_page(), ext4_block_write_begin()
can return with the page's buffer_head marked with BH_Uptodate
flag. This commit clears the BH_Uptodate flag in such cases.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/ext4/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3c2e7f5a6c84..05b258db8673 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1225,11 +1225,15 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 		if (!buffer_uptodate(*wait_bh))
 			err = -EIO;
 	}
-	if (unlikely(err))
+	if (unlikely(err)) {
 		page_zero_new_buffers(page, from, to);
-	else if (decrypt)
+	} else if (decrypt) {
 		err = fscrypt_decrypt_page(page->mapping->host, page,
 				PAGE_SIZE, 0, page->index);
+		if (err)
+			clear_buffer_uptodate(*wait_bh);
+	}
+
 	return err;
 }
 #endif
-- 
2.19.1
