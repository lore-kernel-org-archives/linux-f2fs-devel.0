Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A73AE936EC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Oct 2023 23:26:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qoBGB-0004wa-V3;
	Wed, 04 Oct 2023 23:26:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1qoBGB-0004wU-GY
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Oct 2023 23:26:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YYN3ei2EtbEC7S4HXRPXiiNWYnmcbWHzFz8b+ORcpPY=; b=h5j4jk099bvO0l/rjaq34ojYv2
 L4qDrvo5dcGqUtrrsy0av5TsTs96aJHMO4aq3ZR/jVleg0Wvxk5LGWZ3Jj/E7G3ifcn6SuPa0vEw1
 IRsbHKiXuhWFY6+UgHIzTTYhiFyj3Dk3/LDU2qfcjW4jeINwEEw2N2o9kEF3y2RCeDqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YYN3ei2EtbEC7S4HXRPXiiNWYnmcbWHzFz8b+ORcpPY=; b=gIwrO5X/BRc9mx92AAZFtOt/LQ
 wZSLZ7nY3lV/J3qOUS5GARs9+MgqMLsLcKEFSzCxKPVXWeGm2RRUUm367ubxiQQynNhkjcdnX5LD9
 CHiAz7V5pg8nBzOA1dTVQVT49HIeRqfLVDy5qBB3uMKpIW1/LLwdDWhNCvYZfW9TYkPE=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qoBG5-001u8p-Nl for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Oct 2023 23:26:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 6518AB81F75;
 Wed,  4 Oct 2023 23:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8973C433C7;
 Wed,  4 Oct 2023 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696461978;
 bh=x42U3iy9flrgCAqJT8UpF1tyjAUqScY4VU/d4Aqd980=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mjxgppsdA5lqstSvuMiI+b8noAmOjk2cYb0FcYpfV5w4J76IvO18ArPv82SUBpTst
 ykhyYoD+cZArt2H72ylPSggAbpCfLPO2Az0ZtkyIvOBkHGzkfOKn3UY5553Z9e5tQ3
 UF1hhRpJTi3G8k+L2dPswl/gEnPCb0NCX7GQdK/kiQ0Pv9L8HZ/HDW9BzBqfnFVF9W
 R8qS/YcP3uSIn4fnWZwWe/yrFqimAKRb+sSjxAyb/KNolDtVFHvTefgJ5nL30DPVBt
 96nRdo9RdNcvC7yL0Dpb/xeFnl/2fQYOWNlLPDKC9buyG/fJ0Z7lCYKkHbi82Vr+ch
 AHQjux+A3k8Ng==
Date: Wed, 4 Oct 2023 16:26:16 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <ZR30mNQEyRjzr0jm@google.com>
References: <20231003230155.355807-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231003230155.355807-1-daeho43@gmail.com>
X-Headers-End: 1qoBG5-001u8p-Nl
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: use proper address entry count
 for direct nodes
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/03, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fsck/fsck.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 78ffdb6..56a7d31 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -2894,7 +2894,7 @@ static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
>  	fsck->chk.valid_blk_cnt--;
>  	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
>  
> -	for (i = 0; i < ADDRS_PER_BLOCK(&node->i); i++) {
> +	for (i = 0; i < DEF_ADDRS_PER_BLOCK; i++) {

It seems we need to use the inode block passing by fsck_failed_reconnect_file().

>  		addr = le32_to_cpu(node->dn.addr[i]);
>  		if (!addr)
>  			continue;

3012                         fsck->chk.valid_blk_cnt--;
3013                         if (addr == NEW_ADDR)

And, we also need to skip if addr == COMPRESS_ADDR here?

3014                                 continue;
3015                         f2fs_clear_main_bitmap(sbi, addr);
3016                 }

> -- 
> 2.42.0.582.g8ccd20d70d-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
