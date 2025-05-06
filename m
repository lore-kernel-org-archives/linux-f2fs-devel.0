Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA299C3ABAC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 May 2025 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2wmBKqoHMRvEQbSp3C+AcevxobIRXCJRs3AG2xfv7f4=; b=Bk0n+R3PkYCugdy1wqiYsBVjE8
	EUn0g2a3yL2gbnIc5tu7c14BTcLLBartEN8BnsrvywygKCHiSLocH/pUGlJ19T4i3tmp+F+udUBJH
	+GPyEYJhDWr9E2VUA5exW7Utqyzb1v4ZeYnPAk6J/5dshnn8mtbQfFLwjUVmjGl0lVnc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCEJI-0008UG-NB;
	Tue, 06 May 2025 09:09:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uCEJH-0008U9-6I
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 May 2025 09:09:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FicDiA5Ndp4aQtpI5oawvRLKt/0ch/nQ8rNnEovikvE=; b=blyov/vj+ZJ932ocNAwyvUIYKH
 laUSVF3pWkHqJEyUk4oCHwfpEF2TNRGjeLXGdzYddc4jgU8qpdU4HwGJTiTs9ng6X2LbuhHN1PgLY
 tic0eEv8F6e9YO2TYhOyor7Cd0ZQcYIdUnE/GU0SXMifjT8xeq/jSHAfG7MHfcKsqryw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FicDiA5Ndp4aQtpI5oawvRLKt/0ch/nQ8rNnEovikvE=; b=M0mRm8nh7RMt4z+FMcRB1Kh+W7
 MbGI2aUX34bjXNd3xoEHt0KGIxQWqg/A8EwvO2UEv0X2oFSoj33BZjh1/MeA8aCbzAQfqoNfcseHK
 MuyAO3LyNiqLrwXpHpazsbwH0MyjusgJhKx1UR3r1O5xlIR6m+Il25kQFOiauVbNC3DU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCEJ1-0006HC-NL for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 May 2025 09:09:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0951A5C0672;
 Tue,  6 May 2025 09:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CD5C4CEE4;
 Tue,  6 May 2025 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746522568;
 bh=FAVp5gt8PSpT2EQxUuM5Z3ZpVFQzfkF4ChHcboUUy+E=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=UNswAuDFp7+m3dYB43ly7MXiMujbuBIR7N0X2CDZcGdoREIfkrYH29B0GeDFBGDIu
 D4TEKeQ8B4OC6yOEdHU8cy/sV6vugnPMAaVZwcNrWCv+qzTsb2jXlGLXTdVJYjDCCx
 Fz7bthFBb3D1uK7bn2h6uzMXbwoolq/GLpoPr3QgfAFesiB8swJYAdJ6J2nCCxHMQo
 mdFmOyG+hOEfKO5lULSe4nqX3oRiX34aPsR6r7qrgEaA3zwnPSIVyaUcEGtBprAuvI
 CU2fQsKJoEKgq2U4E6iFx63ciqPpniyRPr8L1cBsx8YGZS9w7Dn2J1HDk7vVS3oyjz
 hLjCAW1KrNYrA==
Message-ID: <1db80259-a29d-439e-aaff-2a7daac9c1e5@kernel.org>
Date: Tue, 6 May 2025 17:09:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "yohan.joung" <yohan.joung@sk.com>, jaegeuk@kernel.org,
 daehojeong@google.com
References: <20250502044146.552-1-yohan.joung@sk.com>
Content-Language: en-US
In-Reply-To: <20250502044146.552-1-yohan.joung@sk.com>
X-Headers-End: 1uCEJ1-0006HC-NL
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: Add a method for calculating
 the remaining blocks in the current segment in LFS mode.
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
Cc: pilhyun.kim@sk.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2025/5/2 12:41, yohan.joung wrote:
> In LFS mode, the previous segment cannot use invalid blocks,
> so the remaining blocks from the next_blkoff of the current segment
> to the end of the section are calculated.
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>
> ---
>   fs/f2fs/segment.h | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 03c0f59be5a8..345da052f0e1 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -582,8 +582,14 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>   		if (unlikely(segno == NULL_SEGNO))
>   			return false;
>   
> -		left_blocks = CAP_BLKS_PER_SEC(sbi) -
> -				get_ckpt_valid_blocks(sbi, segno, true);
> +		if (f2fs_lfs_mode(sbi)) {

f2fs_lfs_mode() && __is_large_section(sbi)?

> +			left_blocks = CAP_BLKS_PER_SEC(sbi) -
> +				(segno - rounddown(segno, SEGS_PER_SEC(sbi))) * BLKS_PER_SEG(sbi) -

How about using SEGS_TO_BLKS() which will be more efficient? and what do you
think of introducing a new macro to improve code readability?

#define GET_START_SEG_FROM_SEC(sbi, segno)	(rounddown(segno, SEGS_PER_SEC(sbi)))

> +				CURSEG_I(sbi, i)->next_blkoff;
> +		} else {
> +			left_blocks = CAP_BLKS_PER_SEC(sbi) -
> +					get_ckpt_valid_blocks(sbi, segno, true);
> +		}
>   
>   		blocks = i <= CURSEG_COLD_DATA ? data_blocks : node_blocks;
>   		if (blocks > left_blocks)
> @@ -596,8 +602,15 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>   	if (unlikely(segno == NULL_SEGNO))
>   		return false;
>   
> -	left_blocks = CAP_BLKS_PER_SEC(sbi) -
> -			get_ckpt_valid_blocks(sbi, segno, true);
> +	if (f2fs_lfs_mode(sbi)) {

Ditto,

> +		left_blocks = CAP_BLKS_PER_SEC(sbi) -
> +				(segno - rounddown(segno, SEGS_PER_SEC(sbi))) * BLKS_PER_SEG(sbi) -
> +				CURSEG_I(sbi, CURSEG_HOT_DATA)->next_blkoff;

Ditto,

Thanks,

> +	} else {
> +		left_blocks = CAP_BLKS_PER_SEC(sbi) -
> +				get_ckpt_valid_blocks(sbi, segno, true);
> +	}
> +
>   	if (dent_blocks > left_blocks)
>   		return false;
>   	return true;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
