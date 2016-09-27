From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: fix to commit bio cache after
 flushing node pages
Date: Mon, 26 Sep 2016 18:39:23 -0700
Message-ID: <20160927013923.GA35593@jaegeuk>
References: <1474906193-6487-1-git-send-email-chao@kernel.org>
	<20160926183321.GB33149@jaegeuk>
	<4a95fcaa-413c-5018-70a3-19480a39c59a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bohMs-0002JA-Tz
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Sep 2016 01:39:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bohMq-00007t-Fx
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Sep 2016 01:39:34 +0000
Content-Disposition: inline
In-Reply-To: <4a95fcaa-413c-5018-70a3-19480a39c59a@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Sep 27, 2016 at 08:57:41AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/9/27 2:33, Jaegeuk Kim wrote:
> > Hi Chao,
> > 
> > On Tue, Sep 27, 2016 at 12:09:52AM +0800, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> In sync_node_pages, we won't check and commit last merged pages in private
> >> bio cache of f2fs, as these pages were taged as writeback, someone who is
> >> waiting for writebacking of the page will be blocked until the cache was
> >> committed by someone else.
> >>
> >> We need to commit node type bio cache to avoid potential deadlock or long
> >> delay of waiting writeback.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/node.c | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >> index 9faddcd..f73f774 100644
> >> --- a/fs/f2fs/node.c
> >> +++ b/fs/f2fs/node.c
> >> @@ -1416,6 +1416,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
> >>  	struct pagevec pvec;
> >>  	int step = 0;
> >>  	int nwritten = 0;
> >> +	int ret = 0;
> >>  
> >>  	pagevec_init(&pvec, 0);
> >>  
> >> @@ -1436,7 +1437,8 @@ next_step:
> >>  
> >>  			if (unlikely(f2fs_cp_error(sbi))) {
> >>  				pagevec_release(&pvec);
> >> -				return -EIO;
> >> +				ret = -EIO;
> >> +				goto out;
> >>  			}
> >>  
> >>  			/*
> >> @@ -1487,6 +1489,8 @@ continue_unlock:
> >>  
> >>  			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
> >>  				unlock_page(page);
> >> +			else
> >> +				nwritten++;
> >>  
> >>  			if (--wbc->nr_to_write == 0)
> >>  				break;
> >> @@ -1504,7 +1508,10 @@ continue_unlock:
> >>  		step++;
> >>  		goto next_step;
> >>  	}
> >> -	return nwritten;
> >> +out:
> >> +	if (nwritten)
> >> +		f2fs_submit_merged_bio(sbi, NODE, WRITE);
> > 
> > IIRC, we don't need to flush this, since f2fs_submit_merged_bio_cond() would
> > handle this in f2fs_wait_on_page_writeback().
> 
> Yes, it covers all the cases in f2fs private codes, but there are still some
> codes in mm or fs directory, and they didn't use f2fs_wait_on_page_writeback
> when waiting page writeback. Such as do_writepages && filemap_fdatawait in
> __writeback_single_inode...

The do_writepages() is okay, which will call f2fs_write_node_pages().
The __writeback_single_inode() won't do filemap_fdatawait() with WB_SYNC_ALL.
We don't need to take care of truncation as well.

Any missing one?

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >> +	return ret;
> >>  }
> >>  
> >>  int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
> >> -- 
> >> 2.7.2
> > 
> > .
> > 

------------------------------------------------------------------------------
