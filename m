Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB20C54E90
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 May 2025 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wifN7XhMWxzGstr9a747I/v0R+7nmMcEC5v3nRJNDso=; b=NX86p+Ri4hy8ehAVs7Vl3jy9Am
	YlfQwe4n+/uHv3M3iljEZCY+nHYzmf967+5M/L+tZ3lwIy/XWnKkPL9H1jqD6mJtyvc6TiR9d0I7C
	HGoHJAaxdt5RSIfmvS1a4IL4uDie30SRl4jg5Wv4WnRVkuJlSHiBTXgJDEHPaGPywGuk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uI3pi-0003hw-FH;
	Thu, 22 May 2025 11:11:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uI3ph-0003hj-9F
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 May 2025 11:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QB7PJWya+yTj0MV+ageMyJpWg10O+Z1fB8scV8HF0hE=; b=UX4LxYG2zZhN4Jhr4wQjeO4XR1
 tG0XQrcyZGrorAOg6vwK57ZZ2L/NRF7Exfef947QtecebnkF42O6zrmHNtTJC5EJrpNQSFMvXW2fl
 WW3bDXc1tp7qdhaHWGXYr+VDz7hNHbfLlbcpjW4niBPJ5T0wTLR+WZDCDVAHDnJtTJEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QB7PJWya+yTj0MV+ageMyJpWg10O+Z1fB8scV8HF0hE=; b=DgtH5FICEtHmxLjzifUKuRozR9
 DwObQ47d6SNh2jOUOwYeuXffknGwzC2wi6W2DQISiUP/M5b4CFjaeYHmT/ojc7ejxZfy3hZivkEMc
 cKvVLrXYVnKDv6b8OuK0gaYhztWcQkiWsyKeP3J2KKnyI/qQIz/lJELtuBANsfXk5MWo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uI3pf-0008Vm-FD for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 May 2025 11:11:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C5E94A370;
 Thu, 22 May 2025 11:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A4FC4CEE4;
 Thu, 22 May 2025 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747912277;
 bh=aHgtBI7v+S81AM2CaYELSl4mkDoqDdn1xSKhIL81RAo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=jVvRRaVar+06zB2qK/iHi4yi0IU1sMlKvzmJRawmtVtiTsa1hhEEDTIPe48NJdHYW
 tvg8Ih33kas/6QxuYdmxVrkbKB6E9d/mEnu6AysBNRDNBQNaNERVlZXYR+1h6nPJCD
 vUTv4BAq2tuhMLW+06Zoz+su+1Rp+puTpDWnVMhLezdlxbANmZ4p/uU3hEgDUX+NPR
 T4BWvo4lOoIsjckr7KeNSlF7uZAcN7feyYQFxiYXF/alEBV02Z1+Ou1DRzcLP1nlZr
 lDW6CvLRd6p8pWDoanjvOCkWUr0LbuyYbe5Q130vAUWPQ8vCUt2M7uDNAYU6JgTMTv
 /lk52c3qmGc8A==
Message-ID: <e73ac805-b51e-4457-9f7d-7d3feaff32d8@kernel.org>
Date: Thu, 22 May 2025 19:11:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20250102101310.580277-1-guochunhai@vivo.com>
 <20250102101310.580277-2-guochunhai@vivo.com>
Content-Language: en-US
In-Reply-To: <20250102101310.580277-2-guochunhai@vivo.com>
X-Headers-End: 1uI3pf-0008Vm-FD
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix missing small discard in fstrim
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/2/25 18:13, Chunhai Guo wrote:
> If userspace issues an fstrim with a range that does not include all
> segments with small discards, these segments will be reused without being
> discarded. This patch fixes this issue.
> This patch is somewhat similar to commit 650d3c4e56e1 ("f2fs: fix a missing
> discard prefree segments").

I guess it's better to update commit message as we discussed?

> 
> Fixes: d7bc2484b8d4 ("f2fs: fix small discards not to issue redundantly")
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>  fs/f2fs/segment.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8fe9f794b581..af9a62591c49 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4552,6 +4552,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	struct list_head *head = &SM_I(sbi)->sit_entry_set;
>  	bool to_journal = !is_sbi_flag_set(sbi, SBI_IS_RESIZEFS);
>  	struct seg_entry *se;
> +	bool force = (cpc->reason & CP_DISCARD);
> +	__u64 trim_start = cpc->trim_start;
>  
>  	down_write(&sit_i->sentry_lock);
>  
> @@ -4609,7 +4611,9 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  #endif
>  
>  			/* add discard candidates */
> -			if (!(cpc->reason & CP_DISCARD)) {
> +			if (!force || (force &&

if (!force || (f2fs_realtime_discard_enable() &&
		(segno < trim_start || segno > trim_end)))

Thanks,

> +					(segno < trim_start ||
> +					 segno > cpc->trim_end))) {
>  				cpc->trim_start = segno;
>  				add_discard_addrs(sbi, cpc, false, false);
>  			}
> @@ -4649,8 +4653,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	f2fs_bug_on(sbi, !list_empty(head));
>  	f2fs_bug_on(sbi, sit_i->dirty_sentries);
>  out:
> -	if (cpc->reason & CP_DISCARD) {
> -		__u64 trim_start = cpc->trim_start;
> +	if (force) {
> +		cpc->trim_start = trim_start;
>  
>  		for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
>  			add_discard_addrs(sbi, cpc, true, false);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
