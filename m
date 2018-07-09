From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: should check the type of end_io
 after pullback by fscrypto
Date: Mon, 9 Jul 2018 13:37:58 -0700
Message-ID: <20180709203758.GB24534@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-4-jaegeuk@kernel.org>
 <d09dbae7-8073-1df6-e7ab-a0241c4023ff@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d09dbae7-8073-1df6-e7ab-a0241c4023ff@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/09, Chao Yu wrote:
> On 2018/7/7 5:09, Jaegeuk Kim wrote:
> > This fixes to get the page type after pullback by fscrypto, since the original
> > page is bounce page but we should need to get control page which is what we
> > originally submitted.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index c3f9b9baf140..9a0fcec53d0e 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -152,7 +152,6 @@ static void f2fs_write_end_io(struct bio *bio)
> >  
> >  	bio_for_each_segment_all(bvec, bio, i) {
> >  		struct page *page = bvec->bv_page;
> > -		enum count_type type = WB_DATA_TYPE(page);
> >  
> >  		if (IS_DUMMY_WRITTEN_PAGE(page)) {
> >  			set_page_private(page, (unsigned long)NULL);
> > @@ -169,14 +168,14 @@ static void f2fs_write_end_io(struct bio *bio)
> >  
> >  		if (unlikely(bio->bi_status)) {
> >  			mapping_set_error(page->mapping, -EIO);
> > -			if (type == F2FS_WB_CP_DATA)
> > +			if (WB_DATA_TYPE(page) == F2FS_WB_CP_DATA)
> >  				f2fs_stop_checkpoint(sbi, true);
> >  		}
> >  
> >  		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
> >  					page->index != nid_of_node(page));
> >  
> > -		dec_page_count(sbi, type);
> > +		dec_page_count(sbi, WB_DATA_TYPE(page));
> 
> But we account F2FS_WB_CP_DATA/F2FS_WB_DATA type page based bounce page instead
> of original page.
> 
> 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
> 
> 	/* set submitted = true as a return value */
> 	fio->submitted = true;
> 
> 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> 
> Because for encrypted page of regular inode, we should account it with
> F2FS_WB_DATA type:
> 
> static bool __is_cp_guaranteed(struct page *page)
> {
> ....
> 	if (!mapping)   <---bounce page's mapping is NULL
> 		return false;
> }
> 
> So we will get F2FS_WB_DATA type from __is_cp_guaranteed below:
> 
> enum count_type type = WB_DATA_TYPE(page);
> 
> Is there any problem?

Yeah, right. Let me drop this and test again.

Thanks,

> 
> Thanks
> 
> >  		clear_cold_data(page);
> >  		end_page_writeback(page);
> >  	}
> > 
