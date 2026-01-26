Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43432D1950F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sh5qRBtFQoD+iOd2kBtOU/K+VL7Xu6kpFIMhQeqMVwg=; b=iDJC4RGReED7wPmZY8fvEkvZtr
	R4JRvtygEglQ76FKekRY3PN//ThExDYyZggcqR/+7ya46+XmqX9DP4MpgXuoDnbmqEOOW9xf3NJC2
	41WdlmJbx72vyI2fPdyGu1duSqitIeDtvSRUpod0WiLpb0uYow1dl6qpaHJy2W0Xpkn8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkSFK-0002qZ-Tm;
	Mon, 26 Jan 2026 19:27:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1vkSFJ-0002qT-NP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 19:27:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l7IQnZiWxGmdnBBSYr+5Z6xRyS0VW9cBweKCXA/oI8c=; b=J/0ZMmcbs3HciWX0AwVmN5t+Zv
 roKS4ye717OzvdO571Iscjtm6CPmt1kR1phV0Jj1G+mBgLrHzaKb4xwHKL5jYvB11hkMpPzKgvXca
 k4umCZezQbxkeifzCOr4Xgr3A+EP5aDZWbQnrCkUxdK7b1z/3QB7wnwHZJ6ZX10wJXbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l7IQnZiWxGmdnBBSYr+5Z6xRyS0VW9cBweKCXA/oI8c=; b=cAR1HAL7CVDcuN4rGiJr1Icdla
 yu9MJ/1/MQiSxIvUpwLWHmCVf1neEAdQRTm3SM18+/z6UgR5JIYOgo8dcGESb53+RZo2Lxp+UeVwy
 5zs86CPKyuhudynMdkVM+y6BVmtBrK8RORARACTjvonkWcP3NcIcvJBgw6IJHm5ywqbI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkSFJ-0005sD-98 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 19:27:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0286543FF9;
 Mon, 26 Jan 2026 19:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE570C116C6;
 Mon, 26 Jan 2026 19:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769455647;
 bh=B97NDNpfhzx+raKmzXpG52g4oCZeRJj9GnaEPfjhhd8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AHtXgoK2gPjRUGkA0HqK2KIejrq3Aq8re/nXm3uRUlZ3hRBeLtmbsRcyi6AvcjaA7
 FTmsU80LMIIole/9N86INzLK+MOdlltfI1f1jHK+qIkFlQ9jUAJa6M3Lv4xHcBR/XI
 ++iI4Te0IBDdFDn7eTxZ/O9DBFGv6Tp3joNj1jKSo/bk2ktywxwv5IqX5R50dXqQh8
 FKNtc0bEw/ReWy70buaXLvtX7aTVlJzWqppLxk7g5+4Lz+Hd6iz84xGp0eHCmRHjuw
 NxwKKcDQRMtORKZAz/A6auuRnmGjU3oZjmHGdjiTpkURb8cVbf+Y+sGWerpAo3n5nm
 6zzCpud4chRFQ==
Date: Mon, 26 Jan 2026 11:27:27 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260126192727.GT5910@frogsfrogsfrogs>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-4-hch@lst.de>
X-Headers-End: 1vkSFJ-0005sD-98
Subject: Re: [f2fs-dev] [PATCH 03/16] ext4: don't build the fsverity work
 handler for !CONFIG_FS_VERITY
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 05:50:49AM +0100, Christoph Hellwig wrote:
> Use IS_ENABLED to disable this code, leading to a slight size reduction:
> 
>    text	   data	    bss	    dec	    hex	filename
>    4121	    376	     16	   4513	   11a1	fs/ext4/readpage.o.old
>    4030	    328	     16	   4374	   1116	fs/ext4/readpage.o
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Fine with me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/readpage.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index e7f2350c725b..267594ef0b2c 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -130,7 +130,8 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
>  		ctx->cur_step++;
>  		fallthrough;
>  	case STEP_VERITY:
> -		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
> +		if (IS_ENABLED(CONFIG_FS_VERITY) &&
> +		    ctx->enabled_steps & (1 << STEP_VERITY)) {
>  			INIT_WORK(&ctx->work, verity_work);
>  			fsverity_enqueue_verify_work(&ctx->work);
>  			return;
> -- 
> 2.47.3
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
