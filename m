From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Date: Tue, 30 Jan 2018 16:25:35 -0800
Message-ID: <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180131095446.443670dc@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eggDe-0008Fc-OV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 00:25:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eggDd-0007st-Pd
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 00:25:42 +0000
Content-Disposition: inline
In-Reply-To: <20180131095446.443670dc@canb.auug.org.au>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yufen Yu <yuyufen@huawei.com>, Josef Bacik <jbacik@fb.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Chris Mason <clm@fb.com>, Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 01/31, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 30 Jan 2018 14:32:20 -0800 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > Could you please consider the below pull request?
> > 
> > Thanks,
> > 
> > The following changes since commit ace52288edf0cb5e7a52b681f057f86224c49c27:
> > 
> >   Merge tag 'for-linus-20171218' of git://git.infradead.org/linux-mtd (2017-12-18 16:18:01 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.16-rc1
> > 
> > for you to fetch changes up to 1c1d35df71104c76a4a2e25862926f22c334c9d6:
> > 
> >   f2fs: support inode creation time (2018-01-25 14:10:39 -0800)
> 
> This has an interesting conflict with the btrfs tree:
> 
> -----------------------------------------------------------------------
> After merging the f2fs tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> /home/sfr/next/next/fs/f2fs/super.c: In function 'f2fs_fill_super':
> /home/sfr/next/next/fs/f2fs/super.c:2563:18: error: 'SB_I_CGROUPWB' undeclared (first use in this function); did you mean 'S_CGROUPWB'?
>   sb->s_iflags |= SB_I_CGROUPWB;
>                   ^~~~~~~~~~~~~
>                   S_CGROUPWB
> 
> Caused by commit
> 
>   578c647879f7 ("f2fs: implement cgroup writeback support")
> 
> interacting with commit
> 
>   34934189a3dd ("cgroup, writeback: replace SB_I_CGROUPWB with per-inode S_CGROUPWB"
> 
> from the btrfs tree.
> 
> I have reverted the f2fs tree commit for today, but a better resolution
> would be appreciated.
> -----------------------------------------------------------------------
> 
> I have seen no response to the above email and have been reverting that
> commit since Jan 18.

I think this can be addressed by:

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 89c838bfb067..c743b73976d0 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -48,9 +48,10 @@ void f2fs_set_inode_flags(struct inode *inode)
                new_fl |= S_DIRSYNC;
        if (f2fs_encrypted_inode(inode))
                new_fl |= S_ENCRYPTED;
+       new_fl |= S_CGROUPWB;
        inode_set_flags(inode, new_fl,
                        S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|
-                       S_ENCRYPTED);
+                       S_ENCRYPTED|S_CGROUPWB);
 }

 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8173ae688814..ebcd58476fc7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2560,7 +2560,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
        sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
                (test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
        memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
-       sb->s_iflags |= SB_I_CGROUPWB;

        /* init f2fs-specific super block info */
        sbi->valid_super_block = valid_super_block;


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
