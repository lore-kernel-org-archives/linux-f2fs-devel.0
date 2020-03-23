Return-Path: <SRS0=IH0A=5I=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDA1C54FCE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2020 01:42:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB40206F9;
	Mon, 23 Mar 2020 01:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jyvzI3b3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dGgnHCWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB40206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jGC6t-0005QK-2L; Mon, 23 Mar 2020 01:42:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jGC6r-0005QC-M4
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Mar 2020 01:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DwNS2HPcjR3jO69i8hfNtxf58En8mmuAqK859VaYiUI=; b=jyvzI3b3gvqP2zcekVLJw5cdeT
 0z7XKNzoPQJ37yoI84Gn1HcHyFqqm+iGrIl+CVnZiMQI/Xv6IOI+59W/khh0h6eujYBE3bM/C0esT
 zm1sTjfx1jNLK5oeKzIuxyH2PEwfVtS3bek1LVyfHPF7O/EzKP3aI4AG33TJf31FEzaQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DwNS2HPcjR3jO69i8hfNtxf58En8mmuAqK859VaYiUI=; b=dGgnHCWIu1e15FCt5WclESmiMu
 oq1iqOB53t3pb9FPpTojndBZa0YyNvdpDRU+64Pg0rifcDAdagf3vTthG4TReAcQnPhiKX72wEwvw
 ip/Cl3bkhPT/pB/pkZZUuVjlY4/6CLi7REN1f377L1ljsywt1c16eZx8fm3sARnTTABo=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jGC6l-000Nhm-Rm
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Mar 2020 01:42:33 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 188EEA22B45C05522922;
 Mon, 23 Mar 2020 09:42:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 23 Mar
 2020 09:42:18 +0800
To: chenying <chen.ying153@zte.com.cn>, <jaegeuk@kernel.org>
References: <1584754308-39299-1-git-send-email-chen.ying153@zte.com.cn>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <26f11617-92e4-1dc5-38fd-5048e92e059e@huawei.com>
Date: Mon, 23 Mar 2020 09:42:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1584754308-39299-1-git-send-email-chen.ying153@zte.com.cn>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jGC6l-000Nhm-Rm
Subject: Re: [f2fs-dev] [PATCH] ENOSPC returned but there still many free
 segments
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
Cc: wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
 xue.zhihong@zte.com.cn, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/3/21 9:31, chenying wrote:
> I write data to a compressed file when the disk space is almost full
> and it return -ENOSPC error, but cat /sys/kernel/debug/f2fs/status
> shows that there still many free segments.

free segments include reserved segments, so its value should never be zero,
otherwise there should be a bug.

BTW, could you check result in 'stat -f <your_mountpoint>' rather than f2fs
status in debugfs?

> 
> Signed-off-by: chenying <chen.ying153@zte.com.cn>
> ---
>  fs/f2fs/compress.c | 5 ++++-
>  fs/f2fs/file.c     | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index d8a64be..6ca058b 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -854,6 +854,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  				fio.compr_blocks++;
>  			if (__is_valid_data_blkaddr(blkaddr))
>  				f2fs_invalidate_blocks(sbi, blkaddr);
> +			else if (blkaddr != NULL_ADDR)
> +				dec_valid_block_count(sbi, dn.inode, 1);
>  			f2fs_update_data_blkaddr(&dn, COMPRESS_ADDR);
>  			goto unlock_continue;
>  		}
> @@ -865,7 +867,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  			if (__is_valid_data_blkaddr(blkaddr)) {
>  				f2fs_invalidate_blocks(sbi, blkaddr);
>  				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
> -			}
> +			} else if (blkaddr != NULL_ADDR)
> +				dec_valid_block_count(sbi, dn.inode, 1);

I don't think this is correct, you could check message in git pull of 5.6:

Quoted:

"f2fs-for-5.6

In this series, we've implemented transparent compression experimentally. It
supports LZO and LZ4, but will add more later as we investigate in the field
more. At this point, the feature doesn't expose compressed space to user
directly in order to guarantee potential data updates later to the space.
Instead, the main goal is to reduce data writes to flash disk as much as
possible, resulting in extending disk life time as well as relaxing IO
congestion. Alternatively, we're also considering to add ioctl() to reclaim
compressed space and show it to user after putting the immutable bit.
"

That means we will keep reserved blocks in compressed cluster until user
release them via ioctl.

Thanks,

>  			goto unlock_continue;
>  		}
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 0d4da64..f07c9e2 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -589,6 +589,10 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>  			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
>  
>  		f2fs_invalidate_blocks(sbi, blkaddr);
> +		if (compressed_cluster &&
> +			(blkaddr == NEW_ADDR || blkaddr == COMPRESS_ADDR))
> +			continue;
> +
>  		nr_free++;
>  	}
>  
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
