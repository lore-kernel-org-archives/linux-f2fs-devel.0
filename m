From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 1/2] f2fs: avoid duplicated code by reusing f2fs_read_end_io
Date: Mon, 25 May 2015 18:02:03 +0800
Message-ID: <00d201d096d1$f44d43e0$dce7cba0$@samsung.com>
References: <005d01d09217$c0df57f0$429e07d0$@samsung.com>
 <20150519174851.GC42970@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150519174851.GC42970@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, May 20, 2015 1:49 AM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] f2fs: avoid duplicated code by reusing f2fs_read_end_io
> 
> Hi Chao,
> 
> On Tue, May 19, 2015 at 05:38:56PM +0800, Chao Yu wrote:
> > This patch tries to clean up code as part code of f2fs_read_end_io
> > and mpage_end_io are the same, so it's better to merge and reuse them.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/data.c | 35 +++++------------------------------
> >  1 file changed, 5 insertions(+), 30 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 8d04e24..5173d0f 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -34,40 +34,16 @@ static void f2fs_read_end_io(struct bio *bio, int err)
> >  	struct bio_vec *bvec;
> >  	int i;
> >
> > -	bio_for_each_segment_all(bvec, bio, i) {
> > -		struct page *page = bvec->bv_page;
> > -
> > -		if (!err) {
> > -			SetPageUptodate(page);
> > -		} else {
> > -			ClearPageUptodate(page);
> > -			SetPageError(page);
> > -		}
> > -		unlock_page(page);
> > -	}
> > -	bio_put(bio);
> > -}
> > -
> > -/*
> > - * I/O completion handler for multipage BIOs.
> > - * copied from fs/mpage.c
> > - */
> > -static void mpage_end_io(struct bio *bio, int err)
> > -{
> > -	struct bio_vec *bv;
> > -	int i;
> > -
> >  	if (f2fs_bio_encrypted(bio)) {
> >  		if (err) {
> >  			f2fs_release_crypto_ctx(bio->bi_private);
> >  		} else {
> > -			f2fs_end_io_crypto_work(bio->bi_private, bio);
> > -			return;
> > +			return f2fs_end_io_crypto_work(bio->bi_private, bio);
> 
> IMO, it'd better remain the previous one to make clear that
> f2fs_en_io_crypto_work defines a void return.
> How about that?

OK, will do.

Thanks,
