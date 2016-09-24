From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: remove dirty inode pages in error path
Date: Sat, 24 Sep 2016 10:47:13 -0700
Message-ID: <20160924174713.GA25123@jaegeuk>
References: <20160923211105.20848-1-jaegeuk@kernel.org>
	<f51439e8-ea3b-836f-b967-d0e1446e952b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bnr2q-0002Wi-6I
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 17:47:24 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bnr2p-0006Wf-4o
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 17:47:24 +0000
Content-Disposition: inline
In-Reply-To: <f51439e8-ea3b-836f-b967-d0e1446e952b@huawei.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Sat, Sep 24, 2016 at 09:02:02AM +0800, Chao Yu wrote:
> On 2016/9/24 5:11, Jaegeuk Kim wrote:
> > When getting EIO while handling orphan inodes, we can get some dirty node
> > pages. Then, f2fs_write_node_pages() called by iput(node_inode) will try
> > to flush node pages. But in this case, we should prevent to do that, since
> > we will try again from the start.
> 
> We are protected since we set SBI_POR_DOING flag in sb, so we are safe now?

Safe, but we get an infinite loop to flush node pages.

> 
> Thanks,

------------------------------------------------------------------------------
