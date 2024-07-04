Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C823C30653
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:16:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sPGhI-0008DL-Jc;
	Thu, 04 Jul 2024 07:16:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sPGhI-0008DF-5M
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Jul 2024 07:16:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=chlxel86+GROqUxrfx4RexRz9uPrUD73b4+bCPb68lU=; b=cONKZCYZBaSqurdgpEevN9HO1M
 jhGswJqks2EIjw7GVvmB+j//YjPOTB0dH1B+pSnoelMLnIBkEbBiBqRwbR3P8kfCx7tTDvtPVV7Rn
 6WDZwVtT8WRJYfg8hyJHjDHBruYr/cMdIZdSkaCUcnn95ArmCaybqFd6+Vn6sE59BwVc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=chlxel86+GROqUxrfx4RexRz9uPrUD73b4+bCPb68lU=; b=SM2plXO98Z+/dVaqpHVsvLTa0e
 OOmEPDHcSx0UD2afT7Mw/zeFa4Vbm+1yeZb3AGqBzrncADs1IL/S1HDe74+VxfM54Pe6V0PgzAefZ
 NvSNm1Y0+eTmPSSRvLxNKuZaS9Gaj5S3rZuMeb1nrZJnptbHkAHQSXEMpIm6aodi5A3s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sPGhI-0003HZ-Op for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Jul 2024 07:16:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8E2A062545;
 Thu,  4 Jul 2024 07:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD710C32781;
 Thu,  4 Jul 2024 07:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720077358;
 bh=pQbfYzQWPX0rbbB4vNj8e9Rf84wXlBV0HGoeVKAEc04=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZYyWGdMso/danZkI6QiYRlBhcTMi3EeRhJVJa0dy3SlseYpONgZzK5CXnwAtoYs+R
 VIfKDInlvzlDkopnSCLoYfaR0WzL6Jj4XsY5IDPWS0ykGCc7Z9FC7tXCeUXA+O6js+
 QuHYhNokdxfYQlHjFiezGt/MqLlRz+U3V1UgqErJb3MRHqIoE0rkJulCh+R+XAYhh5
 tcQxG2UvoWAR5/2SyVnH5NLKa9JDnjBjyB9nsx/Smw9Hr5zU48qV0EtToY/NyFsTnu
 9f5z82i/g0yb11MwrpeM+/yYBpSFdcd4vYufzjOmZuH2+HIiSu4Tl3sbrAhCVr+oVT
 VwldnW8zBmuDA==
Message-ID: <460c4708-3ec6-4fbc-8f6c-7f8e5f901061@kernel.org>
Date: Thu, 4 Jul 2024 15:15:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
 <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
X-Headers-End: 1sPGhI-0003HZ-Op
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null reference error when checking
 end of zone
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Nayeon Kim <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>,
 Seokhwan Kim <sukka.kim@samsung.com>, Dongjin Kim <dongjin_.kim@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/4 9:01, Daejun Park wrote:
> This patch fixes a potentially null pointer being accessed by
> is_end_zone_blkaddr() that checks the last block of a zone
> when f2fs is mounted as a single device.

blkzoned feature depends on multiple device feature? One regular
device and one seq-zone device?

Thanks,

> 
> Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>   fs/f2fs/data.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b6dcb3bcaef7..1aa7eefa659c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -925,6 +925,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>   #ifdef CONFIG_BLK_DEV_ZONED
>   static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
>   {
> +	struct block_device *bdev = sbi->sb->s_bdev;
>   	int devi = 0;
>   
>   	if (f2fs_is_multi_device(sbi)) {
> @@ -935,8 +936,9 @@ static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
>   			return false;
>   		}
>   		blkaddr -= FDEV(devi).start_blk;
> +		bdev = FDEV(devi).bdev;
>   	}
> -	return bdev_is_zoned(FDEV(devi).bdev) &&
> +	return bdev_is_zoned(bdev) &&
>   		f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
>   		(blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
>   }


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
