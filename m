Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E931606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NCHUVBUt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NMdTjte1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YNa+kfjc;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=op+ZuC35
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yNONlim9NQoXtmdUvdadQ6kWehSW165nnoIzVDVPAhk=; b=NCHUVBUtn2A3cR/hHO6vyVR2wy
	nLt+rdJfxYKlIvLjO4jz2Bbnb+Mhlue2h8MlZBEpdFRl2Ykc5ggz92qBtNecqtCreRvLmp40B4+h4
	2L8erlRbywQ+2w1kP1rkxrYmI4lzvJamYXTgjgrMOU3vQqKjTXhBx+FShfKwDR2pTQlo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVXmp-000000003o4-15O0;
	Mon, 23 Nov 2026 17:25:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVXmn-000000003nd-3Xvo
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:25:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eoDSTZe53wuVRCyLceRxiACx+/d1rzfD6YrehQciITE=; b=NMdTjte12Z5aSItErLl5IBcsfr
 hwq52BQStKX/XYiCxUsedNlKZQlyIjuVlxBXEC4WDs7XP0gJvEtTsbcwqynrw+HzsmkMasTZgJ8e5
 sUFXsyC4rIgJiSC7lwjxXsEffw/HlmGJTNwxE53kVG4u0/ZyqNfZkVB2rXLsd9bmy0Yg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eoDSTZe53wuVRCyLceRxiACx+/d1rzfD6YrehQciITE=; b=YNa+kfjcgM988iKWVcFG4G+Gnz
 z4VkgVKk4au0VzCNnDhjL33gEKdHpITh6Co4oSbDzEEZIRfa5AcXTKpApehPShrHibxFSvDTWlyD5
 +9GPVYMG+rC4gbu2R2+mfvah/mFScgg0lMEjVFZdF/9bZG3/q7pi34LkLmh5LMuqcTz4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVXmj-000000001bo-3bKG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:25:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FE10434A6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 17:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449DD1F000D3;
 Mon, 23 Nov 2026 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454692;
 bh=eoDSTZe53wuVRCyLceRxiACx+/d1rzfD6YrehQciITE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=op+ZuC351+ONYtuuLlHO0lsJWkjaMKyvYPMJvVxtYg8e76pOzg2iG8XYXtKleSeZn
 oEb8ictwuRpPIszasEO8sIHZzqudHZJfqfYOBPdeHXxvOZXT999y59y+y6cxpD0YgM
 wlPIY+xr5Gtw0udgB2Y1Ci9fpB9Ke8B3nmvrM/SMogTEFNzuiW/muL63/bMF6ubxhT
 6X16uESC4UhaEQJxa4J+6VIRz0uNRyUyKjt3JgjYcrEFZ76aeU0nSZtcWxF6FJk0L6
 LtUlz6Qt27seYxm+FAguGf7J9J/4OX2dxsEk3kAayl8rE3zf4mSyREoZmrp5Ot/wbd
 51rqo7qwrvqfQ==
Date: Tue, 24 Nov 2026 01:24:43 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awR2y3ibb46JaqwM@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <245314b2efd616b7ecf09f74e2a775e44e10ab43.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <245314b2efd616b7ecf09f74e2a775e44e10ab43.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVXmj-000000001bo-3bKG
Subject: Re: [f2fs-dev] [PATCH 01/21] fstests: introduce
 _require_clone_mount() helper
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

On Tue, Oct 06, 2026 at 04:55:27PM +0800, Anand Jain wrote:
> Add _require_clone_mount() to common/rc to check whether the filesystem
> supports mounting cloned block devices simultaneously. For Btrfs, it
> verifies kernel support for the temp_fsid feature, while skipping
> unsupported filesystem types with _notrun.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 3958ac934980..7868e6d311a2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6124,6 +6124,21 @@ _force_inplace_writes()
>  	esac
>  }
>  
> +_require_clone_mount()
> +{
> +	case "$FSTYP" in
> +	xfs|ext4|f2fs)
> +		# No kernel-side restriction; always supported
> +		;;
> +	btrfs)
> +		_require_btrfs_fs_feature "temp_fsid"
> +		;;
> +	*)
> +		_notrun "$FSTYP does not support mounting cloned devices simultaneously"
> +		;;
> +	esac
> +}
> +
>  # Test that a filesystem can do writes to a file in place (without allocating
>  # new extents, without Copy-On-Write semantics).
>  _require_inplace_writes()
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
