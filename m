From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid selinux denial on
 CAP_SYS_RESOURCE
Date: Fri, 9 Mar 2018 13:57:05 -0800
Message-ID: <20180309215705.GB56123@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180309044900.39677-1-jaegeuk@kernel.org>
 <5ec9338e-1522-2b6a-99c2-ffe70b7a06a9@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1euQ0o-00088a-84
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 21:57:14 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1euQ0m-00F4X3-Sn
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 21:57:14 +0000
Content-Disposition: inline
In-Reply-To: <5ec9338e-1522-2b6a-99c2-ffe70b7a06a9@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 03/09, Chao Yu wrote:
> On 2018/3/9 12:49, Jaegeuk Kim wrote:
> > This fixes CAP_SYS_RESOURCE denial of selinux when using resgid.
> 
> A little confusion, if capable(CAP_SYS_RESOURCE) is false, we still have chance
> to return true for below resuid & resgid cases, right?

I didn't dig it deeply tho, it seems selinux log came up when capable() is
failed in the first place. We actually didn't need to show it up, since next
resgid will give mostly true.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index f6dc70666ebb..3d12277fbe9e 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1607,13 +1607,13 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
> >  		return false;
> >  	if (IS_NOQUOTA(inode))
> >  		return true;
> > -	if (capable(CAP_SYS_RESOURCE))
> > -		return true;
> >  	if (uid_eq(sbi->s_resuid, current_fsuid()))
> >  		return true;
> >  	if (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) &&
> >  					in_group_p(sbi->s_resgid))
> >  		return true;
> > +	if (capable(CAP_SYS_RESOURCE))
> > +		return true;
> >  	return false;
> >  }
> >  
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
