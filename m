From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: next-20151021 - compile error in fs/f2fs/checkpoint.c
Date: Wed, 21 Oct 2015 20:06:05 -0700
Message-ID: <20151022030605.GA49819@jaegeuk-mac02>
References: <37662.1445450735@turing-police.cc.vt.edu>
	<02fe01d10c6b$b5cab610$21602230$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zp6Cl-0001vB-En
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Oct 2015 03:06:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zp6Cj-0001LL-M9 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Oct 2015 03:06:15 +0000
Content-Disposition: inline
In-Reply-To: <02fe01d10c6b$b5cab610$21602230$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Valdis Kletnieks' <Valdis.Kletnieks@vt.edu>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Oct 22, 2015 at 09:47:22AM +0800, Chao Yu wrote:
> Hello,
> 
> > -----Original Message-----
> > From: Valdis Kletnieks [mailto:Valdis.Kletnieks@vt.edu]
> > Sent: Thursday, October 22, 2015 2:06 AM
> > To: Chao Yu; Jaegeuk Kim; Changman Lee
> > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: next-20151021 - compile error in fs/f2fs/checkpoint.c
> > 
> > Building next-20151021 dies with this error:
> > 
> >   CC [M]  fs/f2fs/checkpoint.o
> > fs/f2fs/checkpoint.c: In function 'get_valid_checkpoint':
> > fs/f2fs/checkpoint.c:707:3: error: too few arguments to function 'ra_meta_pages'
> >    ra_meta_pages(sbi, cp_blk_no + 1, cp_blks - 1, META_CP);
> 
> Above invoking is added in commit ("f2fs: readahead cp payload pages
> when mount") at ~9/12/2015, but sadly it's complete wrong due to my fault,
> so it is removed in our dev-test branch by Jaegeuk at ~9/26/2015. I can't
> remember the time when this commit is removed from dev branch which is for
> -next branch. I have checked next-20151022, this commit is gone, I think
> the last -next will not make any trouble to you. Could you check that?

At least, now f2fs for -next contains a fixed patch.
Thanks,

> 
> >    ^
> > fs/f2fs/checkpoint.c:143:5: note: declared here
> >  int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
> >      ^
> > scripts/Makefile.build:258: recipe for target 'fs/f2fs/checkpoint.o' failed
> > make[2]: *** [fs/f2fs/checkpoint.o] Error 1
> > 
> > Looks like this commit:
> > 
> > commit 26879fb101f28c554294eaf25ac7817a2825b180
> > Author: Chao Yu <chao2.yu@samsung.com>
> > Date:   Mon Oct 12 17:05:59 2015 +0800
> > 
> >     f2fs: support lower priority asynchronous readahead in ra_meta_pages
> > 
> > missed updating one call.  Apparently this wasn't compile-tested before
> > being pushed upstream?
> 
> When this commit was updated in Jaegeuk's tree, above invoking in
> fs/f2fs/checkpoint.c:707 was gone.
> 
> Thanks,

------------------------------------------------------------------------------
