From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v13 11/72] xarray: Add xa_cmpxchg and xa_insert
Date: Mon, 11 Jun 2018 07:05:38 -0700
Message-ID: <20180611140639.17215-12-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fSNTN-0000Qd-36
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 14:07:05 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fSNTL-0001OQ-Kt
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 14:07:05 +0000
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

Like cmpxchg(), xa_cmpxchg will only store to the index if the current
entry matches the old entry.  It returns the current entry, which is
usually more useful than the errno returned by radix_tree_insert().
For the users who really only want the errno, the xa_insert() wrapper
provides a more convenient calling convention.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/xarray.h                 | 60 ++++++++++++++++++++++
 lib/xarray.c                           | 71 ++++++++++++++++++++++++++
 tools/testing/radix-tree/xarray-test.c | 10 ++++
 3 files changed, 141 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index b5220493652d..c9fc47d28c09 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -218,6 +218,8 @@ struct xarray {
 void xa_init_flags(struct xarray *, gfp_t flags);
 void *xa_load(struct xarray *, unsigned long index);
 void *xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
+void *xa_cmpxchg(struct xarray *, unsigned long index,
+			void *old, void *entry, gfp_t);
 bool xa_get_tag(struct xarray *, unsigned long index, xa_tag_t);
 void xa_set_tag(struct xarray *, unsigned long index, xa_tag_t);
 void xa_clear_tag(struct xarray *, unsigned long index, xa_tag_t);
@@ -277,6 +279,34 @@ static inline bool xa_tagged(const struct xarray *xa, xa_tag_t tag)
 	return xa->xa_flags & XA_FLAGS_TAG(tag);
 }
 
+/**
+ * xa_insert() - Store this entry in the XArray unless another entry is
+ *			already present.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @entry: New entry.
+ * @gfp: Memory allocation flags.
+ *
+ * If you would rather see the existing entry in the array, use xa_cmpxchg().
+ * This function is for users who don't care what the entry is, only that
+ * one is present.
+ *
+ * Context: Process context.  Takes and releases the xa_lock.
+ *	    May sleep if the @gfp flags permit.
+ * Return: 0 if the store succeeded.  -EEXIST if another entry was present.
+ * 	   -ENOMEM if memory could not be allocated.
+ */
+static inline int xa_insert(struct xarray *xa, unsigned long index,
+		void *entry, gfp_t gfp)
+{
+	void *curr = xa_cmpxchg(xa, index, NULL, entry, gfp);
+	if (!curr)
+		return 0;
+	if (xa_is_err(curr))
+		return xa_err(curr);
+	return -EEXIST;
+}
+
 #define xa_trylock(xa)		spin_trylock(&(xa)->xa_lock)
 #define xa_lock(xa)		spin_lock(&(xa)->xa_lock)
 #define xa_unlock(xa)		spin_unlock(&(xa)->xa_lock)
@@ -296,9 +326,39 @@ static inline bool xa_tagged(const struct xarray *xa, xa_tag_t tag)
  */
 void *__xa_erase(struct xarray *, unsigned long index);
 void *__xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
+void *__xa_cmpxchg(struct xarray *, unsigned long index, void *old,
+		void *entry, gfp_t);
 void __xa_set_tag(struct xarray *, unsigned long index, xa_tag_t);
 void __xa_clear_tag(struct xarray *, unsigned long index, xa_tag_t);
 
