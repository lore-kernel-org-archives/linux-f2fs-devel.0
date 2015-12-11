From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] back-up raw_super in sbi
Date: Fri, 11 Dec 2015 15:02:13 +0800
Message-ID: <03b901d133e1$f8f85ee0$eae91ca0$@samsung.com>
References: <015901d13248$a4c568d0$ee503a70$@samsung.com>
	<5667D4FD.7060703@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a7Hje-00028l-Mq
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Dec 2015 07:03:22 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a7HjZ-0000aV-8Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Dec 2015 07:03:22 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZ602EQ2M8CXQ30@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Dec 2015 16:03:01 +0900 (KST)
In-reply-to: <5667D4FD.7060703@huawei.com>
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
To: 'He YunLei' <heyunlei@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: hebiao6@huawei.com, stuart.li@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi all,

> -----Original Message-----
> From: He YunLei [mailto:heyunlei@huawei.com]
> Sent: Wednesday, December 09, 2015 3:15 PM
> To: Chao Yu
> Cc: 'Jaegeuk Kim'; linux-f2fs-devel@lists.sourceforge.net; hebiao6@huawei.com;
> stuart.li@huawei.com
> Subject: Re: [f2fs-dev] [PATCH] back-up raw_super in sbi
> 
> On 2015/12/9 14:11, Chao Yu wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> >> Sent: Wednesday, December 09, 2015 2:19 AM
> >> To: Yunlei He
> >> Cc: linux-f2fs-devel@lists.sourceforge.net; chao2.yu@samsung.com; hebiao6@huawei.com;
> >> stuart.li@huawei.com
> >> Subject: Re: [f2fs-dev] [PATCH] back-up raw_super in sbi
> >>
> >> Hi Yunlei,
> >>
> >> On Tue, Dec 08, 2015 at 09:17:13PM +0800, Yunlei He wrote:
> >>> write_checkpoint() tries to get cp_blkaddr from superblock buffer,
> >>> if the buffer happen to be destroied by something else, it may
> >
> > Yunlei,
> >
> > You mean hacking in memory? could you share more about process of destroying?
> 
> I do some test on kernel version 3.10 like this:
> 
> with mounted f2fs partition, use dd to erase the first sb
> 
> dd if=/dev/zero of=/dev/sdx bs=4k count=1
> 
> then sync, and the system will panic.
> 
> the log added in function do_checkpoint show:
> 
> heyunlei:start_blk = 0
> 
> So maybe dd dirty the super block buffer stored in sbi.

Ah, I can understand your concerns now, thanks for your explanation! :)

> 
> But, in latest dev branch, it has no problem, I don't know why.

I do the test with latest dev branch, it shows warning dmesg info as
F2FS_CHECK_FS is off. I think it has problem actually.

> >> Need to consider f2fs_commit_super and kfree() in put_super.
> >
> > How about releasing grabbed block buffer 'sbi->raw_super_buf' since we
> > already had one copy of it?

Hi Jaegeuk, Yunlei,

Any thoughts?


------------------------------------------------------------------------------
