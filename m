From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: next-20151021 - compile error in  fs/f2fs/checkpoint.c
Date: Thu, 22 Oct 2015 09:47:22 +0800
Message-ID: <02fe01d10c6b$b5cab610$21602230$@samsung.com>
References: <37662.1445450735@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <37662.1445450735@turing-police.cc.vt.edu>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Valdis Kletnieks' <Valdis.Kletnieks@vt.edu>, 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hello,

> -----Original Message-----
> From: Valdis Kletnieks [mailto:Valdis.Kletnieks@vt.edu]
> Sent: Thursday, October 22, 2015 2:06 AM
> To: Chao Yu; Jaegeuk Kim; Changman Lee
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: next-20151021 - compile error in fs/f2fs/checkpoint.c
> 
> Building next-20151021 dies with this error:
> 
>   CC [M]  fs/f2fs/checkpoint.o
> fs/f2fs/checkpoint.c: In function 'get_valid_checkpoint':
> fs/f2fs/checkpoint.c:707:3: error: too few arguments to function 'ra_meta_pages'
>    ra_meta_pages(sbi, cp_blk_no + 1, cp_blks - 1, META_CP);

Above invoking is added in commit ("f2fs: readahead cp payload pages
when mount") at ~9/12/2015, but sadly it's complete wrong due to my fault,
so it is removed in our dev-test branch by Jaegeuk at ~9/26/2015. I can't
remember the time when this commit is removed from dev branch which is for
-next branch. I have checked next-20151022, this commit is gone, I think
the last -next will not make any trouble to you. Could you check that?

>    ^
> fs/f2fs/checkpoint.c:143:5: note: declared here
>  int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
>      ^
> scripts/Makefile.build:258: recipe for target 'fs/f2fs/checkpoint.o' failed
> make[2]: *** [fs/f2fs/checkpoint.o] Error 1
> 
> Looks like this commit:
> 
> commit 26879fb101f28c554294eaf25ac7817a2825b180
> Author: Chao Yu <chao2.yu@samsung.com>
> Date:   Mon Oct 12 17:05:59 2015 +0800
> 
>     f2fs: support lower priority asynchronous readahead in ra_meta_pages
> 
> missed updating one call.  Apparently this wasn't compile-tested before
> being pushed upstream?

When this commit was updated in Jaegeuk's tree, above invoking in
fs/f2fs/checkpoint.c:707 was gone.

Thanks,
