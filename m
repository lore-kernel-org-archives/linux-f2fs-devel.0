From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: report ENOENT correct in
 f2fs_rename
Date: Tue, 18 Sep 2018 10:59:36 -0700
Message-ID: <20180918175936.GF91945@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <f2d06f89-4f84-8492-eeea-e1c07e5104c3@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1g2KHt-0001Je-Oq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 17:59:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g2KHo-001oxu-VC
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 17:59:49 +0000
Content-Disposition: inline
In-Reply-To: <f2d06f89-4f84-8492-eeea-e1c07e5104c3@kernel.org>
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

On 09/18, Chao Yu wrote:
> On 2018/9/18 10:18, Jaegeuk Kim wrote:
> > This fixes wrong error report in f2fs_rename.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/namei.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index 98d3ab7c3ce6..d653be777529 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  	struct f2fs_dir_entry *old_entry;
> >  	struct f2fs_dir_entry *new_entry;
> >  	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
> > -	int err = -ENOENT;
> > +	int err;
> >  
> >  	if (unlikely(f2fs_cp_error(sbi)))
> >  		return -EIO;
> > @@ -854,6 +854,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  	if (err)
> >  		goto out;
> >  
> > +	err = -ENOENT;
> 
> I didn't get what's the difference after moving initialization of 'err' here...

One example,

        old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
        if (!old_entry) {
                if (IS_ERR(old_page))
                        err = PTR_ERR(old_page);

--> need to return ENOENT instead of 0.

                goto out;
        }

> 
> Thanks,
> 
> >  	if (new_inode) {
> >  		err = dquot_initialize(new_inode);
> >  		if (err)
> > 
