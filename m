From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Date: Wed, 31 Jan 2018 09:54:46 +1100
Message-ID: <20180131095446.443670dc@canb.auug.org.au>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, Yufen Yu <yuyufen@huawei.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi all,

On Tue, 30 Jan 2018 14:32:20 -0800 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Could you please consider the below pull request?
> 
> Thanks,
> 
> The following changes since commit ace52288edf0cb5e7a52b681f057f86224c49c27:
> 
>   Merge tag 'for-linus-20171218' of git://git.infradead.org/linux-mtd (2017-12-18 16:18:01 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.16-rc1
> 
> for you to fetch changes up to 1c1d35df71104c76a4a2e25862926f22c334c9d6:
> 
>   f2fs: support inode creation time (2018-01-25 14:10:39 -0800)

This has an interesting conflict with the btrfs tree:

-----------------------------------------------------------------------
After merging the f2fs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/home/sfr/next/next/fs/f2fs/super.c: In function 'f2fs_fill_super':
/home/sfr/next/next/fs/f2fs/super.c:2563:18: error: 'SB_I_CGROUPWB' undeclared (first use in this function); did you mean 'S_CGROUPWB'?
  sb->s_iflags |= SB_I_CGROUPWB;
                  ^~~~~~~~~~~~~
                  S_CGROUPWB

Caused by commit

  578c647879f7 ("f2fs: implement cgroup writeback support")

interacting with commit

  34934189a3dd ("cgroup, writeback: replace SB_I_CGROUPWB with per-inode S_CGROUPWB"

from the btrfs tree.

I have reverted the f2fs tree commit for today, but a better resolution
would be appreciated.
-----------------------------------------------------------------------

I have seen no response to the above email and have been reverting that
commit since Jan 18.
-- 
Cheers,
Stephen Rothwell
