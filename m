From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix a dead loop in f2fs_fiemap()
Date: Sun, 22 Jan 2017 14:27:12 +0800
Message-ID: <f09cfe87-866b-1ae4-a8ae-bb5c718712ef@huawei.com>
References: <1485058862-19199-1-git-send-email-fangwei1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cVBcc-0000A0-Tn
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Jan 2017 06:27:26 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cVBcX-0001WO-E5
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Jan 2017 06:27:26 +0000
In-Reply-To: <1485058862-19199-1-git-send-email-fangwei1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Wei Fang <fangwei1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/1/22 12:21, Wei Fang wrote:
> A dead loop can be triggered in f2fs_fiemap() using the test case
> as below:
> 
> 	...
> 	fd = open();
> 	fallocate(fd, 0, 0, 4294967296);
> 	ioctl(fd, FS_IOC_FIEMAP, fiemap_buf);
> 	...
> 
> It's caused by an overflow in __get_data_block():
> 	...
> 	bh->b_size = map.m_len << inode->i_blkbits;
> 	...
> map.m_len is an unsigned int, and bh->b_size is a size_t which is 64 bits
> on 64 bits archtecture, type conversion from an unsigned int to a size_t
> will result in an overflow.
> 
> In the above-mentioned case, bh->b_size will be zero, and f2fs_fiemap()
> will call get_data_block() at block 0 again an again.
> 
> Fix this by adding a force conversion before left shift.

Nice catch!

> 
> Signed-off-by: Wei Fang <fangwei1@huawei.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
