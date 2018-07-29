From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid race between zero_range and
 background GC
Date: Sat, 28 Jul 2018 19:02:54 -0700
Message-ID: <20180729020254.GH83620@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180726104536.114340-1-yuchao0@huawei.com>
 <20180727102916.GI16155@jaegeuk-macbookpro.roam.corp.google.com>
 <10d7814b-06d0-6751-ca56-85e7c8b92a27@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fjb30-0005sg-3v
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 02:03:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fjb2y-001SrC-Ol
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 02:03:02 +0000
Content-Disposition: inline
In-Reply-To: <10d7814b-06d0-6751-ca56-85e7c8b92a27@kernel.org>
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

On 07/27, Chao Yu wrote:
> On 2018/7/27 18:29, Jaegeuk Kim wrote:
> > On 07/26, Chao Yu wrote:
> >> Thread A				Background GC
> >> - f2fs_zero_range
> >>  - truncate_pagecache_range
> >> 					- gc_data_segment
> >> 					 - get_read_data_page
> >> 					  - move_data_page
> >> 					   - set_page_dirty
> >> 					   - set_cold_data
> >>  - f2fs_do_zero_range
> >>   - dn->data_blkaddr = NEW_ADDR;
> >>   - f2fs_set_data_blkaddr
> >>
> >> Actually, we don't need to set dirty & checked flag on the page, since
> >> all valid data in the page should be zeroed by zero_range().
> > 
> > But, it doesn't matter too much, right?
> 
> No, if the dirtied page is writebacked after f2fs_do_zero_range(), result of
> zero_range() should be wrong, as zeroed page contains valid user data.

How about truncating page caches after block address change or doing it twice
before and after?

> 
> > 
> >> Use i_gc_rwsem[WRITE] to avoid such race condition.
> > 
> > Hope to avoid abusing i_gc_rwsem[] tho.
> 
> Agreed, let's try avoiding until we have to use it.
> 
> Thanks,
> 
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/file.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index 267ec3794e1e..7bd2412a8c37 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -1309,6 +1309,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>  	down_write(&F2FS_I(inode)->i_mmap_sem);
> >>  	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
> >>  	if (ret)
> >> @@ -1389,6 +1390,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
> >>  	}
> >>  out_sem:
> >>  	up_write(&F2FS_I(inode)->i_mmap_sem);
> >> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>  
> >>  	return ret;
> >>  }
> >> -- 
> >> 2.18.0.rc1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
