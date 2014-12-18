From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH v2] f2fs: merge two uchar variable in struct
 node_info to reduce memory cost
Date: Thu, 18 Dec 2014 14:29:51 +0800
Message-ID: <004c01d01a96$2b5b3a80$8211af80$@samsung.com>
References: <000001d0184a$3f09d580$bd1d8080$@samsung.com>
	<CAN863PvqCJJ-m3NimjX7FKeY941rjSgmzupfPEMHm_qXgRBwfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Y1VjK-0003gp-Fr
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Dec 2014 07:42:38 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Y1VjI-0005Nb-BJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Dec 2014 07:42:38 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NGR008F5PESZX70@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Dec 2014 16:42:28 +0900 (KST)
In-reply-to: <CAN863PvqCJJ-m3NimjX7FKeY941rjSgmzupfPEMHm_qXgRBwfQ@mail.gmail.com>
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
To: 'Changman Lee' <cm224.lee@gmail.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Changman,

> -----Original Message-----
> From: Changman Lee [mailto:cm224.lee@gmail.com]
> Sent: Wednesday, December 17, 2014 11:09 PM
> To: Chao Yu
> Cc: Jaegeuk Kim; Changman Lee; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH v2] f2fs: merge two uchar variable in struct node_info to reduce
> memory cost
> 
> Hi Yu,
> 
> This patch is effective only in 32 bit machine. In case of 64 bit
> machine, nat_entry will be aligned in 8 bytes due to pointer variable
> (i.e. struct list_head). So it can't get any benefit to reduce memory
> usage. In the case of node_info, however, it will be gain in terms of
> memory usage.
> Hence, I think it's not correct for commit log to describe this patch.
> 

Thanks for your review! :)

AFFIK, in 64 bit machine, size of struct nat_entry is 40 bytes before this patch
apply, the reason is that our compiler will fill 3 bytes pads after flag as
nid's offset should align to type size of nid, and then fill 7 byte pads after
version as size of structure should align to 64 bits when the struct size is bigger
than 64 bits.
layout of struct nat_entry:
|-----8 bytes-----|
|list.next        |
|list.prev        |
|flag    |nid     |
|ino     |blk_addr|
|version          |
After we apply this patch, size of struct nat_entry will be reduced to 32 bytes.
Please correct me if I'm wrong.

Anyway, I agreed that commit log should be uptodate.

Thanks,
Yu

> Thanks,
> 
> Reviewed-by: Changman Lee <cm224.lee@samsung.com>
> 


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
