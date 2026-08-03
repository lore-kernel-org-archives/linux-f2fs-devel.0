Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC72C55162
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eL1AP/SMjiJRNrdSddN1kPb1j46hHdK+I+R1WALmGMg=; b=SsDyFYCN8vjkuVENw8bQB5lzio
	GoiOdmNCYlZbyTV5o3sJbdTvsMiIvRL7B8gYyRJUs/ZSfw+sUg4cl2XzY+ebGeoLh2OzOi6T3IO/w
	wIZnAdJsAdIVsNTEm8ibMJc8XiaMUftoxoRgzim+UnUWURADAL/LGetJ3o2h37bZH5PE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqmeI-0005tY-SV;
	Mon, 03 Aug 2026 06:59:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqmeH-0005tQ-Dc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 06:59:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=37UE+zEK5cc8ff/wYweX5ca4u9HVNotxR09GlvhGqwM=; b=iRcDluTweaz02LwuEtOTqubhdM
 hjk+w21SsWTF6HIY80izl0J7mAOrX3vcNel6CIqGsSt0xz/9ogn09RMH+DQZJRYgf3feL2e946Hvf
 hOKsi3X+LpouvylOXFTfeLsFBgyaRsjWFEtWKOtTEwhp40xNRoSERUtjJ3gq2ahEvgEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=37UE+zEK5cc8ff/wYweX5ca4u9HVNotxR09GlvhGqwM=; b=MQVYCZ29Tp3QLmOtVQXuYTbU2A
 ZtL+ijeFGZleN5XufXnM/s51hjdVr5OwVM22I9B2poBhy1G29bwIFZ7Xhws82I8flR3TKMLdxbUzy
 tD9wETtJa1/q/Z8vToQIpLjBYO8nVxcVPtDNuccZyX8zBKwhsP16qTpWYacJvYAHRUfE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqmeD-0005W2-C7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 06:59:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AFF3D60A58;
 Mon,  3 Aug 2026 06:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020311F000E9;
 Mon,  3 Aug 2026 06:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785740375;
 bh=37UE+zEK5cc8ff/wYweX5ca4u9HVNotxR09GlvhGqwM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=LcIFT9oEcMSU8du99sOPLL4hXjeCx7FaiI2jZIrqWCRXpBnh8yQSeoqZT6jArgNwb
 LwSRlkYBn2aZodGrmAFaT/HgvtHARyLkO4GC+/jyZ4vH/Qytfi4U8gy9qlLVa6NP9h
 cfeE/sHcAcBWE1/iPzWYN0Db0sNiadIMRr5W1MvAseA9QH0ThSR+bFOxJfJHCd1JEQ
 jJXisxeVcxHHNFI3agsEX5QdAP/8xzMzQgQUZs1yTgPJKS0fs0Z8qvwrmpXucgny0p
 suHbQAX2fdru28h9xhBVnBtJ9ggAEXKxzQjDDAuN/tOPPdxFrlLCHaAhE0CX8kk//F
 NS0PT6zVG7rnQ==
Message-ID: <9fc81e1e-ec13-4cc0-9aed-8270bf1a4157@kernel.org>
Date: Mon, 3 Aug 2026 14:59:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yonggil.song@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <CGME20260713055711epcms2p712e7add62211e42e995c54a92fd4ff0c@epcms2p7>
 <20260713055711epcms2p712e7add62211e42e995c54a92fd4ff0c@epcms2p7>
