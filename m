From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: handle failed bio allocation
Date: Sun, 23 Aug 2015 21:53:37 -0700
Message-ID: <20150824045337.GA2837@jaegeuk-mac02.mot-mobility.com>
References: <1439593751-21879-1-git-send-email-jaegeuk@kernel.org>
	<01b801d0db27$e8b9e9d0$ba2dbd70$@samsung.com>
	<20150820155727.GB42028@jaegeuk-mac02.mot-mobility.com>
	<021601d0dc10$003a90d0$00afb270$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZTjlR-00053n-2L
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 04:53:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZTjlP-0006gq-E9 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 04:53:45 +0000
Content-Disposition: inline
In-Reply-To: <021601d0dc10$003a90d0$00afb270$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

[snip]

> > > >
> > > > -	/* No failure on bio allocation */
> > > > -	bio = bio_alloc(GFP_NOIO, npages);
> > >
> > > How about using __GFP_NOFAIL flag to avoid failing in bio_alloc instead
> > > of adding opencode endless loop in code?
> > >
> > > We can see the reason in this commit 	647757197cd3
> > > ("mm: clarify __GFP_NOFAIL deprecation status ")
> > >
> > > "__GFP_NOFAIL is documented as a deprecated flag since commit
> > > 478352e789f5 ("mm: add comment about deprecation of __GFP_NOFAIL").
> > >
> > > This has discouraged people from using it but in some cases an opencoded
> > > endless loop around allocator has been used instead. So the allocator
> > > is not aware of the de facto __GFP_NOFAIL allocation because this
> > > information was not communicated properly.
> > >
> > > Let's make clear that if the allocation context really cannot afford
> > > failure because there is no good failure policy then using __GFP_NOFAIL
> > > is preferable to opencoding the loop outside of the allocator."
> > >
> > > BTW, I found that f2fs_kmem_cache_alloc also could be replaced, we could
> > > fix them together.
> > 
> > Agreed. I think that can be another patch like this.
> > 
> > From 1579e0d1ada96994c4ec6619fb5b5d9386e77ab3 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Thu, 20 Aug 2015 08:51:56 -0700
> > Subject: [PATCH] f2fs: use __GFP_NOFAIL to avoid infinite loop
> > 
> > __GFP_NOFAIL can avoid retrying the whole path of kmem_cache_alloc and
> > bio_alloc.
> > 
> > Suggested-by: Chao Yu <chao2.yu@samsung.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 00591f7..c78b599 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1244,13 +1244,10 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
> >  						gfp_t flags)
> >  {
> >  	void *entry;
> > -retry:
> > -	entry = kmem_cache_alloc(cachep, flags);
> > -	if (!entry) {
> > -		cond_resched();
> > -		goto retry;
> > -	}
> > 
> > +	entry = kmem_cache_alloc(cachep, flags);
> > +	if (!entry)
> > +		entry = kmem_cache_alloc(cachep, flags | __GFP_NOFAIL);
> 
> The fast + slow path model looks good to me, expect one thing:
> In several paths of checkpoint, caller will grab slab cache with GFP_ATOMIC,
> so in slow path, our flags will be GFP_ATOMIC | __GFP_NOFAIL, I'm not sure
> that the two flags can be used together.
> 
> Should we replace GFP_ATOMIC with GFP_NOFS in flags if caller passed
> GFP_ATOMIC?

Indeed, we need to avoid GFP_ATOMIC as much as possible to mitigate memory
pressure at this moment. Too much abused.

I wrote a patch like this.

>From a9209556d024cdce490695586ecee3164efda49c Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 20 Aug 2015 08:51:56 -0700
Subject: [PATCH] f2fs: use __GFP_NOFAIL to avoid infinite loop

__GFP_NOFAIL can avoid retrying the whole path of kmem_cache_alloc and
bio_alloc.
And, it also fixes the use cases of GFP_ATOMIC correctly.

Suggested-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 21 ++++++++-------------
 fs/f2fs/f2fs.h       | 16 +++++-----------
 fs/f2fs/node.c       |  4 ++--
 fs/f2fs/segment.c    |  2 +-
 4 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 890e4d4..c5a38e3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -336,26 +336,18 @@ const struct address_space_operations f2fs_meta_aops = {
 static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
 	struct inode_management *im = &sbi->im[type];
-	struct ino_entry *e;
+	struct ino_entry *e, *tmp;
+
+	tmp = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
 retry:
-	if (radix_tree_preload(GFP_NOFS)) {
-		cond_resched();
-		goto retry;
-	}
+	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
 
 	spin_lock(&im->ino_lock);
-
 	e = radix_tree_lookup(&im->ino_root, ino);
 	if (!e) {
-		e = kmem_cache_alloc(ino_entry_slab, GFP_ATOMIC);
-		if (!e) {
-			spin_unlock(&im->ino_lock);
-			radix_tree_preload_end();
-			goto retry;
-		}
+		e = tmp;
 		if (radix_tree_insert(&im->ino_root, ino, e)) {
 			spin_unlock(&im->ino_lock);
-			kmem_cache_free(ino_entry_slab, e);
 			radix_tree_preload_end();
 			goto retry;
 		}
@@ -368,6 +360,9 @@ retry:
 	}
 	spin_unlock(&im->ino_lock);
 	radix_tree_preload_end();
+
+	if (e != tmp)
+		kmem_cache_free(ino_entry_slab, tmp);
 }
 
 static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6641017..ece5e70 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1252,13 +1252,10 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
 						gfp_t flags)
 {
 	void *entry;
-retry:
-	entry = kmem_cache_alloc(cachep, flags);
-	if (!entry) {
-		cond_resched();
-		goto retry;
-	}
 
+	entry = kmem_cache_alloc(cachep, flags);
+	if (!entry)
+		entry = kmem_cache_alloc(cachep, flags | __GFP_NOFAIL);
 	return entry;
 }
 
