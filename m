From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [PATCH] f2fs: fix to release inode page
	in	get_new_data_page
Date: Sat, 11 Jul 2015 10:02:51 +0800
Message-ID: <COL402-EAS409F2B0F7AE6CCD5F95F8D1AB9E0@phx.gbl>
References: <00f301d0ba30$ebe95b80$c3bc1280$@samsung.com>
	<20150711001715.GA61190@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZDk8F-0001Tm-Ea
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Jul 2015 02:03:11 +0000
Received: from col004-omc1s2.hotmail.com ([65.55.34.12])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDk8E-0003Jt-1Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Jul 2015 02:03:11 +0000
In-Reply-To: <20150711001715.GA61190@jaegeuk-mac02>
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, July 11, 2015 8:17 AM
> To: Chao Yu; Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to release inode page in get_new_data_page
> 
> Hi Chao,
> 
> On Thu, Jul 09, 2015 at 06:20:08PM +0800, Chao Yu wrote:
> > get_new_data_page should release inode page when we encounter any
> > error in its procedure, but there is one error path didn't cover
> > this, fix it.
> 
> Nice catch.
> But, I think we should fix its caller:
> 
> in init_inode_metadata(),
> 	err = make_empty_dir();
> 	if (err)
> 		goto put_error;
> 		---------------

Previously, I fixed in the same way, but I got an oops when I test the
patch with xfstest suit, it shows we will meet an error in this call
path IIRC:

->f2fs_mkdir
  ->__f2fs_add_link
    ->init_inode_metadata
      ->make_empty_dir
        ->get_new_data_page
          ->f2fs_reserve_block
            ->reserve_new_block
              ->inc_valid_block_count
                return -ENOSPC;
              ->f2fs_put_dnode
                ->f2fs_put_page(ipage, 1)

      put_error:
        ->f2fs_put_page(ipage, 1);
          f2fs_bug_on(F2FS_P_SB(page), !PageLocked(page));

And I don't think we should change error handling method of f2fs_put_dnode
for just fixing this issue.

How do you think?

Thanks,

> Thanks,
> 
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/data.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 08dfdc6..ea8898b 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -397,8 +397,10 @@ struct page *get_new_data_page(struct inode *inode,
> >  	int err;
> >  repeat:
> >  	page = grab_cache_page(mapping, index);
> > -	if (!page)
> > +	if (!page) {
> > +		f2fs_put_page(ipage, 1);
> >  		return ERR_PTR(-ENOMEM);
> > +	}
> >
> >  	set_new_dnode(&dn, inode, ipage, NULL, 0);
> >  	err = f2fs_reserve_block(&dn, index);
> > --
> > 2.4.2
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
