From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v13 02/72] dax: Fix use of zero page
Date: Mon, 11 Jun 2018 07:05:29 -0700
Message-ID: <20180611140639.17215-3-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fSNTO-00022O-3o
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 14:07:06 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fSNTM-00D4QX-E2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 14:07:06 +0000
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

Use my_zero_pfn instead of ZERO_PAGE, and pass the vaddr to it so it
works on MIPS and s390.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 fs/dax.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4de11ed463ce..5e7b010738be 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1017,21 +1017,12 @@ static vm_fault_t dax_load_hole(struct address_space *mapping, void *entry,
 {
 	struct inode *inode = mapping->host;
 	unsigned long vaddr = vmf->address;
-	vm_fault_t ret = VM_FAULT_NOPAGE;
-	struct page *zero_page;
-	pfn_t pfn;
-
-	zero_page = ZERO_PAGE(0);
-	if (unlikely(!zero_page)) {
-		ret = VM_FAULT_OOM;
-		goto out;
-	}
+	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
+	vm_fault_t ret;
 
-	pfn = page_to_pfn_t(zero_page);
 	dax_insert_mapping_entry(mapping, vmf, entry, pfn, RADIX_DAX_ZERO_PAGE,
 			false);
 	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
-out:
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
