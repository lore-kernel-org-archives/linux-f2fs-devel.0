From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: remove false-positive bug_on
Date: Wed, 31 May 2017 19:12:06 -0700
Message-ID: <20170601021206.GB35573@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170526235923.31058-1-jaegeuk@kernel.org>
	<995a8c2b-d29f-5c82-6d7c-90e93770f620@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dGFav-00064b-AZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Jun 2017 02:12:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dGFau-0007Zs-Hl
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Jun 2017 02:12:13 +0000
Content-Disposition: inline
In-Reply-To: <995a8c2b-d29f-5c82-6d7c-90e93770f620@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 05/31, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/5/27 7:59, Jaegeuk Kim wrote:
> > If we got failure from both of create and evict_inode, we can hit this wrong
> > bug_on.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/inode.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index e53c784ab11e..5673b0bd83b5 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -426,8 +426,6 @@ void f2fs_evict_inode(struct inode *inode)
> >  		alloc_nid_failed(sbi, inode->i_ino);
> >  		clear_inode_flag(inode, FI_FREE_NID);
> >  	}
> > -	f2fs_bug_on(sbi, err &&
> > -		!exist_written_data(sbi, inode->i_ino, ORPHAN_INO));
> 
> We expect that we can keep the inode in orphan list in
> handle_failed_inode path when inode page have been persisted, so that if
> there is anything error in evice_inode, we can have another chance to
> release inode resource during next mount.
> 
> Here we need to check this case, additionally, if we failed to add the
> inode into orphan list in handle_failed_inode, we must have set
> SBI_NEED_FSCK in cp pack, so we need check the case too.
> 
> So we can change the code to:
> 
> f2fs_bug_on(err && err != -ENOENT &&
> 		(!exist_written_data(sbi, inode->i_ino, ORPHAN_INO) ||
> 		!is_sbi_flag_set(sbi, SBI_NEED_FSCK));

Yup, I'll try this. ;)

Thanks,

> 
> How do you think?
> 
> Thanks,
> 
> >  out_clear:
> >  	fscrypt_put_encryption_info(inode, NULL);
> >  	clear_inode(inode);
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
