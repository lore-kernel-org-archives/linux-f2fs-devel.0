From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v11 59/63] dax: Return fault code from
 dax_load_hole
Date: Sat, 14 Apr 2018 07:13:12 -0700
Message-ID: <20180414141316.7167-60-willy@infradead.org>
References: <20180414141316.7167-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1f7Nid-0005AC-M8
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Apr 2018 16:08:03 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f7Nic-004UgE-Et
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Apr 2018 16:08:03 +0000
In-Reply-To: <20180414141316.7167-1-willy@infradead.org>
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

dax_load_hole was swallowing the errors from vm_insert_mixed().
Use vmf_insert_mixed() instead to get a vm_fault_t, and convert
dax_load_hole() to the vm_fault_t convention.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/dax.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index bcc3fd05ab03..44785346c02f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -808,18 +808,19 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
  * If this page is ever written to we will re-fault and change the mapping to
  * point to real DAX storage instead.
  */
-static int dax_load_hole(struct xa_state *xas, struct address_space *mapping,
-		void **entry, struct vm_fault *vmf)
+static vm_fault_t dax_load_hole(struct xa_state *xas,
+		struct address_space *mapping, void **entry,
+		struct vm_fault *vmf)
 {
 	struct inode *inode = mapping->host;
 	unsigned long vaddr = vmf->address;
-	int ret = VM_FAULT_NOPAGE;
+	vm_fault_t ret;
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 
 	*entry = dax_insert_entry(xas, mapping, *entry, pfn, DAX_ZERO_PAGE,
 			false);
 
-	vm_insert_mixed(vmf->vma, vaddr, pfn);
+	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
-- 
2.17.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
