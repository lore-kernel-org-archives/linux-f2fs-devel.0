Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B78C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3oFJUi+gMmLnIpxxM13wXZTtRGzyOz8Co9qhdPl77hU=; b=GgJqNRz1EOlB8V3U+IhHoBdtWd
	GAmsoRZtHYLvXNahGx0HvTc1cOGmwedFkYU6SxiwK15TyIQU/fyzE8fXGAYqfYmWgjwNogIQw7fyt
	B2lLIXNyAfdDKqzR4YTu9BM+K5VoMoNPU423fmuo5qNimOniwtWVP/YR3fcENjbmciVA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1K85-0001b7-QX;
	Tue, 01 Sep 2026 08:46:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1K84-0001ax-2Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 08:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lFIS6lGqKCvC7eYLV0AotPkHS4uLqWAdlegsz5UR5sU=; b=eyArE7v5cpV+jAAGTUhM0qvULL
 DH2p0y9P6ZMDOXOPCLJXMxumYCqRqSgPTcCU9ktJZwukBWSSx24dPqJHHboOftH/jlasxpLOcrDZ9
 Tjs0xJ8htKinosCURhQrHF5GSO2CFqlIZqdjckelbRtoPjZlqALqBcX0LEnKrhMFvmn4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lFIS6lGqKCvC7eYLV0AotPkHS4uLqWAdlegsz5UR5sU=; b=J7CWsf0K1USkGBKciXMPrpRwqc
 p3DPh/SG25UroFHT1L1LyU8Pv3MtRhHCnGcZv3F9rmK4/X58OoJJA7WY1sGj9usjXGQZ3YpscHHwY
 0esCoEGg1tb3iUOXHgxGSSAGLTEqQ2DhZXcfUSE8w8+bA4tUZBrNQVNYZrNxWBcY79C8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1K84-0001Wy-B0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 08:46:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E82B34198A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 08:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2EF1F00A3D;
 Tue,  1 Sep 2026 08:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788252358;
 bh=lFIS6lGqKCvC7eYLV0AotPkHS4uLqWAdlegsz5UR5sU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IeXmwpOrurjG+/bNYLfPOYqrrQ4BJ4CwOfkd66+pT/Ia7hWgCVoMHUcR8KZkFSOZ1
 1uvBk5EHWBFeXEY4tTTacWPCSpJqvam8dgFRP1rsMiCzylsEczdaTe+r3jnh2schJH
 s3hZ3XCK9uX8cQUeOrRnt6AAyjIMaVw2q49lQVE0+DxTUpqjD4J/paBDl8QuZZb8op
 ho4CFld9flIxaqzNgMGUFXsY08hR2aMu5ByHMNIc0TjO5DqJEl4h6nHMYPkyboO7Bb
 FBpRxKwnp8AlahF88WvVc1j12s2zoAA5K2q4bpBaBuNnfBGm7ldhUxwLsLN+BiSrZW
 cqU7iiDglqoRQ==
Date: Tue, 1 Sep 2026 20:39:57 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apbGwZODzZIvOyi0@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <75ceae4b427ab53c921af395854794b78d7e07a9.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75ceae4b427ab53c921af395854794b78d7e07a9.1784949154.git.asj@kernel.org>
X-Headers-End: 1x1K84-0001Wy-B0
Subject: Re: [f2fs-dev] [PATCH v8 02/13] fstests: add _clone_mount_option()
 helper
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: djwong@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jul 25, 2026 at 03:38:59PM +0800, Anand Jain wrote:
> Adds _clone_mount_option() helper function to handle filesystem-specific
> requirements for mounting cloned devices. Abstract the need for -o nouuid
> on XFS.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/rc | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index e8ff5be0c547..53e5d9d43af6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -414,6 +414,19 @@ _scratch_mount_options()
>  					$SCRATCH_DEV $SCRATCH_MNT
>  }
>  
> +# Return filesystem-specific mount options required for mounting clone/snapshot
> +# devices.
> +_clone_mount_option()

Just a minor nitpick :) For consistency with other *_mount_options functions
(in common/rc), I suggest using "options" instead of "option" -- _clone_mount_options

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
