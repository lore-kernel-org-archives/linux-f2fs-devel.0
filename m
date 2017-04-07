From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: count writeback pages correctly
Date: Fri, 7 Apr 2017 10:46:33 -0700
Message-ID: <20170407174633.GB7227@jaegeuk.local>
References: <20170405180201.4021-1-jaegeuk@kernel.org>
 <18bac85c-ee9a-76a8-5f89-f395579b2edd@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <18bac85c-ee9a-76a8-5f89-f395579b2edd@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 04/06, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/4/6 2:02, Jaegeuk Kim wrote:
> > This patch fixes # of outstanding writeback pages by checking its original page.
> 
> Originally, we use bio_page to track encrypted page which is been writebacked,
> there are two cases:
> 1. background flush through .writepages: encrypted_page has no mapping info,
> will not be tracked.
> 2. synchronized GC through move_encrypted_block: encrypted_page is meta page,
> will be tracked.
> 
> So there is no problem with old code?

Consistency was fine, but why not tracking # of writebacked pages for encryption
case?

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 3d74c0ffa4c7..af3e849e96d2 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -94,7 +94,6 @@ static void f2fs_write_end_io(struct bio *bio)
> >  
> >  	bio_for_each_segment_all(bvec, bio, i) {
> >  		struct page *page = bvec->bv_page;
> > -		enum count_type type = WB_DATA_TYPE(page);
> >  
> >  		if (IS_DUMMY_WRITTEN_PAGE(page)) {
> >  			set_page_private(page, (unsigned long)NULL);
> > @@ -113,7 +112,7 @@ static void f2fs_write_end_io(struct bio *bio)
> >  			mapping_set_error(page->mapping, -EIO);
> >  			f2fs_stop_checkpoint(sbi, true);
> >  		}
> > -		dec_page_count(sbi, type);
> > +		dec_page_count(sbi, WB_DATA_TYPE(page));
> >  		clear_cold_data(page);
> >  		end_page_writeback(page);
> >  	}
> > @@ -389,7 +388,7 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
> >  	fio->submitted = 1;
> >  
> >  	if (!is_read)
> > -		inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> > +		inc_page_count(sbi, WB_DATA_TYPE(fio->page));
> >  
> >  	down_write(&io->io_rwsem);
> >  
> > @@ -403,7 +402,7 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
> >  				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
> >  			err = -EAGAIN;
> >  			if (!is_read)
> > -				dec_page_count(sbi, WB_DATA_TYPE(bio_page));
> > +				dec_page_count(sbi, WB_DATA_TYPE(fio->page));
> >  			goto out_fail;
> >  		}
> >  		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
> > 
