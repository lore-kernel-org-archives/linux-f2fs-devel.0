Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084D8C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jul 2026 02:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gKEeMfhmcc1VogZEXg2MhibTgg5xQ4e3l0syj7lplYc=; b=mhMPsaDdaz1rulg16lq+N0UU5o
	I3/h4O9RI7Bv/zDKELbVmGxiOU+w573X3BMHH1dhTRXDHZow5OriP20jnkTiqJ0ge4DYXulGF03tz
	J5VzK1aWMP/dPouJyAnpgqFc7HYBA3bveCD4mrVSeV4kMq3zacZdNXfPuhue3BGhvhwM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjT9A-0002LV-Uv;
	Tue, 14 Jul 2026 02:45:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wjT99-0002LP-Im
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 02:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UmrYUvOecOTt9B8UoaO0RwL8wXMTGrSb7Juth6Vpbas=; b=iXIhPr6eMA2DjdlvYjBUEf2Jrk
 b3E7QDo+togL4lUpTfUwiAC8Ts4UGG0qb/yOnPPqGiKSLyhoYGYrciQrL3bjXfhTkRP5+K1tV8J0Z
 dbM+oeoyIwZtuKleDYmu8DWYFF3to8h+K4C/Sx5729mkT3xOZdpxbqqa7GsA+TFspzV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UmrYUvOecOTt9B8UoaO0RwL8wXMTGrSb7Juth6Vpbas=; b=czVI8ty0JNz5wmS6iSOj+aQXYd
 16udkMjSKkvtoMmGGzHCr/mrOYxhZdIbhk4SKNrTKFOz5cYB5LFdAGoL99hEJTbVvD8wGk+fE1Cdz
 G1SQZNhV49OwRF3veIAmYASIA+MAVeXP4FN3UOHR4R0vBB2N9EtPeiqx9w4i2HBiuiRg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjT95-0000IP-LS for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 02:45:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B2DD4047C;
 Tue, 14 Jul 2026 02:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BB71F00A3A;
 Tue, 14 Jul 2026 02:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783997109;
 bh=UmrYUvOecOTt9B8UoaO0RwL8wXMTGrSb7Juth6Vpbas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cXCFys0+CMmDI4H/yTPXCI7a5h4St14ngMHjyWdVccXpl3Cj9juIgSWYbZDs0ep5H
 a6KN74xrYUW6wU51DoXkR867K/JaIEqokOsSoRQyGOdn4W6RTm0SxetbM2Ekig0vip
 +QSJgB9BoaTnoC953W3ylh0VY1gtxqBTewyUotVUmgKrdLYw3lo6ZkwcfQfw39c2f8
 7lrNAn+QOxKPiGZ3vW55Rjo/e4txEoGhv57e6r1z7pi19O5/bC7o5wUCHIJnzGiox1
 bGLLS1axC0mm5Z2z0zyHIb0R4ZJ2uo0ytbdrSBmLKUc/SNebNx1h8KyZpSfaAoywMB
 mcQ95JnJlmQXg==
Date: Tue, 14 Jul 2026 02:45:07 +0000
To: liujinbao1 <jinbaoliu365@gmail.com>
Message-ID: <alWis0rOEibilsuc@google.com>
References: <20260530123038.2101877-1-jinbaoliu365@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260530123038.2101877-1-jinbaoliu365@gmail.com>
X-Headers-End: 1wjT95-0000IP-LS
Subject: Re: [f2fs-dev] [PATCH] inject.f2fs: fix injecting nat/sit journal
 in compact summary
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Sheng Yong <shengyong1@xiaomi.com>, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Could you please rebase on top of f2fs-tools?

Thanks,

On 05/30, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> When CP has CP_COMPACT_SUM_FLAG set, the nat/sit journal is stored in
> compact summary blocks at start_sum_block() rather than in the regular
> summary area. However, rewrite_nat_in_journal() and
> rewrite_sit_in_journal() only handled CP_UMOUNT_FLAG and the running
> state, missing the compact summary case.This caused the fault injection
> to fail.
> 
> Fix this by adding the CP_COMPACT_SUM_FLAG check before the existing
> CP_UMOUNT_FLAG check in both functions, writing the journal to the
> correct compact summary block location.
> 
> Test steps:
> 1. NAT journal injection (nid=4, quota file):
>   inject.f2fs --nat 0 --mb block_addr --nid 4 --val 12345 /dev/block/by-name/userdata
>   Before: blkaddr unchanged (308225)
>   After:  blkaddr = 12345
> 
> 2. SIT journal injection (segno=61075, CURSEG_COLD_DATA):
>   inject.f2fs --sit 0 --blk 0x1e1da00 --mb vblocks --val 123 /dev/block/by-name/userdata
>   Before: vblocks unchanged (0)
>   After:  vblocks = 123
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
>  fsck/inject.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/fsck/inject.c b/fsck/inject.c
> index b00e356..60a2d20 100644
> --- a/fsck/inject.c
> +++ b/fsck/inject.c
> @@ -675,6 +675,14 @@ static void rewrite_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid,
>  		}
>  	}
>  
> +	if (is_set_ckpt_flags(cp, CP_COMPACT_SUM_FLAG)) {
> +		blkaddr = start_sum_block(sbi);
> +		ret = dev_write(&journal->n_nats, blkaddr << F2FS_BLKSIZE_BITS,
> +				SUM_JOURNAL_SIZE, WRITE_LIFE_NONE);
> +		ASSERT(ret >= 0);
> +		return;
> +	}
> +
>  	if (is_set_ckpt_flags(cp, CP_UMOUNT_FLAG))
>  		blkaddr = sum_blk_addr(sbi, NR_CURSEG_TYPE, CURSEG_HOT_DATA);
>  	else
> @@ -806,6 +814,14 @@ static void rewrite_sit_in_journal(struct f2fs_sb_info *sbi, unsigned int segno,
>  		}
>  	}
>  
> +	if (is_set_ckpt_flags(cp, CP_COMPACT_SUM_FLAG)) {
> +		blkaddr = start_sum_block(sbi);
> +		ret = dev_write(&journal->n_sits, (blkaddr << F2FS_BLKSIZE_BITS) + SUM_JOURNAL_SIZE,
> +				SUM_JOURNAL_SIZE, WRITE_LIFE_NONE);
> +		ASSERT(ret >= 0);
> +		return;
> +	}
> +
>  	if (is_set_ckpt_flags(cp, CP_UMOUNT_FLAG))
>  		blkaddr = sum_blk_addr(sbi, NR_CURSEG_TYPE, CURSEG_COLD_DATA);
>  	else
> -- 
> 2.43.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
