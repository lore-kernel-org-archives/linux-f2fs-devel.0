From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4/4] f2fs: should check the type of end_io
 after pullback by fscrypto
Date: Tue, 10 Jul 2018 13:53:02 -0700
Message-ID: <20180710205302.GB79040@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-4-jaegeuk@kernel.org>
 <d09dbae7-8073-1df6-e7ab-a0241c4023ff@kernel.org>
 <20180710204329.GA79040@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fczdH-0006zt-22
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 20:53:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fczdF-000FKC-Gu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 20:53:11 +0000
Content-Disposition: inline
In-Reply-To: <20180710204329.GA79040@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 07/10, Jaegeuk Kim wrote:
> On 07/09, Chao Yu wrote:
> > On 2018/7/7 5:09, Jaegeuk Kim wrote:
> > > This fixes to get the page type after pullback by fscrypto, since the original
> > > page is bounce page but we should need to get control page which is what we
> > > originally submitted.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/data.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index c3f9b9baf140..9a0fcec53d0e 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -152,7 +152,6 @@ static void f2fs_write_end_io(struct bio *bio)
> > >  
> > >  	bio_for_each_segment_all(bvec, bio, i) {
> > >  		struct page *page = bvec->bv_page;
> > > -		enum count_type type = WB_DATA_TYPE(page);
> > >  
> > >  		if (IS_DUMMY_WRITTEN_PAGE(page)) {
> > >  			set_page_private(page, (unsigned long)NULL);
> > > @@ -169,14 +168,14 @@ static void f2fs_write_end_io(struct bio *bio)
> > >  
> > >  		if (unlikely(bio->bi_status)) {
> > >  			mapping_set_error(page->mapping, -EIO);
> > > -			if (type == F2FS_WB_CP_DATA)
> > > +			if (WB_DATA_TYPE(page) == F2FS_WB_CP_DATA)
> > >  				f2fs_stop_checkpoint(sbi, true);
> > >  		}
> > >  
> > >  		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
> > >  					page->index != nid_of_node(page));
> > >  
> > > -		dec_page_count(sbi, type);
> > > +		dec_page_count(sbi, WB_DATA_TYPE(page));
> > 
> > But we account F2FS_WB_CP_DATA/F2FS_WB_DATA type page based bounce page instead
> > of original page.
> > 
> > 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
> > 
> > 	/* set submitted = true as a return value */
> > 	fio->submitted = true;
> > 
> > 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> > 
> > Because for encrypted page of regular inode, we should account it with
> > F2FS_WB_DATA type:
> > 
> > static bool __is_cp_guaranteed(struct page *page)
> > {
> > ....
> > 	if (!mapping)   <---bounce page's mapping is NULL
> > 		return false;
> > }
> > 
> > So we will get F2FS_WB_DATA type from __is_cp_guaranteed below:
> > 
> > enum count_type type = WB_DATA_TYPE(page);
> > 
> > Is there any problem?
> 
> Wait a minute.
> 
> 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
> 
> 1. fio->encrypted_page
> 
> 	inc_page_count(sbi, F2FS_WB_CP_DATA); // page->mapping == META_MAPPING
> 
>   In write_end_io(),
> 	type = F2FS_WB_DATA; // page->mapping == NULL
> 	fscrypt_pullback_bio_page(&page);
> 	  page = fio->encrypted_page;
> 	
> 	dec_page_count(F2FS_WB_DATA);
> 
> 2. fio->page
> 
> 	inc_page_count(sbi, F2FS_WB_DATA);
> 
>   In write_end_io(),
> 	type = F2FS_WB_DATA; // page->mapping == NULL
> 	fscrypt_pullback_bio_page(&page);
> 	  page = fio->encrypted_page;
> 	
> 	dec_page_count(F2FS_WB_DATA);
> 
> Thoughts?

Oops, nvm. I was confused. :P

> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
