Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556F606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VlqVKGMF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HJDZvqbj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=b2+igpho;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCIU4yYG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TbfQXmIsEV6uWsSFA6bMDaqxnga7LyD8AL/6zzHhDk4=; b=VlqVKGMFclKyPFO0HlKCeUXdoW
	/I9G1bCqTqwiYzTDMqZzInLiH5U1ngi4XPVg46zZoE7hy0nXkdcTYit0POpVOvBPlRvle4QOC4u/t
	bgUtEjz0asKDz0Xf06KpV7+wYbFTzW38aL3HiN0BuOSZmz1zDIU7CD+beXv5l7HUaNXw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZFv-000000003jB-29f1;
	Mon, 23 Nov 2026 18:59:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZFu-000000003j3-0xXX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9zxKMTvX0b8A/4ZVTHzDzbGbHP86KnIHQCF5pYs+z+o=; b=HJDZvqbj1LrQKLzbFot7NsLubI
 Rovf/Ke6EtW9HfVZ5e1z0WGbmIlgE5PEK4a7iGSjsa5VvDuAVn3k04Rdce2dmMEKTdh664nvip2X6
 j6WuWT5uarVrSvNQyzHUu/rqY1z5u7AOzitNVTHjElifgX6d/D+pFkXS5dWxYUeYT7AA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9zxKMTvX0b8A/4ZVTHzDzbGbHP86KnIHQCF5pYs+z+o=; b=b2+igpho5m11PDveqOmAQ2HxEK
 kdRkwEDhFx5cmD+q0GoOOOaTDou3Oj14FqVp03K7E+5DMh1fz1Gn1ZR5h+VTkcjYSq7N+kQz1fDB8
 O1fzrDP7SSo2kcO7nCXSwBzV7UKjtcDtcAl05higHslFL/UCnDYCBpC787TuQB9TWDEc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZFt-000000004DM-3DIs
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:59:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6616743204
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467C11F000C0;
 Mon, 23 Nov 2026 18:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460344;
 bh=9zxKMTvX0b8A/4ZVTHzDzbGbHP86KnIHQCF5pYs+z+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iCIU4yYG6SZr5RD7dnTGzlhBxWYA/lH+jAmMxQIJzVcOfOXFEA6YLbKdpxu+PjRD/
 GviSSUmpBnwnZhPYS3rLBGmR+O32axGImc3wew0X/lumpaJTop/0t7v9cZeOWGF213
 0/mgLIVkEHMiO4a5NRgv4RFVvA5lHX05tpFPWcCXpS5mDBCKBr5wFkbP38IfFV1Rhn
 oyG0pDzmlriMEPEH70SAdOrSDlGz6YvfSLWNYf8EwXO4lEILrlYs1/P6CkCn+u8esd
 KSiyNmJqtT6RNYRVKatWRLiyO8ZTahGVcGGRlJy7wFQ2g86cKgeS/wh8qbQrWegYST
 THtD++irdznrQ==
Date: Tue, 24 Nov 2026 02:58:56 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSM2FyEuUTBwZPH@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <8aebfe6024e971c967497284c702862f16cbe570.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8aebfe6024e971c967497284c702862f16cbe570.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZFt-000000004DM-3DIs
Subject: Re: [f2fs-dev] [PATCH 17/21] fstests: add _change_metadata_uuid
 helper
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 06, 2026 at 04:55:43PM +0800, Anand Jain wrote:
> _change_metadata_uuid changes the UUID of the golden filesystem before it
> is cloned.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index bc0522dbcdd3..7feeec04a500 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1577,6 +1577,23 @@ _scratch_resvblks()
>  	esac
>  }
>  
> +# Change the metadata UUID of the given device to a newly generated one.
> +# Args:
> +#   $1: Block device path to modify.
> +_change_metadata_uuid()
> +{
> +	local dev=$1
> +
> +	case $FSTYP in
> +	xfs)
> +		$XFS_ADMIN_PROG -U generate $dev >> $seqres.full
> +		;;
> +	btrfs)
> +		$BTRFS_TUNE_PROG -m $dev
> +		;;
> +	esac
> +}
> +
>  # Create a small loop image, run an optional tuning function ($2) on it,
>  # clone it, and attach both to loop devices, returned in ($1).
>  # Args:
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
