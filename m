From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix to update node page under cp_rwsem
Date: Mon, 29 Aug 2016 09:40:24 -0700
Message-ID: <20160829164024.GA94184@jaegeuk>
References: <1472228072-4555-1-git-send-email-chao@kernel.org>
 <1472228072-4555-2-git-send-email-chao@kernel.org>
 <20160826170455.GB88444@jaegeuk>
 <4a9f9515-c1e2-aab0-d573-c3a4eda6aed7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4a9f9515-c1e2-aab0-d573-c3a4eda6aed7@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Aug 27, 2016 at 04:30:30PM +0800, Chao Yu wrote:
> On 2016/8/27 1:04, Jaegeuk Kim wrote:
> > On Sat, Aug 27, 2016 at 12:14:32AM +0800, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> Update node page under cp_rwsem in order to keep data consistency
> >> during writting checkpoint.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/inode.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> >> index 9ac5efc..1057c73 100644
> >> --- a/fs/f2fs/inode.c
> >> +++ b/fs/f2fs/inode.c
> >> @@ -377,8 +377,11 @@ retry:
> >>  		goto retry;
> >>  	}
> >>  
> >> -	if (err)
> >> +	if (err) {
> >> +		f2fs_lock_op(sbi);
> >>  		update_inode_page(inode);
> >> +		f2fs_unlock_op(sbi);
> >> +	}
> > 
> > Any corner case?
> 
> No, just follow the old rule.
> 
> > Now, it allows updating node page when checkpoint is doing.
> 
> Oh, so for current rule, during checkpoint it:
> 1. allows updating meta info of inode which is not related to metadata of
> filesystem (e.g. i_size, i_block, i_nlink..)
> 2. does not allow updating meta info of inode which is related to metadata of
> filesystem (i_addr, i_nid..)

Seems like that.
The checkpoint flushes any dirty inodes by block_operations. And, this is to
allow any meta updates in its inode page which doesn't hurt current processing
checkpoint.

Thanks,

> 
> Is my understanding right?
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>  	sb_end_intwrite(inode->i_sb);
> >>  no_delete:
> >>  	stat_dec_inline_xattr(inode);
> >> -- 
> >> 2.7.2
> > 
> > .
> > 
