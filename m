From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: fix endianness of on-disk
	summary_footer
Date: Thu, 28 Jan 2016 16:31:57 +0800
Message-ID: <00f401d159a6$72523b50$56f6b1f0$@samsung.com>
References: <1453981226-18858-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aOi0V-0003CG-GK
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Jan 2016 08:32:47 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aOi0T-00089A-IX
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Jan 2016 08:32:47 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1N01MWHMEDNE10@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Jan 2016 17:32:37 +0900 (KST)
In-reply-to: <1453981226-18858-1-git-send-email-shengyong1@huawei.com>
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
To: 'Sheng Yong' <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Sheng,

> -----Original Message-----
> From: Sheng Yong [mailto:shengyong1@huawei.com]
> Sent: Thursday, January 28, 2016 7:40 PM
> To: jaegeuk@kernel.org
> Cc: chao2.yu@samsung.com; linux-f2fs-devel@lists.sourceforge.net; shengyong1@huawei.com
> Subject: [PATCH] f2fs: fix endianness of on-disk summary_footer
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Nice catch!

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

Thanks,

> ---
>  include/linux/f2fs_fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 25c6324..2863274 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -344,7 +344,7 @@ struct f2fs_summary {
> 
>  struct summary_footer {
>  	unsigned char entry_type;	/* SUM_TYPE_XXX */
> -	__u32 check_sum;		/* summary checksum */
> +	__le32 check_sum;		/* summary checksum */
>  } __packed;
> 
>  #define SUM_JOURNAL_SIZE	(F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
> --
> 1.9.1



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
