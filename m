From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: move all the bio initialization
	into	__bio_alloc
Date: Thu, 19 Dec 2013 09:23:18 +0800
Message-ID: <000a01cefc59$0a9b4580$1fd1d080$@samsung.com>
References: <52B17905.7040708@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VtSLp-0001Vl-FN
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 01:24:33 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VtSLn-0005p5-CT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 01:24:33 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MY100D5058N1A00@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 10:24:23 +0900 (KST)
In-reply-to: <52B17905.7040708@cn.fujitsu.com>
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
To: 'Gu Zheng' <guz.fnst@cn.fujitsu.com>, 'Kim' <jaegeuk.kim@samsung.com>
Cc: 'fsdevel' <linux-fsdevel@vger.kernel.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>

Hi Gu,

> -----Original Message-----
> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
> Sent: Wednesday, December 18, 2013 6:29 PM
> To: Kim
> Cc: fsdevel; linux-kernel; f2fs
> Subject: [f2fs-dev] [PATCH] f2fs: move all the bio initialization into __bio_alloc
> 
> Move all the bio initialization into __bio_alloc, and some minor cleanups are
> also added.

Looks more neat!

> @@ -178,17 +179,16 @@ void f2fs_submit_page_mbio(struct f2fs_sb_info *sbi, struct page *page,
>  			block_t blk_addr, struct f2fs_io_info *fio)
>  {
>  	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
> -	struct block_device *bdev = sbi->sb->s_bdev;
>  	struct f2fs_bio_info *io;
> -	int bio_blocks;
> +	int rw = is_read_io(fio->rw);

Maybe it's more neat to use 'is_read' to instead of 'rw'.

Thanks


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
