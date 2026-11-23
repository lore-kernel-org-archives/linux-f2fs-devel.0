Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F5606A6AD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hVAMybpK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NW/2N0Rh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bLTukqUP;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hpgz6uT0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9F7wEe58qSD40XAk0w7dvpbIcYiT36leue6dBGW28TI=; b=hVAMybpKQICQAjpLkoXYhaS73l
	O+vsgSsqksADEkipSdQ8kqa/0xT5iTrFgiKrB21Fx714OOgp07yANUvUT8cNRM099PgtxUL799FuX
	wBTygiuzXcN0Z697DArnjr1dlEzZEPLxeAlfpTGTqm6W+/mJo6PP2yxr0bItE8LZMMUk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVYdE-000000001XV-30AP;
	Mon, 23 Nov 2026 18:19:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVYdD-000000001XO-2VgI
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:19:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u6X2E0XUgIO+iKoQD/SNiDFffgouosxGaFf5DehOZNA=; b=NW/2N0RhfmM6N0gQcdnOSTbG5Z
 VA3UHhNa4Kcv1w4b4jnCqROx1gPD2vh9u/JJ9ain2lvqaicrxEh+xlStrh/ADVuPuaVAjKHixU0Ot
 sCPYgfONDBEO8/nQ2EV5LpTQgSmSC0NPliQhn3sHeb0+hd/NWq1ZjkQY+gGjaA2kwSOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u6X2E0XUgIO+iKoQD/SNiDFffgouosxGaFf5DehOZNA=; b=bLTukqUP3PwiLllexXil7Rpsvo
 z2jZsdiCwr0yzYaEoCF9te/AwvuEsdlEGiQ6yIe3By6kz2MT4uDitGa1bVYbvTAw9dIUu3fsm9hCR
 lJPd750lgNLAL0TMLuoGnvPlcQoazL1PYSmj3vIe5AOyDTdyxhyt9oDhs+Yyi440+js4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVYdC-000000002yV-05hY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:19:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D335623AE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920321F000C4;
 Mon, 23 Nov 2026 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795457944;
 bh=u6X2E0XUgIO+iKoQD/SNiDFffgouosxGaFf5DehOZNA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Hpgz6uT051pI6IVUFBVPt8R6H8+PpzR3cnm0zJA+v6SfGXeqaZX07vaJ5GdRfxOO0
 BkxyCMegj0h+sItLamcfEhVOtQOFYBgtkhNEoL8HQiG/g9JrjbsAQMfizgSj/gdrFB
 xXGE9/AkzkLYJrtiGZb792MoBGuZM6uG9Vu8ztK7CZ/fG+qRJuvfFUxp1wWI4yR6VR
 amgNmgoPblLRxAhSZu6IciIAXVQjIx9MCHZFXfVFHXeUKll2kcwyfZnG1Gm/NwY3G6
 hpmeJyuuqfP8zVqSOgN0UBb5f9XuaOXM21e+Fij4SQHoHQbWwaDaBky1mvpdHrvBUF
 qKAf1PdrqRYPw==
Date: Tue, 24 Nov 2026 02:18:53 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awR6WGcokCWeZVal@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <16d1b43e27ee01742eb6a431d99a738c0696a94f.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16d1b43e27ee01742eb6a431d99a738c0696a94f.1791272793.git.asj@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVYdC-000000002yV-05hY
Subject: Re: [f2fs-dev] [PATCH 05/21] fstests: add _require_fanotify_function
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

On Tue, Oct 06, 2026 at 04:55:31PM +0800, Anand Jain wrote:
> fanotify support may not be compiled into the kernel. Add
> _require_fanotify_function to skip tests when fanotify is disabled.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/rc | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index b9481ba8ab55..0fcc1a614ad1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6384,6 +6384,13 @@ _require_max_file_range_blocks()
>  	esac
>  }
>  
> +_require_fanotify_function()

I'm not sure if fanotify_function here refers to any specific function.
The name makes it sound a bit like "a function named _require_fanotify".
Could we simply name it _require_fanotify, or perhaps _require_fanotify_enabled?

> +{
> +        if $FSNOTIFYWAIT_PROG 2>&1 | grep -q "Function not implemented"; then

What if there's not fsnotifywait command? Maybe we should call
  _require_command "$FSNOTIFYWAIT_PROG" fsnotifywait
at first? Alternatively, you could check this in src/feature.c by calling
fanotify_init() directly (so we don't have to rely on fsnotifywait).

> +                _notrun "Need CONFIG_FANOTIFY and CONFIG_FANOTIFY_ACCESS_PERMISSIONS to be enabled"
> +        fi

This function uses 8 spaces for indentation. Please use tabs instead.

Thanks,
Zorro

> +}
> +
>  _require_fanotify_ioerrors()
>  {
>  	local x
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
