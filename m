Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADACCA9EC7
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m2S+2IUDyTM20nb6GZK5Nqt0YziqUtdsoQPjlv55+6Q=; b=dsjXfdF4r+3F2juWyXWphDTNxY
	B0hKXXXWkdzR2KhlTmFngJGJ20qcEIVKv9j+WbZyBwN/F21JR/lWhdMfzCkAmRlSZkkh4p9+5JyqV
	Tr8rSoIc1AdjwiTkmGSOl2P1nrYvOBPa8Aj05rU7PrIo6GWnCqfQMGrJ13+tJAJc3cNM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFp87-00076s-IU;
	Sun, 11 Oct 2026 08:42:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFp86-00076d-8C
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 08:42:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VlEHJWU8rK1qb2VSJY0s5LgiMqQdCzRFKqBueC3zOXo=; b=HM2xSU9YOALBb8asi6jsmigcRo
 syGOL/Wz5VW7vv7fNcBFHFgNspIvCHQs2k/yFS0qGF6/0AKC9PpGWuRzw9uUNy8dFMRtA9jCDPlhq
 r7e0wDz4ZoELfNS8nRf/XeYH4l4kZ1z+Jo+SQEyEiezCWGS0yJMPUL5KNc6KO2D9PRcg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VlEHJWU8rK1qb2VSJY0s5LgiMqQdCzRFKqBueC3zOXo=; b=W8kl25QJJKHOJbR/wPCBiN0uuS
 z8t9qw6gvXlvvd7vpmiWQ66kMdMInzaTSFfOCmMo3UHdRq80dxFBUuE6l1rKciGr2Q1GrZ6ChDhyU
 QWHTkyyGac8g5/PTlNzEuRru7wNK74TKjyfr/IuVPZw+8RjyyrlcfeafPRECKlurHKjw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFp86-00065i-89 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 08:42:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 848B2600AA;
 Sun, 11 Oct 2026 08:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7451F0089B;
 Sun, 11 Oct 2026 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791708116;
 bh=VlEHJWU8rK1qb2VSJY0s5LgiMqQdCzRFKqBueC3zOXo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=duFx/e3uTE79a4cra8caXhaKnf/358FA9n/078vwsK9R438CcYuFlMRM7us/HdjSw
 /vTLCnf6IgdU2YIF0ewpio1BAat1kggY2e5qfeYuUOgKec6KQHNSq4JWIFSa6p7ZLC
 2y0CuVq68v3DM8hUVWwlrmGbQULbSG6lSF2kcycRq9I1zV1pDn5tn0oQcA6zvS3v78
 HmqKNlQMhADhWIR0QA9A95VVIbcloAFEgs0PVU3U0DHpMxtiGd9ezJoqsBEwpsiaFS
 e6tLiN1O7NsblmQbxhcQQB3McVj+29jU6cfuU2CpEn/9hV8zNxwe0bLM6rC3ouazlF
 OmmEXa21s9zOw==
Message-ID: <00c340f7-723c-4b17-a5db-17906ff2951a@kernel.org>
Date: Sun, 11 Oct 2026 16:41:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20261002064853.37782-1-jsjlee1020@gmail.com>
Content-Language: en-US
In-Reply-To: <20261002064853.37782-1-jsjlee1020@gmail.com>
X-Headers-End: 1xFp86-00065i-89
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid unnecessary reads in
 f2fs_update_meta_block()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/2/26 14:48, Seongjae Jeong wrote:
> When the packed SSA feature is enabled, f2fs_update_meta_block()
> uses f2fs_get_meta_cache_retry(), which reads the target block from
> disk if the cache entry is not uptodate.
> 
> However, f2fs_update_meta_block() overwrites the entire filesystem
> block with memcpy(), so the existing contents are not needed.
> Partial updates to packed SSA blocks are handled separately in
> write_sum_block().
> 
> Use f2fs_grab_meta_cache() unconditionally to avoid reading blocks
> that will be fully overwritten. Also remove the error check, since
> f2fs_grab_meta_cache() retries allocation failures internally and
> does not return an error pointer.
> 
> Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
> ---
>   fs/f2fs/segment.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 794e0d99fc7c..51858f64e43e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2844,13 +2844,7 @@ void f2fs_update_meta_block(struct f2fs_sb_info *sbi,
>   {
>   	struct f2fs_cached_block *entry;
>   
> -	if (!f2fs_sb_has_packed_ssa(sbi))
> -		entry = f2fs_grab_meta_cache(sbi, blk_addr);
> -	else
> -		entry = f2fs_get_meta_cache_retry(sbi, blk_addr);
> -
> -	if (IS_ERR(entry))
> -		return;
> +	entry = f2fs_grab_meta_cache(sbi, blk_addr);

Daeho,

 From code side, I feel this is clean.

But, could you double check this cleanup? in case if we handle this
intentionally in original patch for something.

Thanks,

>   
>   	memcpy(cache_address(entry), src, F2FS_BLKSIZE(sbi));
>   	f2fs_mark_cache_dirty(entry);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
