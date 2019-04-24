From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH V1 10/14] ext4: Decrypt the block that needs to
 be partially zeroed
Date: Wed, 24 Apr 2019 10:07:26 +0530
Message-ID: <20190424043730.13683-11-chandan@linux.ibm.com>
References: <20190424043730.13683-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hJ9f5-00029g-NZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 04:37:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJ9f4-00A7LS-Kv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 04:37:35 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3O4XTx6043133
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 00:37:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s2ghj0x5v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 00:37:28 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Wed, 24 Apr 2019 05:37:27 +0100
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

__ext4_block_zero_page_range decrypts the entire page. This commit
decrypts the block to be partially zeroed instead of the whole page.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/ext4/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 51744a3c3964..ade1816697a8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4080,9 +4080,10 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode)) {
 			/* We expect the key to be set. */
 			BUG_ON(!fscrypt_has_encryption_key(inode));
-			BUG_ON(blocksize != PAGE_SIZE);
 			WARN_ON_ONCE(fscrypt_decrypt_page(page->mapping->host,
-						page, PAGE_SIZE, 0, page->index));
+							page, blocksize,
+							round_down(offset, blocksize),
+							iblock));
 		}
 	}
 	if (ext4_should_journal_data(inode)) {
-- 
2.19.1
