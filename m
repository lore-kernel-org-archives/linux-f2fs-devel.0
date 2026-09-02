Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A86C61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sM9I9FeMZnpC94p0A6XO06j/Ib4jFqpDKDAwSLwuuiM=; b=WkRnoXp+J8QQL7CPP/aTcUFRL5
	P4ZIqvG7ZMLldqcPgMb5ZVwQtktAh1xFwWObdbDI87AY/wBJ6ZQiheiUH5ifuLV7kN+tDDTcikHda
	WK8UlqFL7zfPXvzBUZ/cDJkE4BzISn8ZGDj55VfKbxThRyOiez9EsD4q680q3PruKuF4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1fns-00051z-8v;
	Wed, 02 Sep 2026 07:54:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1fnq-00051t-HC
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W/NCmJbP7+6fQziptMjAVLT3yF8rXVSjHoR3kv4O6h8=; b=g5lsuUDxHar/vLyJhh2JSaaHx4
 zS7SYL92sbvTfHtelCi2tIbG5HXvl+N/BqnrndcazqEcwhkQVH4YINr+vWhj3anuy1czSJsY9rlpF
 Lbs+/nU2zPY7HR7W0HBrDkWdLseGyP15SAJaZ0lnyQsHwFp1Mgnt4vH6BXPzMLshKuoU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=W/NCmJbP7+6fQziptMjAVLT3yF8rXVSjHoR3kv4O6h8=; b=NHBQ1ibXPhIUJzr3KEvvdqoivd
 nbo53wSRd5ihcmtg6M2CzwrrcMZNjXojCfKulTZHcH+ZNrisb7V2vGWXQhJ2aC87KMSYsmRMl1QqG
 X+dEJ3FUGI2cJcoZ/pSr7E4hngUOh8UoLHz94nxtnJcbJHaK88f8ZP8qGueeK3E5J16o=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1fnn-0002s4-C8 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:54:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADB85600C8;
 Wed,  2 Sep 2026 07:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDF81F000E9;
 Wed,  2 Sep 2026 07:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788335669;
 bh=W/NCmJbP7+6fQziptMjAVLT3yF8rXVSjHoR3kv4O6h8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=U0u/+gyB8DPDHQkXsjldsEyAEQd2s3iKW7WWxntckMTpJA2wO1liM4zm5lo9utn/f
 jOEPejtSqt2rwUyhS6qCIuSSugKpcPjTQ7B9SRIPolPsvu1GY/CxCgBhNiHK1pG/Hy
 DPGf7uB5eFBHDoZFTSv8CjVolJfFoVz/HkkE+3VpJ22RNRzGQl8EQtAEPMxpujVdjX
 F6eRX2/KN/2AjoZBA0uj4TZPYzRA4c8/noH7B6BPkMRqSan8pMxRClneZZL4aiu/Er
 WEpgEPyXi1yfcN6+nSBlmPNYFu5L46gPCNZaA3vSZKm7eil2LwW4RfMboQjQzj+rrl
 M6paYiu6i2KaQ==
Message-ID: <1c07afb0-337b-4dec-a6fe-b4bd40e4bdfa@kernel.org>
Date: Wed, 2 Sep 2026 15:54:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260901201740.4040807-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260901201740.4040807-1-daeho43@gmail.com>
X-Headers-End: 1x1fnn-0002s4-C8
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: drop pending discard commands
 before reserving device alias
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org,
 Wenjie Qi <qiwenjie@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/2/26 04:17, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When reserving a device alias via f2fs_ioc_reserve_dev_alias(),
> f2fs_reserve_device_alias() bulk-marks all blocks in the target device
> range as valid in SIT.
> 
> However, if the device was previously in the released state, stale
> pending discard commands covering that range may still exist in dcc->root.
> When f2fs_issue_discard_thread later processes those commands,
> __check_sit_bitmap() detects valid blocks in the discard range and
> triggers a kernel BUG().
> 
> To fix this:
> 1. Introduce f2fs_drop_discard_cmd_range() to traverse the discard rbtree,
>    drop all pending D_PREP discard commands in the range,
>    and wait for any in-flight discard bios under dcc->cmd_lock.
> 2. Call f2fs_drop_discard_cmd_range() in f2fs_ioc_reserve_dev_alias()
>    before f2fs_reserve_device_alias().
> 
> Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
> Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v3: introduce cur to prevent 32-bit overflow.
> v2: fix use-after-free and 32-bit overflow issues.
> ---
>  fs/f2fs/f2fs.h    |  2 ++
>  fs/f2fs/file.c    |  1 +
>  fs/f2fs/segment.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 511286432483..ae109d3ae571 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4122,6 +4122,8 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
>  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
>  int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
>  void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> +void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
> +					block_t start, block_t len);
>  void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
>  bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
>  void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 29cf82d02c77..0b2d173d9597 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3855,6 +3855,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
>  	write_unlock(&et->lock);
>  	clear_inode_flag(inode, FI_NO_EXTENT);
>  
> +	f2fs_drop_discard_cmd_range(sbi, ei.blk, ei.len);
>  	f2fs_reserve_device_alias(sbi, ei.blk, ei.len);
>  
>  	i_size_write(inode, (loff_t)ei.len << sbi->log_blocksize);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ac0ed8609c1f..6826cb7ab34d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1873,6 +1873,51 @@ static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
>  	return discard_blks;
>  }
>  
> +void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
> +					block_t start, block_t len)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> +	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> +	struct discard_cmd *dc, *wait_dc;
> +	u64 cur = start;
> +	u64 end = (u64)start + len;
> +
> +	if (!f2fs_realtime_discard_enable(sbi))
> +		return;
> +
> +next:
> +	wait_dc = NULL;
> +
> +	mutex_lock(&dcc->cmd_lock);
> +	while (cur < end) {
> +		dc = __lookup_discard_cmd_ret(&dcc->root, cur,
> +				&prev_dc, &next_dc, &insert_p, &insert_parent);
> +		if (!dc)
> +			dc = next_dc;
> +
> +		if (!dc || (u64)dc->di.lstart >= end)
> +			break;
> +
> +		if (dc->state == D_PREP) {
> +			cur = (u64)dc->di.lstart + dc->di.len;
> +			__remove_discard_cmd(sbi, dc);
> +			continue;

Any chance to limit the loop count to avoid holding cmd_lock lock for
long time, in case we encounter an extreme fragment scenario, e.g. in
2gb range, there will be 256k small discards at most?

Thanks,

> +		}
> +
> +		dc->ref++;
> +		cur = (u64)dc->di.lstart + dc->di.len;
> +		wait_dc = dc;
> +		break;
> +	}
> +	mutex_unlock(&dcc->cmd_lock);
> +
> +	if (wait_dc) {
> +		__wait_one_discard_bio(sbi, wait_dc);
> +		goto next;
> +	}
> +}
> +
>  /* This should be covered by global mutex, &sit_i->sentry_lock */
>  static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>  {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
