Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A62606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HA3Hn4OY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fGPxvK/Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SFWgtmH/;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQbty4Fc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YPROaOBX4Cltl4fr4EemVemNJoJ2g2LVIOhDCHDT7is=; b=HA3Hn4OYKdNBswGkoR+ZkBhIZV
	NUJzywZhV+ynKjWvVPa4BzokAEmD4QTRvR45i+ILYtNhk/yX1PP1zppfwdlCJgE5CF64RnSAPCq73
	D3rCltKItIXEu9Y3Uzpg+aaF4HlvmRkGHY2kJvm9xmMbunIwq7I9iAad/tsc4n8DjDPE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZPq-000000002mZ-1OPW;
	Mon, 23 Nov 2026 19:09:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZPo-000000002ki-3oTn
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:09:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Bu/vCbyCmVQQLhIexXQF1Q1/I5m6K6flPXyY7ZW/a8=; b=fGPxvK/ZYtY0Ts7KQtEKmh7wWk
 fI9YQhQABD4JC1og3aX0AJ26uMCJ9oBKz2ABvT3i0c2u3inufDtSxshKI2u91mS0LBP/us19UKbv7
 q/YlrKDMsMKK+v8WGOXtVpNbDlvx3l34x9e/mkWCIewo/Uf5KBr/Dr8KL3jcl5EYityI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Bu/vCbyCmVQQLhIexXQF1Q1/I5m6K6flPXyY7ZW/a8=; b=SFWgtmH/3vyeHYPArpmKSVF9fI
 5QFawh2QTJCmIo5s6pL0WbcYCOGuZBwSSNELpiovLyiDGjCkTn5LR6nJkAAqFUx59f9E5J7n0v0qh
 j6Pk8dAmObU3QQPBQtMsGr9FBtZ1obYHlIH0M2dUrN4rMbNVQYQlRs19N7u5BplN6X7Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZPo-000000004U3-2LEX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:09:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 401B2413E1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 19:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9151F0093C;
 Mon, 23 Nov 2026 19:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460958;
 bh=3Bu/vCbyCmVQQLhIexXQF1Q1/I5m6K6flPXyY7ZW/a8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kQbty4FcXmazFpUPBT79tt5WNfGnPLDNtPl8gEc0+l5pfnw3qF4LkrG5s9bsngtUT
 vvMAhwxdZHvTQcnPdZ0UQLZL9fzua+NJsH/44ososrDEquZabHyb9p3D3LeQEq4PEm
 KGesIvYB4YLbi/hzT8z2wrgaFeXUsWC5PaMocxdCmvQL4ALvKHKkFC8ipyMzaY/k8a
 lrmTSFnyweASV8dnfoJ0oCP4p4byTw9HOBAbARP6odl6Xih8UhoJgA6mwkbFr/edB5
 2IfN2exGEObBn4AAGILz/YH6y1GPVG9utxnLUxd21nzOlzBJYfXl85HaSbugj8QQTB
 4sB9U7uMIlo/A==
Date: Tue, 24 Nov 2026 03:09:10 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSPT9iTEjkaJpD3@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <caf98f05a61c028dc1af75c11785cece28d400da.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <caf98f05a61c028dc1af75c11785cece28d400da.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZPo-000000004U3-2LEX
Subject: Re: [f2fs-dev] [PATCH 21/21] fstests:
 _create_loop_device_like_bdev() remove unused variable
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

On Tue, Oct 06, 2026 at 04:55:47PM +0800, Anand Jain wrote:
> Remove unused local dev.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 58e4c234b0f4..5bc4c52bb8d0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4815,7 +4815,6 @@ _create_loop_device_like_bdev()
>  {
>  	local file=$1
>  	local bdev=$2
> -	local dev
>  	local blksize
>  
>  	test -b "$bdev" || \
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
