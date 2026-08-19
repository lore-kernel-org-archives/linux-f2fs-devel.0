Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08CBC5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2026 03:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uXRt+a5J68FLZdk78kgDfcNBV11ZZT/1nJWgBzHEdYA=; b=WiXrqiwDUFq1hYWGqooPZoxCzc
	6xkWKwg/SDL4RM2YC4ZKxk24NYGI/nZorhT2fTqEhFUUfs3bKtEmnpCQDiE4Hmn6BoGxu1KbOcboY
	6YOQ4PUWo3J2jg1JRhI8CdwwL94AuHb+ZR6MApkt/CUnrOFWwdWH483fOJPd3vdkgrCc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwXQW-00056F-5u;
	Wed, 19 Aug 2026 03:57:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwXQV-000566-Mj
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 03:57:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XnES9awESo/xusek8tO1Ts1cKIH860HVRhXuI7ZnJoY=; b=daRzgP784uqafLvJl/6FNt5qDe
 W8j1XeQWLsy/xTK+4Mg2mrJ2WvqBKePtmyRuszqzjrmV6yZ1ksNgzs+pynkFsA6iOC9eIJX8p7HsR
 l0lZ6QXImVtcQB3phcgQ3Vo3uMYMSOHFLrCXMaUfABbrSJ8Ryu+Rz5lHkaSKTywlgRiI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XnES9awESo/xusek8tO1Ts1cKIH860HVRhXuI7ZnJoY=; b=a5fdg8ZF5btShJNuYgBokynuF/
 oBiSYUBwFj4H8uL6AG+OhWVkY+DufxzwaLNinRbusc9fP7hOhLRV0a1p+ysHiCQN7TKCgcdHEIncu
 uSXNsCVxvSfpHSzIoDxE0CnFefwkWX9PaBjvElJc3J+tMmg0vrJtSe7Eon9WkWmiKMqk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwXQZ-0008Ok-9a for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 03:57:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E14B4172E;
 Wed, 19 Aug 2026 03:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CB81F000E9;
 Wed, 19 Aug 2026 03:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787111834;
 bh=XnES9awESo/xusek8tO1Ts1cKIH860HVRhXuI7ZnJoY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=C/aDx5cXDNxDkLxdhXBYBSxhW0ut8sMSbOLffqBSB0XAh+7t7HoubcN4jaxQ1w1Hr
 CVDxTg2y5cN48zYle3nxhLowZ0nhIPWRPerVg9d4N9XCSFSD4mRlSwU3wT59spUkgq
 TG2l7qcDlSitqmY+aV/6h4rrhF82R2KWJVNU107utnsc+TfrJmH1LWCBdWBBQS6oc8
 yijnEMwRLXoTD0Q3a9Z12Efe7d+QQsz5NophlZqJwqSm3oRj4R92IBm3ZOv4Ksc5TW
 34T2teF+o1s/uZxmv/Tls9zS1rqojkwUVsLPSICCevL8pHKaQ5PXGNkKEEfl0O99pA
 p+LDeXEPDNBJg==
Message-ID: <0e1162de-1ad4-4c24-a5c9-cd05c5b08cc0@kernel.org>
Date: Wed, 19 Aug 2026 11:57:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260818171412.3201082-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260818171412.3201082-1-daeho43@gmail.com>
X-Headers-End: 1wwXQZ-0008Ok-9a
Subject: Re: [f2fs-dev] [PATCH] f2fs: accurately adjust free_sections during
 free_segment_range
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/19/26 01:14, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In free_segment_range(), MAIN_SECS(sbi) is temporarily reduced by `secs`
> while valid blocks in the truncated range are evacuated by GC.
> 
> However, if any sections within the truncated range were already free,
> failing to deduct them from FREE_I(sbi)->free_sections leads to an
> over-estimation of available space in the reduced main area, causing
> inconsistent free section accounting.

Can you please show me an example for above case? I didn't get it.

BTW, it needs to rebase this patch on dev-test branch.

Thanks,

> 
> Fix this by calculating the number of already-free sections in the
> truncated range under segmap_lock, deducting them from free_sections upon
> entering free_segment_range(), and restoring them under segmap_lock on exit.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
> ---
>  fs/f2fs/gc.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 787133ee2eb2..f3a6fc6d08ae 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2200,8 +2200,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>  static int free_segment_range(struct f2fs_sb_info *sbi,
>  				unsigned int secs, bool dry_run)
>  {
> -	unsigned int next_inuse, start, end;
> +	unsigned int secno, next_inuse, start, end, end_secno;
>  	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
> +	unsigned int freed_secs = 0;
>  	int gc_mode, gc_type;
>  	int err = 0;
>  	int type;
> @@ -2210,6 +2211,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
>  	MAIN_SECS(sbi) -= secs;
>  	start = MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
>  	end = MAIN_SEGS(sbi) - 1;
> +	end_secno = GET_SEC_FROM_SEG(sbi, end);
>  
>  	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
>  	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
> @@ -2221,6 +2223,14 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
>  			sbi->next_victim_seg[gc_type] = NULL_SEGNO;
>  	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
>  
> +	spin_lock(&FREE_I(sbi)->segmap_lock);
> +	for (secno = MAIN_SECS(sbi); secno <= end_secno; secno++) {
> +		if (!test_bit(secno, FREE_I(sbi)->free_secmap))
> +			freed_secs++;
> +	}
> +	FREE_I(sbi)->free_sections -= freed_secs;
> +	spin_unlock(&FREE_I(sbi)->segmap_lock);
> +
>  	/* Move out cursegs from the target range */
>  	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
>  		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
> @@ -2245,6 +2255,9 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
>  		f2fs_bug_on(sbi, 1);
>  	}
>  out:
> +	spin_lock(&FREE_I(sbi)->segmap_lock);
> +	FREE_I(sbi)->free_sections += freed_secs;
> +	spin_unlock(&FREE_I(sbi)->segmap_lock);
>  	MAIN_SECS(sbi) += secs;
>  	return err;
>  }



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
