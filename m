Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ADDC53200
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K3cYyS9/lHMtkTHVTRGQ3/IqqQV2Iy0DHnsQPA4OYa4=; b=nDE+dbdcCgmsUH8a5v66ID9J4D
	IAWyXi1gPhTO3sFC+prvdaPLvzpRh7OukjtaKICmEgstuOpm6UGlHMqeDjSgEkUEIa1m1SIMwkr2R
	dEz+RM/UmH20HTJbHtmQyX1pLuKiA3Q4dywrc1TPlNdH9r175fQsDSKeEOqNUih3UdBI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wp6VF-0006nt-Ab;
	Wed, 29 Jul 2026 15:47:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wp6VE-0006nn-Nf
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:47:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DB5SQYU+LDdWOKafWbpcL7FJRQ0W5HkGsqlY7Lrf3tE=; b=AdgNnXuJ/wWg1I0C2eDhfrCCH0
 yTL8iXQLBcI8+cvaTxxRCo9bpN1ECyb/3SQXs5b/AeWCpFMa/SuyxCdszSAJmz5F21A+pOnsqCuoO
 Ag8RMCPGpnZaEn0y3hgm+++ZvMxUSsjRbaUPmc6qgfTHYtkutpVFGF6u51RnGTuEyfNs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DB5SQYU+LDdWOKafWbpcL7FJRQ0W5HkGsqlY7Lrf3tE=; b=PU7/EH6Kz8f/xqjLDpyO3sceQK
 Ff07TyiI2FK6cYyFcfdpSYCHncYmj5Kq5vx6L2OgZsRClKj6mpJR5J3AwqjjjkUqvE+fWlyrbEA5K
 88HxmdUK2nTKlBV/5UuMtKTgxik1nFOweEYxTFhzBhmbFDvLOoJl6k72EkNcd9wMlZXY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6VG-0001bG-EK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:47:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 785D843CE8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 15:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4CB811F00A3A;
 Wed, 29 Jul 2026 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785340041;
 bh=DB5SQYU+LDdWOKafWbpcL7FJRQ0W5HkGsqlY7Lrf3tE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XMEom+X5Q8A5NO/vhvv34dsBRHbRZSRWZipGFkvi2UqgJAjIU0Q/akt/BCNByH/w8
 JTSfisOg2PLq5tElGSF3aEliQF4e7ImsGw7Fpa75wy5Xi+U6tzY/ejvBr1/MpE15l7
 VYl2QFgo8qmM9jvsVeZ7XAwtPtZiZzj7vAZtY//8bYqUPEfO1YpnskwtsfOiU+lwGW
 aPuuxMlDWmUN1qz9DaSM9m6Fyt1p745Mv0IOueDOrXIAP4tQLPZCcMnBRWANOqnW6U
 Rz1GbzMPJOwlqlXInojQOUsvXaZ95VaheM2vyquq5S/153LRqV8Rn32oJ4CzxsaXgG
 w8B+QgMMTlZPQ==
Date: Wed, 29 Jul 2026 08:47:21 -0700
To: Chao Yu <chao@kernel.org>
Message-ID: <20260729154721.GD7371@frogsfrogsfrogs>
References: <20260729094909.1499590-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260729094909.1499590-1-chao@kernel.org>
X-Headers-End: 1wp6VG-0001bG-EK
Subject: Re: [f2fs-dev] [PATCH v3] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 29, 2026 at 09:49:09AM +0000, Chao Yu wrote:
> f2fs has supported to report fserror, this patch adds support for f2fs
> in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
> 
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> v3:
> - fix to chech sysfs node correctly
>  common/rc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 106f044ad..3a8f03412 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6266,6 +6266,12 @@ _require_fanotify_ioerrors()
>  		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
>  		test -n "$x" && return 0
>  		;;
> +	f2fs)
> +		local feat_file="/sys/fs/f2fs/features/fserror"
> +		if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
> +			return 0
> +		fi
> +		;;
>  	esac
>  
>  	_notrun "$FSTYP does not support fanotify ioerrors"
> -- 
> 2.49.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
