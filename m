From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: allow wrong configure dio to
 buffered write
Date: Mon, 9 Jul 2018 13:41:25 -0700
Message-ID: <20180709204125.GC24534@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-2-jaegeuk@kernel.org>
 <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/09, Chao Yu wrote:
> On 2018/7/7 5:09, Jaegeuk Kim wrote:
> > This fixes to support unaligned dio as buffered writes.
> 
> Should we return -EINVAL as manual of write said:
> 
> EINVAL fd is attached to an object which is unsuitable for writing; or the file
> was opened with the O_DIRECT flag,  and  either  the  address
> specified in buf, the value specified in count, or the current file offset is
> not suitably aligned.

I came from many xfstests failures regarding to direct IO error. It seems other
filesystems allow buffered writes as well.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index e66379961804..6e8e78bb64a7 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2425,7 +2425,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >  
> >  	err = check_direct_IO(inode, iter, offset);
> >  	if (err)
> > -		return err;
> > +		return 0;
> >  
> >  	if (f2fs_force_buffered_io(inode, rw))
> >  		return 0;
> > 
