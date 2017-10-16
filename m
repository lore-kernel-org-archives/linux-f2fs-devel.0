From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: return error number for quota_write
Date: Mon, 16 Oct 2017 16:04:44 -0700
Message-ID: <20171016230444.GA94030@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171012231500.19489-1-jaegeuk@kernel.org>
 <f84b3522-f53d-d91a-464d-71c194dd5864@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f84b3522-f53d-d91a-464d-71c194dd5864@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/16, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/10/13 7:15, Jaegeuk Kim wrote:
> > This patch returns an error number to quota_write in order for quota to handle
> > it correctly.
> 
> We should return error number like __generic_file_write_iter, right? it
> needs to return written bytes if we have written one page or more, otherwise
> return error number feedbacked from write_begin.
> 
> So how about reverting 4f31d26b0c17 ("f2fs: return wrong error number on
> f2fs_quota_write")?

I thought like that, but realized the code change is somewhat different between
them.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/super.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 2feecf5e7f4c..840a0876005b 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1397,8 +1397,11 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
> >  
> >  		err = a_ops->write_begin(NULL, mapping, off, tocopy, 0,
> >  							&page, NULL);
> > -		if (unlikely(err))
> > +		if (unlikely(err)) {
> > +			if (len == towrite)
> > +				return err;
> >  			break;
> > +		}
> >  
> >  		kaddr = kmap_atomic(page);
> >  		memcpy(kaddr + offset, data, tocopy);
> > 
