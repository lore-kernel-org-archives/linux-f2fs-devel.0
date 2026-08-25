Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3E6C5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 01:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7wY0L8rmI9rx1Bx9VZprPsnAUR1nVG5DbvKL6Q7zc3Y=; b=DhlPV7btSaFUG1Dbgmx8MyDKsZ
	A9Y90HDugOW1bID0F7O4KS9LHbiUzi3MAEYzKLHUDDPjlOacClvgcJ5oGzgljyeKFPH5jjkQ8fAkk
	t9XI089VdWLxDjnUR/sJ41IngS99Q1Si86w/U2T3XQEPm+NPZh228jNf+MwEFY7b4ON0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyfbI-0004dD-DS;
	Tue, 25 Aug 2026 01:05:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyfbH-0004cy-13
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 01:05:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/bbeR5DDaenF6lVB5BM1UM7N5XOEu/8rOw1qpbS89hE=; b=KcX1ERxlcSlwMdn+LjpHonQZLz
 ucBAcgYjnV8VYnLX5pJuUv5HLt52iKxo9ArsymUjhZHJwZroRkL1mOOaBUrzlBtyMcs7HZyNb+Kec
 3qhST1l8DODfVapiqWiiEhtoprSJHhTl29bnh6dvuzDP/HaXM83t+d41iQPSkvjzjF/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/bbeR5DDaenF6lVB5BM1UM7N5XOEu/8rOw1qpbS89hE=; b=Kl8Rc/Cc/O+aMaLtq5AOhXYLfq
 /vDggA4xjsvXPAD98pm6wOYxMdmzOgl8YqygG9sSvKoS4Sn6sRE2QgnFh3tOXcEteoV6t8wXgVYCW
 f7MooQ697UGoy7dea/JGrUoZj8yHtOjRIA2tGftUqhqysIHonnjXKm1Qahy03ZKMk/TU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyfbE-0003zV-Vr for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 01:05:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 805F84098B;
 Tue, 25 Aug 2026 01:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B3B1F000E9;
 Tue, 25 Aug 2026 01:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787619907;
 bh=/bbeR5DDaenF6lVB5BM1UM7N5XOEu/8rOw1qpbS89hE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VbKtEObGkvIRxWz5bpS2Z+/An9D4rvjyzL31XMH8fheErdCTUxky39XRIWe5nZ6H3
 lhjWqdDZS8r+0yFg7T/XZguixW/z6IQ0uR/vmb01hr3Qsi7Zg5QQwsI7nwjYterC33
 F9s8gES8LoOYk46e4G8ts/FxsLcLoSHItgFuSenD5nNR/mbCZtTXgRwAfws8G4fu2q
 vNtkJqCA+kNIiXQe03VuLNiLz/s//YgzrPnmunyzsAyxKf+lerexEgH+OL4uNNC79Y
 goCQ41267lbg7D75SknbCOAZmd74PiRzHSAkKyXxtRjPkit6x9V7i4iXzfaYAnf159
 CYuwZBa4tqpFw==
Message-ID: <2b2dc21a-a78d-416c-aa4f-7531c1b62321@kernel.org>
Date: Tue, 25 Aug 2026 09:05:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260818171412.3201082-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260818171412.3201082-1-daeho43@gmail.com>
X-Headers-End: 1wyfbE-0003zV-Vr
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
> 
> Fix this by calculating the number of already-free sections in the
> truncated range under segmap_lock, deducting them from free_sections upon
> entering free_segment_range(), and restoring them under segmap_lock on exit.

I think we need to change commit message a bit to reflect real issues?

Fixes and Cc stable line here.

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
> ---
>   fs/f2fs/gc.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 787133ee2eb2..f3a6fc6d08ae 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2200,8 +2200,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>   static int free_segment_range(struct f2fs_sb_info *sbi,
>   				unsigned int secs, bool dry_run)
>   {
> -	unsigned int next_inuse, start, end;
> +	unsigned int secno, next_inuse, start, end, end_secno;
>   	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
> +	unsigned int freed_secs = 0;
>   	int gc_mode, gc_type;
>   	int err = 0;
>   	int type;
> @@ -2210,6 +2211,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
>   	MAIN_SECS(sbi) -= secs;
>   	start = MAIN_SECS(sbi) * SEGS_PER_SEC(sbi);
>   	end = MAIN_SEGS(sbi) - 1;
> +	end_secno = GET_SEC_FROM_SEG(sbi, end);
>   
>   	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
>   	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
> @@ -2221,6 +2223,14 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
>   			sbi->next_victim_seg[gc_type] = NULL_SEGNO;
>   	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
>   
> +	spin_lock(&FREE_I(sbi)->segmap_lock);
> +	for (secno = MAIN_SECS(sbi); secno <= end_secno; secno++) {
> +		if (!test_bit(secno, FREE_I(sbi)->free_secmap))
> +			freed_secs++;
> +	}
> +	FREE_I(sbi)->free_sections -= freed_secs;
> +	spin_unlock(&FREE_I(sbi)->segmap_lock);
> +

Before f2fs_gc_range
0..89 have 10 dirty/full sections, 80 free sections.
90..99 have 5 dirty sections, 5 free sections.

FREE_I(sbi)->free_sections -= freed_secs;
free_sections = 85 - 5 = 80

After f2fs_gc_range
0..89 have 13 dirty/full sections, 77 free sections.
90..99 have 10 free sections.
free_sections = 77 (.free_sections) + 10 (secs) = 87

>   	/* Move out cursegs from the target range */
>   	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
>   		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
> @@ -2245,6 +2255,9 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
>   		f2fs_bug_on(sbi, 1);
>   	}
>   out:
> +	spin_lock(&FREE_I(sbi)->segmap_lock);
> +	FREE_I(sbi)->free_sections += freed_secs;

So, shouldn't be?
FREE_I(sbi)->free_sections += secs;

Thanks,

> +	spin_unlock(&FREE_I(sbi)->segmap_lock);
>   	MAIN_SECS(sbi) += secs;
>   	return err;
>   }



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
