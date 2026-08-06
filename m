Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304F1C55ABA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HaKEz16R05J/sRVPPtyVnkPBdYxsX30GRC5u8WbuHAY=; b=Njo1q949159nEdkDYrNL8zbPFe
	gcr5VqR3pmMSMDt9awCJvy4aFiBVKPM2vB7O88NBsJCnzNE4X8zeyH79e0HYjUWz/LA8nGYWt7TJT
	S1D/G4w5FRmcp7TG6qNiHJtnnYwe8Am1wsOeZBM+SepeawEgH0AUE7MjCKEvvWyLZRDc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wroY1-0001ld-O6;
	Thu, 06 Aug 2026 03:13:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wroXz-0001lV-Nq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 03:13:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+zqIg0ykgNJoSYGUWmXYW0MV9QikD4fJ1B7EqnSEbTs=; b=IGfJAJdf0xBt5lQm826psKGpUj
 /dADDZ4tw6LZszhjvAz9U9pakCFmtow7jYRbZL4OKUjuJaaaia9COUkDMw9SmioRZbj9pwTIkxr6M
 LvjM/v5ZRgpgFh+/mlyWU5/1O6s/01KPMnvWPBJ6+r8oBDURtxVfrYzIOvToCFwkyTWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+zqIg0ykgNJoSYGUWmXYW0MV9QikD4fJ1B7EqnSEbTs=; b=QQ8WwjWUiNjPqwtAGMGRHPZk+u
 MPsOkFxmHpITIPFCTnTBUpfj4dtFQ8LsthRtHnNoRsELLhRAPXUVOCkiGtejrHPT31Qo9NTU8qRIV
 YkWLTHp/rvLk6pNCCP8LBttapcq7u1AmhkyvrRyPBelu0GKPqyFTaQ6QzA072bXMNCv0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wroXy-000793-1m for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 03:13:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3E4140922;
 Thu,  6 Aug 2026 03:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6231F000E9;
 Thu,  6 Aug 2026 03:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785986004;
 bh=+zqIg0ykgNJoSYGUWmXYW0MV9QikD4fJ1B7EqnSEbTs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=H9tA7ipyy72XOxVxFwLjRH0nURBoa4z8AIOjDu9ozdqkaZAPRWhko495lLEoTRKmg
 UIJRD4fp4dSMamW2IEVe8/QOxfYzl1QyxS7mnopeuJQta/BI65PJ453gIwcsKYoduA
 RiVQsOSjT0jbQCpvv+J1A5HkV1Tk4h32ykmHcdqcZrh1CguF/Ua5Te41cGBiXHU76c
 ZfOQZdwMg3SZBsjNxfUaDHTZ98sn2ob5XZQaKy7ChECnR4jdEYgCCsy8+ZlzAyYM04
 t1Xtm0N14P+x3VuX5l/O9BeeXbESVYs/hM16kFr1fODWRGTcJTGVKjXOkC5XLFDLaW
 r8qz7tJWYVjpA==
Message-ID: <5e605eb3-f3d5-4903-b054-108f4d802005@kernel.org>
Date: Thu, 6 Aug 2026 11:13:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yonggil.song@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41@epcms2p7>
 <20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41@epcms2p7>
Content-Language: en-US
In-Reply-To: <20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41@epcms2p7>
X-Headers-End: 1wroXy-000793-1m
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: issue multi-device flushes in
 parallel
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
Cc: Dongjin Kim <dongjin_.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/6/26 11:08, Yonggil Song wrote:
> 
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
> The per-device bio/completion array is small and bounded (at most
> MAX_DEVICES entries), so allocate it with __GFP_NOFAIL rather than
> keeping a separate serial fallback path for allocation failure.
> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> ---
>  fs/f2fs/segment.c | 48 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d71ddb3ee918..f3d3343e012f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -566,21 +566,63 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
>  	return ret;
>  }
>  
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
>  static int submit_flush_wait(struct f2fs_sb_info *sbi, nid_t ino)
>  {
> +	struct f2fs_flush_bio *flush_bio;
> +	unsigned long devices = 0;
>  	int ret = 0;
>  	int i;
>  
>  	if (!f2fs_is_multi_device(sbi))
>  		return __submit_flush_wait(sbi, sbi->sb->s_bdev);
>  
> +	flush_bio = kmalloc(array_size(sbi->s_ndevs, sizeof(*flush_bio)),
> +				GFP_NOFS | __GFP_NOFAIL);
> +
>  	for (i = 0; i < sbi->s_ndevs; i++) {
>  		if (!f2fs_is_dirty_device(sbi, ino, i, FLUSH_INO))
>  			continue;
> -		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
> -		if (ret)
> -			break;
> +
> +		bio_init(&flush_bio[i].bio, FDEV(i).bdev, NULL, 0,
> +			 REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH);
> +		init_completion(&flush_bio[i].wait);
> +		flush_bio[i].bio.bi_private = &flush_bio[i].wait;
> +		flush_bio[i].bio.bi_end_io = f2fs_flush_end_io;
> +		devices |= BIT(i);

Can we submit bio here?

Thanks,

> +	}
> +
> +	for (i = 0; i < sbi->s_ndevs; i++) {
> +		if (devices & BIT(i))
> +			submit_bio(&flush_bio[i].bio);
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
>  	}
> +	kfree(flush_bio);
>  	return ret;
>  }
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
