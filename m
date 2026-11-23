Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3666606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gctZKX3w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DKN0LW8r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NgVE5GiS;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtX6KOvh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QiYvUsOfvo4AVL4Yf7Abej0mx5M0LOVqVkkvI3Pul7Q=; b=gctZKX3w81n/jMWAq1qLIGhST9
	Nm1QpYW5x1Jhk1uXFVCE2CEkF2O/g6KlTCEU3Ufc6eho8vuw5sDsNQaLeqWSrcEFGbU6Sdas5xNO5
	wH/zn1vFMd2kHIBtbOaEbQL1arPudeFW9c2NxAX1maSCSelS1hlakUnZnskQUvAoPrmE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVXzf-000000000UV-1Cco;
	Mon, 23 Nov 2026 17:38:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVXzd-000000000UN-31hj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:38:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=94ekcRJsUgWpy81sPHWeKTgB95XqS37ea/xGDrOA6kI=; b=DKN0LW8rjs2ZcAKF/AgpQQP44c
 0LBXDvs4ZebubwijJ8Gdo7uNc9eTC65P8cC9x2dNdab53ttI7+pRbJoKdehf9b4qWrVfvS5jhJA8l
 s5OttVki69kD4+IIMgqEVhsw8KfMsxIB6jHkZ0N9HasoNw2kDxeK+5P9DNsXJHBuTC50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=94ekcRJsUgWpy81sPHWeKTgB95XqS37ea/xGDrOA6kI=; b=NgVE5GiSE6C94LOOio6qyKOHPY
 Z7bpJqN5zi7TXUs13pbybtUIG6I7YSvQXb2KSFjhzlViW97uh6pnKQdiYnDltG0ZnW09NUQfPlWtI
 3jlvpe/lBPYaMHIMmyFbqpFmL9ZVmcRsXcsW3igiIr6rA9fSizNXAV7jkIDnuQHTfU1g=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVXzc-00000000217-1QcQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:38:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB35D43DD8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 17:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E0B1F000F0;
 Mon, 23 Nov 2026 17:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795455490;
 bh=94ekcRJsUgWpy81sPHWeKTgB95XqS37ea/xGDrOA6kI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WtX6KOvh8tad3FIjQbAWuqVJCzjsepOvwwK9FNzDvVkwme9waafd2NDNQk7pASgj2
 da7i7XEha4TLvCyymLfEbIENrh6ZsgAJZc1wwcuMMjkcEvImxrteol2niRVQyQtxki
 dWfqhPUA5R8t0CJWn+bu/0j0+aZknjziJlP8kGycjC64Tojh8hubahlSCyrhzZyMOC
 /VreT1Rj97LeqKSUDcjAjXm1sLbsAQDHVHjCVU4BwoJLKPpQ32rM0g+mnLtweYLUJp
 VUWzdXjbQsp16yQILv1OrKc3rsn0StMeg/pUihKLi7Pu4Cx3Eh6Davyhsfs6Q1BhaN
 5CvXPfSOliqMg==
Date: Tue, 24 Nov 2026 01:38:00 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awR56zlPFGBFLnyw@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <ff8994fe7511fb1ed3b08bf7830c53168c813713.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff8994fe7511fb1ed3b08bf7830c53168c813713.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVXzc-00000000217-1QcQ
Subject: Re: [f2fs-dev] [PATCH 03/21] fstests: add _clone_mount_options()
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

On Tue, Oct 06, 2026 at 04:55:29PM +0800, Anand Jain wrote:
> Adds _clone_mount_options() helper function to handle filesystem-specific
> requirements for mounting cloned devices. Abstract the need for -o nouuid
> on XFS.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index f2ab4bc491af..b9481ba8ab55 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -428,6 +428,19 @@ _scratch_mount_options()
>  					$SCRATCH_DEV $SCRATCH_MNT
>  }
>  
> +# Return filesystem-specific mount options required for mounting clone/snapshot
> +# devices.
> +_clone_mount_options()
> +{
> +	case "$FSTYP" in
> +	xfs)
> +		# Allow mounting a duplicate filesystem on the same host
> +		echo "-o nouuid"
> +		;;
> +	*)
> +	esac
> +}
> +
>  _supports_filetype()
>  {
>  	local dir=$1
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
