From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: update REQ_TIME in f2fs_cross_rename()
Date: Mon, 15 Oct 2018 16:03:57 -0700
Message-ID: <20181015230357.GA1296@jaegeuk-macbookpro.roam.corp.google.com>
References: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
 <1538716660-31572-2-git-send-email-stummala@codeaurora.org>
 <fa825846-ba41-31d2-c819-476e9245b7a8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa825846-ba41-31d2-c819-476e9245b7a8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Sahitya Tummala <stummala@codeaurora.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/15, Chao Yu wrote:
> On 2018/10/5 13:17, Sahitya Tummala wrote:
> > Update REQ_TIME in the missing path - f2fs_cross_rename().
> 
> Needs to cover f2fs_rename() as well?

Hi, I've added this in f2fs_rename().

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/namei.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index a146327..e37af23 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -1154,6 +1154,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  
> >  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
> >  		f2fs_sync_fs(sbi->sb, 1);
> > +
> > +	f2fs_update_time(sbi, REQ_TIME);
> >  	return 0;
> >  out_new_dir:
> >  	if (new_dir_entry) {
> > 
