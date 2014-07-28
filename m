From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] Remove an unnecessary line
	in	allocate_data_block.
Date: Mon, 28 Jul 2014 13:35:37 +0800
Message-ID: <003c01cfaa25$dc91ac80$95b50580$@samsung.com>
References: <5225212.3741406502181304.JavaMail.weblogic@epv6ml08>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XBdbs-00065H-Sk
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Jul 2014 05:36:32 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XBdbq-0001X2-ML
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Jul 2014 05:36:32 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9E00MCLQ8MWU40@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Jul 2014 14:36:22 +0900 (KST)
In-reply-to: <5225212.3741406502181304.JavaMail.weblogic@epv6ml08>
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
To: dh.sim@samsung.com
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Dongho,

> -----Original Message-----
> From: Dongho Sim [mailto:dh.sim@samsung.com]
> Sent: Monday, July 28, 2014 7:03 AM
> To: jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] Remove an unnecessary line in allocate_data_block.
> 
> Hi. There was an unnecessary line in function, allocate_data_block.
> It is already done in
>    refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
> 
> Thanks.

Agreed,
How about removing old_cursegno too as it's no longer used in allocate_data_block?

Thanks,
Yu

> 
> Signed-off-by: Dongho Sim <dh.sim@samsung.com>
> ---
>  fs/f2fs/segment.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8a6e57d..a3c7aae 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1001,7 +1001,6 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  	 * since SSR needs latest valid block information.
>  	 */
>  	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
> -	locate_dirty_segment(sbi, old_cursegno);
> 
>  	mutex_unlock(&sit_i->sentry_lock);
> 
> --
> 1.9.1
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
