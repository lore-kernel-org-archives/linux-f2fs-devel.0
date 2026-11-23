Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736E606A69D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VyI9GNJt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U4fL6ZEA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gEZL6x+F;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+BmqYS4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fi3DTt1ZNQ4j9qEFCvFQDoerXlOwFd3lk4JK2HDJs7s=; b=VyI9GNJt6u+Trof6u2UxI4oCwI
	LP+GRr8XRm/tzcE5gq9Na4iE9KwBTv0+GUIYNRPXPH4K8HodLo7CZ731Uza81V4i8qnfwNvD7de0F
	j5qWwblYvW3P/EvlvC8kdzo4kk7COSEqVLFlKPlz7QEbCmKdzyZzrFm6cJ7nElaQGY8k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZ1t-000000005fr-4AUv;
	Mon, 23 Nov 2026 18:44:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZ1a-000000005fX-0723
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:44:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZJOq2+pIeNoBqrSrs+l3wNJ7Cp9nPDVKZV/aaKB+99E=; b=U4fL6ZEAJ9Z57f3bWXKCAfruTq
 aJv3u5KaiqPToD7a8m3xC2ZgJLOaw4hjnI9mbAPMWc6VoYrBQDwssrWTNvR0Ds4qmDcT9IRrvtoer
 TjZSWCWV7ApB5GRhBAeTxaMUqfJl0ATL92/k7te4tv9k48z6jjftTCw1fuGY2lxFhxwQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZJOq2+pIeNoBqrSrs+l3wNJ7Cp9nPDVKZV/aaKB+99E=; b=gEZL6x+FxR/P0Y5asByYKKIDyj
 CKDrwLeq8tGps+ZLxh21NyfppSH2F3Uf9RTLDFpmHaE0IGE7w1R86cZ8ezMF3L5gCDxL+YxttRu3i
 2V1aBO7WcJp1JqqzFR8Rs0EVtb0NPiEMi4itXSUUS94y1oRizddyzIdt0nrgswVmShiE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZ1Y-000000003qO-2eGF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:44:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 002BD62447
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B021F000EF;
 Mon, 23 Nov 2026 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795459454;
 bh=ZJOq2+pIeNoBqrSrs+l3wNJ7Cp9nPDVKZV/aaKB+99E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=g+BmqYS4PwR/qb8oDBvH6gzcwOR7BTs4cG6X2DMM79KLuHRqFWAl22guLJruOE+my
 EuD71jAn1TjU7URQthRPZeiDRX+W48Sv61t82pz0duVIBw7jSU5PxqIum5jSDYmG7r
 Ct33E3nO8g/CUYNMWfZdyuYX9Gzo4MWPQ1Bu5FMJtPpCqxTTd1VpGjfBRGR7n1nFes
 s+CmnZaFwXszUxs5odVeEFMWuppKPhoU9sKzia61QI+slLqPUIH+1mjllPTDIHewRB
 cW4i0QN/NgBU/RBwYz4Wb7CQC+WEpQb4yR7VAtuii4HUAPY1c6Zec+Bxc2HhYnfzis
 5Lt1BqHYMCeAQ==
Date: Tue, 24 Nov 2026 02:44:06 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSI5d1ytDLC4nmx@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <5a816f5c76ae3e0761524d53998afd9d0d74f58f.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a816f5c76ae3e0761524d53998afd9d0d74f58f.1791272793.git.asj@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVZ1Y-000000003qO-2eGF
Subject: Re: [f2fs-dev] [PATCH 09/21] fstests: introduce helper
 _scratch_mkfs_uuid()
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

On Tue, Oct 06, 2026 at 04:55:35PM +0800, Anand Jain wrote:
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 37b32b498c80..37df780f64ef 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1449,6 +1449,36 @@ _scratch_mkfs_sized()
>  	_try_scratch_mkfs_sized "$@" || _notrun "_scratch_mkfs_sized failed with ($*)"
>  }
>  
> +# mkfs filesystem with a known uuid
> +# Input argument : none
> +_scratch_mkfs_uuid()
> +{
> +	case $FSTYP in
> +	f2fs|ext4)
> +		if echo "$MKFS_OPTIONS" | grep -E -q "-U"; then
> +			_notrun "Config contains mkfs uuid option"
> +		fi
> +		MKFS_OPTIONS+=" -U 12345678-1234-1234-1234-123456789abc"
> +		;;
> +	xfs)
> +		if echo "$MKFS_OPTIONS" | grep -E -q "uuid"; then
> +			_notrun "Config contains mkfs uuid option"
> +		fi
> +		MKFS_OPTIONS+=" -m uuid=12345678-1234-1234-1234-123456789abc"
> +		;;
> +	btrfs)
> +		if echo "$MKFS_OPTIONS" | grep -E -q "uuid|-U"; then
> +			_notrun "Config contains mkfs uuid option"
> +		fi
> +		MKFS_OPTIONS+=" --uuid 12345678-1234-1234-1234-123456789abc"
> +		;;
> +	*)
> +		_notrun "can't mkfs $FSTYP with uuid"
> +		;;
> +	esac
> +	_scratch_mkfs
> +}
> +
>  # Emulate an N-data-disk stripe w/ various stripe units
>  # _scratch_mkfs_geom <sunit bytes> <swidth multiplier> [optional blocksize]
>  _scratch_mkfs_geom()
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
