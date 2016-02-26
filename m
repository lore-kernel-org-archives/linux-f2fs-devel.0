From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: avoid hungtask problem caused by
 losing wake_up
Date: Fri, 26 Feb 2016 09:15:59 +0800
Message-ID: <016a01d17033$63d10220$2b730660$@samsung.com>
References: <1456200476-9811-1-git-send-email-heyunlei@huawei.com>
	<009501d16dfd$52a518c0$f7ef4a40$@samsung.com>
	<56CC0410.50103@huawei.com>
	<009601d16e1a$e198af20$a4ca0d60$@samsung.com>
	<56CC442C.1050202@huawei.com>
	<00c401d16eb6$14754cf0$3d5fe6d0$@samsung.com>
	<56CEAEE7.2060501@huawei.com>
	<013101d16fb0$ceb54b10$6c1fe130$@samsung.com>
	<20160225190310.GB38418@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aZ71p-0005tX-7Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 01:17:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aZ71l-0006QC-Cu
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 01:17:09 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3401656RK54D00@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 10:16:57 +0900 (KST)
In-reply-to: <20160225190310.GB38418@jaegeuk.gateway>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Biao He' <hebiao6@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, February 26, 2016 3:03 AM
> To: Chao Yu
> Cc: 'He YunLei'; linux-f2fs-devel@lists.sourceforge.net; bintian.wang@huawei.com; 'Biao He'
> Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused by losing wake_up
> 
> Hi all,
> 
> On Thu, Feb 25, 2016 at 05:41:26PM +0800, Chao Yu wrote:
> > Hi Yunlei,
> >
> > > -----Original Message-----
> > > From: He YunLei [mailto:heyunlei@huawei.com]
> > > Sent: Thursday, February 25, 2016 3:36 PM
> > > To: Chao Yu; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > Cc: bintian.wang@huawei.com; 'Biao He'
> > > Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused by losing wake_up
> > >
> > > On 2016/2/24 11:46, Chao Yu wrote:
> > > >>> > >
> > > >>> > >But I doubt more that the reason we are stuck is there are remained pages
> > > >>> > >cached in bio buffer without being submitted. To make sure, maybe in
> > > >>> > >wait_on_all_pages_writeback we could add print info to see whether
> > > >>> > >sbi->write_io[].bio is valid or not.
> > > >>> > >
> > > >> >We use tool dump f2fs_sb_info information and find that:
> > > >> >
> > > >> >	write_io[DATA].bio = 0;
> > > >> >	write_io[NODE].bio = 0;
> > > >> >	write_io[META].bio = 0;
> > > >> >
> > > >> >	nr_pages[F2FS_WRITEBACK] = 0;
> > > >> >	nr_pages[F2FS_DIRTY_DENTS] = 0;
> > > >> >	nr_pages[F2FS_DIRTY_NODES] = 13;
> > > > Weird, dirty nodes count should be 0.
> > > >
> > > > Thanks
> > > >
> > > Hi Chao,
> > >
> > > In our code,
> > >
> > > 1524 static int f2fs_write_end(struct file *file,
> > > 1525                         struct address_space *mapping,
> > > 1526                         loff_t pos, unsigned len, unsigned copied,
> > > 1527                         struct page *page, void *fsdata)
> > > 1528 {
> > > 1529         struct inode *inode = page->mapping->host;
> > > 1530
> > > 1531         trace_f2fs_write_end(inode, pos, len, copied);
> > > 1532
> > > 1533         set_page_dirty(page);
> > > 1534
> > > 1535         if (pos + copied > i_size_read(inode)) {
> > > 1536                 i_size_write(inode, pos + copied);
> > > 1537                 mark_inode_dirty(inode);
> > > 1538                 update_inode_page(inode);
> > > 1539         }
> > > 1540
> > > 1541         f2fs_put_page(page, 1);
> > > 1542         return copied;
> > > 1543 }
> > >
> > > Here update_inode_page(inode) has been removed by Kim, maybe here could
> > > result dirty node page is not zero.
> >
> > As your hint, I found an issue in f2fs_write_inode which may be related to
> > our problem. I wrote a patch for fixing.
> 
> I just remember out that this has no problem, since we only need to disallow
> writing node pages during checkpoint.
> 
> IOW, write_inode or any other functions can update node pages during checkpoint,
> and then f2fs will flush them after checkpoint.

Sounds reasonable to me. :)

Thanks,

> 
> Thanks,
> 
> >
> > Thanks,
> >
> > >
> > > Thanks,
> > >
> > > >> >	nr_pages[F2FS_DIRTY_META] = 0;
> > > >> >	nr_pages[F2FS_INMEM_PAGES] = 0;
> > > >> >
> > > >> >So we believe that the block device is ok!
> > > >> >
> > > >> >Thanks,
> >


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
