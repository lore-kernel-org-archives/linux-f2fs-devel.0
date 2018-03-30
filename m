From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v10 55/62] dax: Hash on XArray instead of mapping
Date: Thu, 29 Mar 2018 20:42:38 -0700
Message-ID: <20180330034245.10462-56-willy@infradead.org>
References: <20180330034245.10462-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1f1kwr-00087h-NG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:29 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1kwq-001iSG-BD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:29 +0000
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

Since the XArray is embedded in the struct address_space, this contains
exactly as much entropy as the address of the mapping.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/dax.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index ce4ad6a99e78..2d6e21e41567 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -116,7 +116,7 @@ static int dax_is_empty_entry(void *entry)
  * DAX page cache entry locking
  */
 struct exceptional_entry_key {
-	struct address_space *mapping;
+	struct xarray *xa;
 	pgoff_t entry_start;
 };
 
@@ -125,7 +125,7 @@ struct wait_exceptional_entry_queue {
 	struct exceptional_entry_key key;
 };
 
-static wait_queue_head_t *dax_entry_waitqueue(struct address_space *mapping,
+static wait_queue_head_t *dax_entry_waitqueue(struct xarray *xa,
 		pgoff_t index, void *entry, struct exceptional_entry_key *key)
 {
 	unsigned long hash;
@@ -138,21 +138,21 @@ static wait_queue_head_t *dax_entry_waitqueue(struct address_space *mapping,
 	if (dax_is_pmd_entry(entry))
 		index &= ~PG_PMD_COLOUR;
 
-	key->mapping = mapping;
+	key->xa = xa;
 	key->entry_start = index;
 
-	hash = hash_long((unsigned long)mapping ^ index, DAX_WAIT_TABLE_BITS);
+	hash = hash_long((unsigned long)xa ^ index, DAX_WAIT_TABLE_BITS);
 	return wait_table + hash;
 }
 
-static int wake_exceptional_entry_func(wait_queue_entry_t *wait, unsigned int mode,
-				       int sync, void *keyp)
+static int wake_exceptional_entry_func(wait_queue_entry_t *wait,
+		unsigned int mode, int sync, void *keyp)
 {
 	struct exceptional_entry_key *key = keyp;
 	struct wait_exceptional_entry_queue *ewait =
 		container_of(wait, struct wait_exceptional_entry_queue, wait);
 
-	if (key->mapping != ewait->key.mapping ||
+	if (key->xa != ewait->key.xa ||
 	    key->entry_start != ewait->key.entry_start)
 		return 0;
 	return autoremove_wake_function(wait, mode, sync, NULL);
@@ -163,13 +163,13 @@ static int wake_exceptional_entry_func(wait_queue_entry_t *wait, unsigned int mo
  * The important information it's conveying is whether the entry at
  * this index used to be a PMD entry.
  */
-static void dax_wake_mapping_entry_waiter(struct address_space *mapping,
+static void dax_wake_mapping_entry_waiter(struct xarray *xa,
 		pgoff_t index, void *entry, bool wake_all)
 {
 	struct exceptional_entry_key key;
 	wait_queue_head_t *wq;
 
-	wq = dax_entry_waitqueue(mapping, index, entry, &key);
+	wq = dax_entry_waitqueue(xa, index, entry, &key);
 
 	/*
 	 * Checking for locked entry and prepare_to_wait_exclusive() happens
@@ -246,7 +246,8 @@ static void *get_unlocked_mapping_entry(struct address_space *mapping,
 			return entry;
 		}
 
-		wq = dax_entry_waitqueue(mapping, index, entry, &ewait.key);
+		wq = dax_entry_waitqueue(&mapping->i_pages, index, entry,
+				&ewait.key);
 		prepare_to_wait_exclusive(wq, &ewait.wait,
 					  TASK_UNINTERRUPTIBLE);
 		xa_unlock_irq(&mapping->i_pages);
@@ -270,7 +271,7 @@ static void dax_unlock_mapping_entry(struct address_space *mapping,
 	}
 	unlock_slot(mapping, slot);
 	xa_unlock_irq(&mapping->i_pages);
-	dax_wake_mapping_entry_waiter(mapping, index, entry, false);
+	dax_wake_mapping_entry_waiter(&mapping->i_pages, index, entry, false);
 }
 
 static void put_locked_mapping_entry(struct address_space *mapping,
@@ -290,7 +291,7 @@ static void put_unlocked_mapping_entry(struct address_space *mapping,
 		return;
 
 	/* We have to wake up next waiter for the page cache entry lock */
-	dax_wake_mapping_entry_waiter(mapping, index, entry, false);
+	dax_wake_mapping_entry_waiter(&mapping->i_pages, index, entry, false);
 }
 
 static unsigned long dax_entry_size(void *entry)
@@ -464,8 +465,8 @@ static void *grab_mapping_entry(struct address_space *mapping, pgoff_t index,
 			dax_disassociate_entry(entry, mapping, false);
 			radix_tree_delete(&mapping->i_pages, index);
 			mapping->nrexceptional--;
-			dax_wake_mapping_entry_waiter(mapping, index, entry,
-					true);
+			dax_wake_mapping_entry_waiter(&mapping->i_pages,
+					index, entry, true);
 		}
 
 		entry = dax_mk_locked(0, size_flag | DAX_EMPTY);
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
