Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C6ECD6E49
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2026 04:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YxwCOWf5gOsVYRL3ClBni8deNJKUT0F/op2QB8U1GeQ=; b=ARfMFNPFypaR3c9lI6Hw8R16b2
	1nyelunvjBY6WicgMVjK+kR9aervw5DlaKHnIn+/0IqMeY+K4kF2A7znezr+l3rt8DqtPYomQsshv
	wgd/NnK1kY8gm+Wbo8UZMyCj+mIXss3lsPqX7uw59zyyUNckLWVGlPwESvVpGbN1mJ/k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSoqb-000807-Ns;
	Fri, 29 May 2026 04:29:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wSoqa-000800-MJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 May 2026 04:29:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sQlw2nJ084KxpFPHg1dQ82Zop2BRwpAcGQ67bXNtRjA=; b=KIvA7wvsaes6u6k54vmS83MNjZ
 cSPaVBL6gtvlMaNsBB4/5NWN6O5j0ZPc8DX7oH/Jsmr1ACm79FK4rsZ6zXHIeJNLeqVQuvdMA/eOU
 iXnY9LTFjAveBvBbeNrEhG6XhaoTBVey1f//ynBjn8dUvEGANw6OF+akYxiQDra9BT8U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sQlw2nJ084KxpFPHg1dQ82Zop2BRwpAcGQ67bXNtRjA=; b=JDCZybZ6TVjC1iBq0vuqexnFxO
 DaBNuiiSKTIR5xRAQIBetfGkHxnWIOZmKRp0IMzBRoT0OEtgPmSzWTQWeQA5L1XlT87YIkEHr5qe0
 iqVqi7Bj3ozC7yNe5gNgWkrb3DXRvyDasbWh978RwDgJZ5xlVpq0ZNkmAYm6faZTBE6I=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSoqZ-00081U-Ad for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 May 2026 04:29:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 3E8EE60213;
 Fri, 29 May 2026 04:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DAB0E1F00893;
 Fri, 29 May 2026 04:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780028953;
 bh=sQlw2nJ084KxpFPHg1dQ82Zop2BRwpAcGQ67bXNtRjA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Gl7gBDJ7AHzDDFDAQLxMPgwzbuOnDPbPj/KFIJbx8YgNZOIbid8uSIHwimlAtObDZ
 vahxsD7DqPSQmi/cjf6rZ/07TGe9kslh3V6p2Nelbqzqk/X6dWALVIEKMlZxhh0dQB
 V0Yt959lqbbjN0BYc56YzQsfVZCvzlsVnkOza3Vo3H1zztfvNInWlsorWwdJdlEZCH
 phJqma5eosqMj7kTgm2BRqC63yIR4Q2/zHXx3OHCWrvZfRVj25PRBumKy6m7ZY8y5C
 uK27N0FmJAqz8HzbPJOMGgpRxggoTWrcOIULwndGTRNYgAr1WdtVo3x6p58y/Qv1/L
 3oIG6TM5fn7sg==
Date: Thu, 28 May 2026 21:29:12 -0700
To: Anand Jain <asj@kernel.org>
Message-ID: <20260529042912.GD6070@frogsfrogsfrogs>
References: <cover.1779939330.git.asj@kernel.org>
 <f4dc9d5af00133834acf97e1c72232d2a9b34ac6.1779939330.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4dc9d5af00133834acf97e1c72232d2a9b34ac6.1779939330.git.asj@kernel.org>
X-Headers-End: 1wSoqZ-00081U-Ad
Subject: Re: [f2fs-dev] [PATCH v6 03/11] fstests: add FSNOTIFYWAIT_PROG
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
Cc: hch@infradead.org, zlang@redhat.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, May 28, 2026 at 12:05:34PM +0800, Anand Jain wrote:
> Define `FSNOTIFYWAIT_PROG` for an upcoming test case that uses `fsnotifywait`.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>

Seems fine to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/config b/common/config
> index d5299d5b926f..5661fa0ec310 100644
> --- a/common/config
> +++ b/common/config
> @@ -242,6 +242,7 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
>  export PARTED_PROG="$(type -P parted)"
>  export XFS_PROPERTY_PROG="$(type -P xfs_property)"
>  export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
> +export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"
>  
>  # udev wait functions.
>  #
> -- 
> 2.43.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
