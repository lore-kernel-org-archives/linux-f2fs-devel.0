Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78933D1CA14
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Nov 2024 01:54:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t88lw-0005N5-8Y;
	Tue, 05 Nov 2024 01:54:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t88lu-0005Mn-UN
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Nov 2024 01:54:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1FQeTwXvdyoTZ//kKNadkeycG9CD4exL2xuSlkw0tOA=; b=It3msqYdkDTa+0RJzp9XbbGXop
 NVmUlp+JDGR1LVo86MNT7L+c3YjkC+icVxUkeI3y6luHam2z6I7veeBdEj51lX66sTas/Ql8Q+2q2
 GX2yoX6jfMEe9fWTb4lRWEgExJ8/rPyp2eGoTq3PVMhHkItbrY7qpNVtopYAuSzkx/FE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1FQeTwXvdyoTZ//kKNadkeycG9CD4exL2xuSlkw0tOA=; b=TN1JrNgdqe3RjLzV4X4UJmpLra
 qnmdKosMqDjoJssQMrs5gZU4QbyF5h7mOwyn76m9B3FTCzUzwUk2Xz87pr4HtfhFCbkotB3Cs+r9w
 4Vx4S74zfn0uB7tpy18F33pUr5tvcrUYBrjpOCC5JFA/UlucwHcA0scoT8xHEFwQkcbA=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t88lu-0007Od-87 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Nov 2024 01:54:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6FE1DA41C73;
 Tue,  5 Nov 2024 01:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871CCC4CECE;
 Tue,  5 Nov 2024 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730771647;
 bh=eVOa5xQIw5wXVux6yc3Qr0qhE7PGTsAlDSGrhyEDVSI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=Y7T5d9WmL2E5oZQt6fioBSN0Gu3FqRsW3rR+SpN8WpwjvMmV8VWhmQiyRoTxiU8uf
 s4XbBQQWmmYypsX0hrPBrJyhyvZzVDfy0M+YkwKNk8pmS0pFWfxEunjHeA5u8tf9xV
 U9zUdwmr2F98agTHWoV2338WVNH0Y9S9cqYDbfRP5lr3J+tmsLAWrhAVYYPFuFXEiv
 vq6mwSDd0kqTX00go5eMUxH8V88c2yhq0t6+EZLFapmVgAIt68xG7jTNH1klBrCnvp
 zi3eq3t0ouSfkVSuxK48O4k4VGMxZFmavM6Zuf6p22h4WWvIcRq3IgccZynkHWQTlA
 HGbtFdIFhhTSg==
Message-ID: <40643403-1209-465f-bede-a990d4b564e5@kernel.org>
Date: Tue, 5 Nov 2024 09:54:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, daeho43@gmail.com
References: <20241029134551.252-1-yohan.joung@sk.com>
Content-Language: en-US
In-Reply-To: <20241029134551.252-1-yohan.joung@sk.com>
X-Headers-End: 1t88lu-0007Od-87
Subject: Re: [f2fs-dev] [PATCH v2] mkfs.f2fs: adjust zone alignment when
 using convention partition with zoned one
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/29 21:45, Yohan Joung wrote:
> When formatting conventional partition with zoned one, we are already
> aligning the starting block address of the next device to the zone size.
> Therefore, we do not align the segment0 address to the zone alignment.
> This reduces the wasted zone_align_start_offset.
> 
> Test result
> segment0 blkaddr 389583 -> 119251
> Add one additional section to main
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>   mkfs/f2fs_format.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index a01b19e..52a1e18 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -266,6 +266,7 @@ static int f2fs_prepare_super_block(void)
>   	uint32_t log_sectorsize, log_sectors_per_block;
>   	uint32_t log_blocksize, log_blks_per_seg;
>   	uint32_t segment_size_bytes, zone_size_bytes;
> +	uint32_t alignment_bytes;
>   	uint32_t sit_segments, nat_segments;
>   	uint32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
>   	uint32_t total_valid_blks_available;
> @@ -305,10 +306,12 @@ static int f2fs_prepare_super_block(void)
>   
>   	set_sb(block_count, c.total_sectors >> log_sectors_per_block);
>   
> +	alignment_bytes = c.zoned_mode && c.ndevs > 1 ? segment_size_bytes : zone_size_bytes;
> +
>   	zone_align_start_offset =
>   		((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE +
> -		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> -		zone_size_bytes * zone_size_bytes -
> +		2 * F2FS_BLKSIZE + alignment_bytes  - 1) /
> +		alignment_bytes  * alignment_bytes  -

round_up(..., alignment_bytes) * alignment_bytes - ?

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>   		(uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
>   
>   	if (c.feature & F2FS_FEATURE_RO)
> @@ -327,7 +330,8 @@ static int f2fs_prepare_super_block(void)
>   
>   	if (c.zoned_mode && c.ndevs > 1)
>   		zone_align_start_offset +=
> -			(c.devices[0].total_sectors * c.sector_size) % zone_size_bytes;
> +			(c.devices[0].total_sectors * c.sector_size -
> +			 zone_align_start_offset) % zone_size_bytes;
>   
>   	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
>   	sb->cp_blkaddr = sb->segment0_blkaddr;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