+/**
+ * __xa_insert() - Store this entry in the XArray unless another entry is
+ *			already present.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @entry: New entry.
+ * @gfp: Memory allocation flags.
+ *
+ * If you would rather see the existing entry in the array, use __xa_cmpxchg().
+ * This function is for users who don't care what the entry is, only that
+ * one is present.
+ *
+ * Context: Any context.  Expects xa_lock to be held on entry.  May
+ *	    release and reacquire xa_lock if the @gfp flags permit.
+ * Return: 0 if the store succeeded.  -EEXIST if another entry was present.
+ *	   -ENOMEM if memory could not be allocated.
+ */
+static inline int __xa_insert(struct xarray *xa, unsigned long index,
+		void *entry, gfp_t gfp)
+{
+	void *curr = __xa_cmpxchg(xa, index, NULL, entry, gfp);
+	if (!curr)
+		return 0;
+	if (xa_is_err(curr))
+		return xa_err(curr);
+	return -EEXIST;
+}
+
 /* Everything below here is the Advanced API.  Proceed with caution. */
 
 /*
diff --git a/lib/xarray.c b/lib/xarray.c
index d408627b2479..86b9e00a37a0 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -976,6 +976,77 @@ void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 }
 EXPORT_SYMBOL(__xa_store);
 
+/**
+ * xa_cmpxchg() - Conditionally replace an entry in the XArray.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @old: Old value to test against.
+ * @entry: New value to place in array.
+ * @gfp: Memory allocation flags.
+ *
+ * If the entry at @index is the same as @old, replace it with @entry.
+ * If the return value is equal to @old, then the exchange was successful.
+ *
+ * Context: Process context.  Takes and releases the xa_lock.  May sleep
+ * if the @gfp flags permit.
+ * Return: The old value at this index or xa_err() if an error happened.
+ */
+void *xa_cmpxchg(struct xarray *xa, unsigned long index,
+			void *old, void *entry, gfp_t gfp)
+{
+	XA_STATE(xas, xa, index);
+	void *curr;
+
+	if (WARN_ON_ONCE(xa_is_internal(entry)))
+		return XA_ERROR(-EINVAL);
+
+	do {
+		xas_lock(&xas);
+		curr = xas_load(&xas);
+		if (curr == old)
+			xas_store(&xas, entry);
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, gfp));
+
+	return xas_result(&xas, curr);
+}
+EXPORT_SYMBOL(xa_cmpxchg);
+
+/**
+ * __xa_cmpxchg() - Store this entry in the XArray.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @old: Old value to test against.
+ * @entry: New entry.
+ * @gfp: Memory allocation flags.
+ *
+ * You must already be holding the xa_lock when calling this function.
+ * It will drop the lock if needed to allocate memory, and then reacquire
+ * it afterwards.
+ *
+ * Context: Any context.  Expects xa_lock to be held on entry.  May
+ * release and reacquire xa_lock if @gfp flags permit.
+ * Return: The old entry at this index or xa_err() if an error happened.
+ */
+void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
+			void *old, void *entry, gfp_t gfp)
+{
+	XA_STATE(xas, xa, index);
+	void *curr;
+
+	if (WARN_ON_ONCE(xa_is_internal(entry)))
+		return XA_ERROR(-EINVAL);
+
+	do {
+		curr = xas_load(&xas);
+		if (curr == old)
+			xas_store(&xas, entry);
+	} while (__xas_nomem(&xas, gfp));
+
+	return xas_result(&xas, curr);
+}
+EXPORT_SYMBOL(__xa_cmpxchg);
+
 /**
  * __xa_set_tag() - Set this tag on this entry while locked.
  * @xa: XArray.
diff --git a/tools/testing/radix-tree/xarray-test.c b/tools/testing/radix-tree/xarray-test.c
index 7bc84d1d6c9a..575f494e17da 100644
--- a/tools/testing/radix-tree/xarray-test.c
+++ b/tools/testing/radix-tree/xarray-test.c
@@ -88,6 +88,15 @@ void check_xa_shrink(struct xarray *xa)
 	assert(xa_load(xa, 0) == xa_mk_value(0));
 }
 
+void check_cmpxchg(struct xarray *xa)
+{
+	assert(xa_empty(xa));
+	assert(!xa_store(xa, 12345678, xa_mk_value(12345678), GFP_KERNEL));
+	assert(!xa_cmpxchg(xa, 5, xa_mk_value(5), NULL, GFP_KERNEL));
+	assert(xa_erase(xa, 12345678) == xa_mk_value(12345678));
+	assert(xa_empty(xa));
+}
+
 void check_multi_store(struct xarray *xa)
 {
 	unsigned long i, j, k;
@@ -158,6 +167,7 @@ void xarray_checks(void)
 	check_xa_shrink(&array);
 	item_kill_tree(&array);
 
+	check_cmpxchg(&array);
 	check_multi_store(&array);
 	item_kill_tree(&array);
 }
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
