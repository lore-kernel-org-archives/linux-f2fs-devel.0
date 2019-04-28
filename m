From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH V2 09/13] ext4: Decrypt the block that needs to
 be partially zeroed
Date: Sun, 28 Apr 2019 10:01:17 +0530
Message-ID: <20190428043121.30925-10-chandan@linux.ibm.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hKbTJ-0006OG-Fb
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 04:31:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hKbTG-00FhRN-0y
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 04:31:25 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3S4TZRD105997
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 28 Apr 2019 00:31:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s54cf96sc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 28 Apr 2019 00:31:16 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Sun, 28 Apr 2019 05:31:15 +0100
In-Reply-To: <20190428043121.30925-1-chandan@linux.ibm.com>
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
Cc: hch@infradead.org, tytso@mit.edu, ebiggers@kernel.org, Chandan Rajendra <chandan@linux.ibm.com>, adilger.kernel@dilger.ca, jaegeuk@kernel.org

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
