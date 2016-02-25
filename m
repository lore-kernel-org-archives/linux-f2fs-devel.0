From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: avoid hungtask problem caused by
 losing wake_up
Date: Thu, 25 Feb 2016 15:36:07 +0800
Message-ID: <56CEAEE7.2060501@huawei.com>
References: <1456200476-9811-1-git-send-email-heyunlei@huawei.com>
	<009501d16dfd$52a518c0$f7ef4a40$@samsung.com>
	<56CC0410.50103@huawei.com>
	<009601d16e1a$e198af20$a4ca0d60$@samsung.com>
	<56CC442C.1050202@huawei.com>
	<00c401d16eb6$14754cf0$3d5fe6d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aYqTm-0000J4-Bh
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 07:36:54 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aYqTh-0004mP-BK
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 07:36:54 +0000
In-Reply-To: <00c401d16eb6$14754cf0$3d5fe6d0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: 'Biao He' <hebiao6@huawei.com>

On 2016/2/24 11:46, Chao Yu wrote:
>>> > >
>>> > >But I doubt more that the reason we are stuck is there are remained pages
>>> > >cached in bio buffer without being submitted. To make sure, maybe in
>>> > >wait_on_all_pages_writeback we could add print info to see whether
>>> > >sbi->write_io[].bio is valid or not.
>>> > >
>> >We use tool dump f2fs_sb_info information and find that:
>> >
>> >	write_io[DATA].bio = 0;
>> >	write_io[NODE].bio = 0;
>> >	write_io[META].bio = 0;
>> >
>> >	nr_pages[F2FS_WRITEBACK] = 0;
>> >	nr_pages[F2FS_DIRTY_DENTS] = 0;
>> >	nr_pages[F2FS_DIRTY_NODES] = 13;
> Weird, dirty nodes count should be 0.
>
> Thanks
>
Hi Chao,

In our code,

1524 static int f2fs_write_end(struct file *file,
1525                         struct address_space *mapping,
1526                         loff_t pos, unsigned len, unsigned copied,
1527                         struct page *page, void *fsdata)
1528 {
1529         struct inode *inode = page->mapping->host;
1530
1531         trace_f2fs_write_end(inode, pos, len, copied);
1532
1533         set_page_dirty(page);
1534
1535         if (pos + copied > i_size_read(inode)) {
1536                 i_size_write(inode, pos + copied);
1537                 mark_inode_dirty(inode);
1538                 update_inode_page(inode);
1539         }
1540
1541         f2fs_put_page(page, 1);
1542         return copied;
1543 }

Here update_inode_page(inode) has been removed by Kim, maybe here could
result dirty node page is not zero.

Thanks,

>> >	nr_pages[F2FS_DIRTY_META] = 0;
>> >	nr_pages[F2FS_INMEM_PAGES] = 0;
>> >
>> >So we believe that the block device is ok!
>> >
>> >Thanks,


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
