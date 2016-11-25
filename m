From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: allow dio read for LFS mode
Date: Fri, 25 Nov 2016 10:14:04 -0800
Message-ID: <20161125181404.GB87130@jaegeuk>
References: <20161111210304.4736-1-jaegeuk@kernel.org>
 <20161111210304.4736-2-jaegeuk@kernel.org>
 <22d105b6-3393-eee0-f377-af1ab00141f2@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22d105b6-3393-eee0-f377-af1ab00141f2@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Nov 25, 2016 at 11:54:43PM +0800, Chao Yu wrote:
> On 2016/11/12 5:03, Jaegeuk Kim wrote:
> > We can allow dio reads for LFS mode, while doing buffered writes for dio writes.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index ca53da5..996b9ae 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1732,7 +1732,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >  
> >  	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> >  		return 0;
> > -	if (test_opt(F2FS_I_SB(inode), LFS))
> > +	if (rw == WRITE && test_opt(F2FS_I_SB(inode), LFS))
> 
> For LFS mode, we must disallow any IPU in main area including direct write,
> instead of both direct read and write, so this patch relieves the restriction?

Yup.

> 
> IIUC, please add:
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> >  		return 0;
> >  
> >  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
> > 
