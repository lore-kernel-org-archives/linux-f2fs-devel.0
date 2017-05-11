From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: use f2fs_submit_page_bio for
 ra_meta_pages
Date: Wed, 10 May 2017 19:41:36 -0700
Message-ID: <20170511024136.GC3967@jaegeuk.local>
References: <20170510234816.3373-1-jaegeuk@kernel.org>
 <afcbcade-806c-23a4-f766-9d41c896a37c@huawei.com>
 <95d5a9b2-0e0d-e513-5b45-33a35fd2d3d1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <95d5a9b2-0e0d-e513-5b45-33a35fd2d3d1@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 05/11, Chao Yu wrote:
> On 2017/5/11 9:24, Chao Yu wrote:
> > Hi Jaegeuk,
> > 
> > On 2017/5/11 7:48, Jaegeuk Kim wrote:
> >> This patch avoids to use f2fs_submit_merged_bio for read, which was the only
> >> read case.
> > 
> > This makes f2fs losing the chance to merge multiple pages into one bio during
> > reading continuous physical blocks, it may cause potential performance
> > regression, how about using a local bio in ra_meta_pages to cache more pages?
> 
> BTW, need to remove sbi->read_io as well?

Yup.

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >> ---
> >>  fs/f2fs/checkpoint.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index ea9c317b5916..8d92f8249000 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -207,12 +207,10 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
> >>  		}
> >>  
> >>  		fio.page = page;
> >> -		fio.old_blkaddr = fio.new_blkaddr;
> >> -		f2fs_submit_page_mbio(&fio);
> >> +		f2fs_submit_page_bio(&fio);
> >>  		f2fs_put_page(page, 0);
> >>  	}
> >>  out:
> >> -	f2fs_submit_merged_bio(sbi, META, READ);
> >>  	blk_finish_plug(&plug);
> >>  	return blkno - start;
> >>  }
> >>
> > 
> > 
> > .
> > 
