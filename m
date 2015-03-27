From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: fsck handling of inode incorrectly used as DIR and
 REG_FILE?
Date: Thu, 26 Mar 2015 17:06:09 -0700
Message-ID: <20150327000609.GA67016@jaegeuk-mac02>
References: <CAKP4w2QLJCVruiyta6=FQ8AomPYogPx9uKfBkxvYMUhLYDCX9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YbHn1-0006Fh-Pg
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:06:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YbHn0-0001vh-JI for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:06:19 +0000
Content-Disposition: inline
In-Reply-To: <CAKP4w2QLJCVruiyta6=FQ8AomPYogPx9uKfBkxvYMUhLYDCX9Q@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: JP Abgrall <jpa@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi JP,

I found that fsck.f2fs has some missing cases.
And it seems that one of them is very similar with your issue.
Could you test the patches that I submitted seconds ago?

Thanks,

On Thu, Mar 26, 2015 at 04:45:46PM -0700, JP Abgrall wrote:
> I have an image where an inode shows up once as an F2FS_FT_DIR and
> later as an  F2FS_FT_REG_FILE.
> 
> With fsck 1.4.1, This causes the i_blocks and i_link fix to toggle and
> the image is never fixed, leading to the kernel complaining.
> 
> Any ideas on how to fix this?
> 
> I'm tempted to have fsck track the type for each inode fixed and then
> drop references to dups that lead to fixes against a different type.
> 
> This is what the output looks like for ino[0x24e49]:
> 
>     # fsck.f2fs -t -d1 -f /dev/block/dm-0
>     ...
> 
>     [__chk_dentries: 787] [  5]-[0x8]
> name[rJx8QtCT5u-dJsmZ4GOp2ahzwPs] len[0x1b] ino[0x24e49] type[0x2]
>     [f2fs_set_main_bitmap:  33] Wrong segment type [0x1c96] 4 -> 3
>     [f2fs_set_main_bitmap:  33] Wrong segment type [0xdde] 1 -> 0
>     [fsck_chk_dentry_blk: 877] [  6] Dentry Block [0x1c6f51] Done :
> dentries:0 in 214 slots (len:255)
> 
>     [fsck_chk_inode_blk: 537] Directory Inode: 0x24e49
> [de7e59c967696ac0_0] depth: 1 has 0 files
> 
>     [ASSERT] (fsck_chk_inode_blk: 547)  --> ino: 0x24e49 has i_blocks:
> 00000001, but has 3 blocks
>     [FIX] (fsck_chk_inode_blk: 553)  --> [0x24e49] i_blocks=0x00000001 -> 0x3
>     ...
>     [ASSERT] (fsck_chk_inode_blk: 560)  --> ino: 0x24e49 has i_links:
> 1 but real links: 0
>     [FIX] (fsck_chk_inode_blk: 565)  --> Dir: 0x24e49 i_links= 0x1 -> 0x0
> 
>     ...
>     [__chk_dentries: 787] [  5]-[0x6f] name[de7e59c967696ac0_0]
> len[0x12] ino[0x24e49] type[0x1]
>     [ASSERT] (fsck_chk_inode_blk: 411)  --> [0x24e49] needs more i_links=0x0
>     [FIX] (fsck_chk_inode_blk: 418)  --> File: 0x24e49 i_links= 0x0 -> 0x1
>     [ASSERT] (fsck_chk_inode_blk: 547)  --> ino: 0x24e49 has i_blocks:
> 00000003, but has 1 blocks
>     [FIX] (fsck_chk_inode_blk: 553)  --> [0x24e49] i_blocks=0x00000003 -> 0x1
> 
> --
> jpa
> 
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website, sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the 
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
