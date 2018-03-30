From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v10 53/62] dax: dax_insert_mapping_entry always
 succeeds
Date: Thu, 29 Mar 2018 20:42:36 -0700
Message-ID: <20180330034245.10462-54-willy@infradead.org>
References: <20180330034245.10462-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1f1kwf-0004Pj-V8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:17 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1kwe-001iQ1-F2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:17 +0000
In-Reply-To: <20180330034245.10462-1-willy@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, James Simmons <jsimmons@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Andreas Dilger <andreas.dilger@intel.com>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

It does not return an error, so we don't need to check the return value
for IS_ERR().

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/dax.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 371d50a1c14e..3bd9f624c1f8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -994,18 +994,12 @@ static int dax_load_hole(struct address_space *mapping, void *entry,
 	struct inode *inode = mapping->host;
 	unsigned long vaddr = vmf->address;
 	int ret = VM_FAULT_NOPAGE;
-	void *entry2;
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 
-	entry2 = dax_insert_mapping_entry(mapping, vmf, entry, pfn,
+	dax_insert_mapping_entry(mapping, vmf, entry, pfn,
 			DAX_ZERO_PAGE, false);
-	if (IS_ERR(entry2)) {
-		ret = VM_FAULT_SIGBUS;
-		goto out;
-	}
 
 	vm_insert_mixed(vmf->vma, vaddr, pfn);
-out:
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1315,10 +1309,6 @@ static int dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 		entry = dax_insert_mapping_entry(mapping, vmf, entry, pfn,
 						 0, write && !sync);
-		if (IS_ERR(entry)) {
-			error = PTR_ERR(entry);
-			goto error_finish_iomap;
-		}
 
 		/*
 		 * If we are doing synchronous page fault and inode needs fsync,
@@ -1402,8 +1392,6 @@ static int dax_pmd_load_hole(struct vm_fault *vmf, struct iomap *iomap,
 	pfn = page_to_pfn_t(zero_page);
 	ret = dax_insert_mapping_entry(mapping, vmf, entry, pfn,
 			DAX_PMD | DAX_ZERO_PAGE, false);
-	if (IS_ERR(ret))
-		goto fallback;
 
 	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
 	if (!pmd_none(*(vmf->pmd))) {
@@ -1525,8 +1513,6 @@ static int dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 		entry = dax_insert_mapping_entry(mapping, vmf, entry, pfn,
 						DAX_PMD, write && !sync);
-		if (IS_ERR(entry))
-			goto finish_iomap;
 
 		/*
 		 * If we are doing synchronous page fault and inode needs fsync,
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