@@ -1267,12 +1264,9 @@ static inline struct bio *f2fs_bio_alloc(int npages)
 	struct bio *bio;
 
 	/* No failure on bio allocation */
-retry:
 	bio = bio_alloc(GFP_NOIO, npages);
-	if (!bio) {
-		cond_resched();
-		goto retry;
-	}
+	if (!bio)
+		bio = bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
 	return bio;
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6bef5a2..777066d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -159,7 +159,7 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 
 	head = radix_tree_lookup(&nm_i->nat_set_root, set);
 	if (!head) {
-		head = f2fs_kmem_cache_alloc(nat_entry_set_slab, GFP_ATOMIC);
+		head = f2fs_kmem_cache_alloc(nat_entry_set_slab, GFP_NOFS);
 
 		INIT_LIST_HEAD(&head->entry_list);
 		INIT_LIST_HEAD(&head->set_list);
@@ -246,7 +246,7 @@ static struct nat_entry *grab_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid)
 {
 	struct nat_entry *new;
 
-	new = f2fs_kmem_cache_alloc(nat_entry_slab, GFP_ATOMIC);
+	new = f2fs_kmem_cache_alloc(nat_entry_slab, GFP_NOFS);
 	f2fs_radix_tree_insert(&nm_i->nat_root, nid, new);
 	memset(new, 0, sizeof(struct nat_entry));
 	nat_set_nid(new, nid);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6273e2c..78e6d06 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1753,7 +1753,7 @@ static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
 static struct sit_entry_set *grab_sit_entry_set(void)
 {
 	struct sit_entry_set *ses =
-			f2fs_kmem_cache_alloc(sit_entry_set_slab, GFP_ATOMIC);
+			f2fs_kmem_cache_alloc(sit_entry_set_slab, GFP_NOFS);
 
 	ses->entry_cnt = 0;
 	INIT_LIST_HEAD(&ses->set_list);
-- 
2.1.1


------------------------------------------------------------------------------