Content-Language: en-US
In-Reply-To: <20260713055711epcms2p712e7add62211e42e995c54a92fd4ff0c@epcms2p7>
X-Headers-End: 1wqmeD-0005W2-C7
Subject: Re: [f2fs-dev] [PATCH] f2fs: issue multi-device flushes in parallel
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dongjin Kim <dongjin_.kim@samsung.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/13/26 13:57, Yonggil Song wrote:
> On a multi-device setup, submit_flush_wait() walked the dirty devices
> in order and aborted the whole loop on the first device whose flush
> failed, leaving the remaining dirty devices un-flushed. Each device
> still needs its own data made durable, so a failure on one device must
> not skip the others. It also waited for one device's flush to complete
> before issuing the next, even though the devices have independent
> flush queues and could be flushed concurrently.
> 
> Flush every dirty device best-effort and in parallel instead: build
> one PREFLUSH bio per dirty device, submit them all, then wait for
> every completion, returning the first error seen (0 if all succeed).
> This bounds the flush window by the slowest device rather than the sum
> of all of them. No caller depends on the previous early-abort
> behaviour -- fsync only checks whether the return value is zero
> (fs/f2fs/file.c). The checkpoint path (f2fs_flush_device_cache) is
> unaffected; this only touches the fsync flush path.
> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> ---
>   fs/f2fs/segment.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 78 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d71ddb3ee918..51d7f76e3d1d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -566,24 +566,96 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
>   	return ret;
>   }
>   
> -static int submit_flush_wait(struct f2fs_sb_info *sbi, nid_t ino)
> +static void f2fs_flush_end_io(struct bio *bio)
> +{
> +	complete(bio->bi_private);
> +}
> +
> +struct f2fs_flush_bio {
> +	struct bio bio;
> +	struct completion wait;
> +};
> +
> +/*
> + * Flush every dirty device best-effort: a failure on one device must not
> + * skip the flush on the remaining dirty devices, since each device still
> + * needs its own data made durable. Report the first error.
> + */
> +static int submit_flush_wait_serial(struct f2fs_sb_info *sbi, nid_t ino)
>   {
>   	int ret = 0;
>   	int i;
>   
> -	if (!f2fs_is_multi_device(sbi))
> -		return __submit_flush_wait(sbi, sbi->sb->s_bdev);
> +	for (i = 0; i < sbi->s_ndevs; i++) {
> +		int err;
> +
> +		if (!f2fs_is_dirty_device(sbi, ino, i, FLUSH_INO))
> +			continue;
> +		err = __submit_flush_wait(sbi, FDEV(i).bdev);
> +		if (err && !ret)
> +			ret = err;
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Same best-effort/first-error contract as submit_flush_wait_serial(), but
> + * issue every dirty device's flush before waiting for any of them, so the
> + * per-device flush latencies overlap instead of adding up in series. Fall
> + * back to the serial path if the bio array cannot be allocated.
> + */
> +static int submit_flush_wait_parallel(struct f2fs_sb_info *sbi, nid_t ino)
> +{
> +	struct f2fs_flush_bio *flush_bio;
> +	unsigned long devices = 0;
> +	int ret = 0;
> +	int i;
> +
> +	flush_bio = kcalloc(sbi->s_ndevs, sizeof(*flush_bio), GFP_NOFS);

Can we allocate flush_bio in local stack? so that we don't need to fallback
to submit_flush_wait_serial() for low memory case?

> +	if (!flush_bio)
> +		return submit_flush_wait_serial(sbi, ino);
>   
>   	for (i = 0; i < sbi->s_ndevs; i++) {
>   		if (!f2fs_is_dirty_device(sbi, ino, i, FLUSH_INO))
>   			continue;
> -		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
> -		if (ret)
> -			break;
> +
> +		bio_init(&flush_bio[i].bio, FDEV(i).bdev, NULL, 0,
> +			 REQ_OP_WRITE | REQ_PREFLUSH);
> +		init_completion(&flush_bio[i].wait);
> +		flush_bio[i].bio.bi_private = &flush_bio[i].wait;
> +		flush_bio[i].bio.bi_end_io = f2fs_flush_end_io;
> +		submit_bio(&flush_bio[i].bio);
> +		devices |= BIT(i);
> +	}
> +
> +	for (i = 0; i < sbi->s_ndevs; i++) {
> +		int err;
> +
> +		if (!(devices & BIT(i)))
> +			continue;
> +
> +		wait_for_completion(&flush_bio[i].wait);
> +		err = blk_status_to_errno(flush_bio[i].bio.bi_status);
> +		trace_f2fs_issue_flush(FDEV(i).bdev, test_opt(sbi, NOBARRIER),
> +				       test_opt(sbi, FLUSH_MERGE), err);
> +		if (!err)
> +			f2fs_update_iostat(sbi, NULL, FS_FLUSH_IO, 0);
> +		else if (!ret)
> +			ret = err;
> +		bio_uninit(&flush_bio[i].bio);

It may leak bio reference previously? For local bio variable, there is no such issue.

Thanks,

>   	}
> +	kfree(flush_bio);
>   	return ret;
>   }
>   
> +static int submit_flush_wait(struct f2fs_sb_info *sbi, nid_t ino)
> +{
> +	if (!f2fs_is_multi_device(sbi))
> +		return __submit_flush_wait(sbi, sbi->sb->s_bdev);
> +
> +	return submit_flush_wait_parallel(sbi, ino);
> +}
> +
>   static int issue_flush_thread(void *data)
>   {
>   	struct f2fs_sb_info *sbi = data;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
