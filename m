Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53650C83F26
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Jul 2025 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7LL0XxtTwDSZVT/mwjuacPhmQuc69jlSk5KEE0mHrOc=; b=HeumNG44wZaGQeL71NHDJch3FH
	w4YOlaf5LOIyNwtoxoe/Bu5V5wvbNI8cK927dmimrtrqpYsDqGJ9bzNkkZd5KTSYbBRmRjowheDap
	MufXWAWDU63QWPFR7RaWPAL8H2wOdIDuVliD7LL2HHUU2aadUgKmYqsANkInjj8AvFcI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uexWy-0002au-Ov;
	Thu, 24 Jul 2025 15:06:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1uexWs-0002aG-5g
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Jul 2025 15:06:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TZyIZMC6TDCVnI+deu0v0D/shvwaUnl0rlHPaEEyp0A=; b=cdcPOEtcdWc0d469OC4b+hrSjV
 Yv3cdylUsBH5sJDzeWYfJalehpV+QSkduaNousjCbC7zyJfuiXAuoU+3U85Th0SGWZ+MI1mf9kdpq
 f80UyEK1uCDBpXTKr/LCiFOpKNsHmNx2Xycmbv7bv5KZlV8Q2a/HpPiVRTuKoXIgsf3I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TZyIZMC6TDCVnI+deu0v0D/shvwaUnl0rlHPaEEyp0A=; b=FPoMnIHkwnmXpkmPzld5sXCQwu
 9WyavasJnb/XW19JfYAijJU1j1FbSZTsfiXe8SCT4wHJMeGg/VDU8i931j3HE4jjNy4FDqBBdT7oG
 z+9Cx3cCzL4zI9fI2lPb72/3JtuGwvo+QaWQhgYLIeYKeEydikfGF7ESqoisoD3uIXDA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uexWs-00015P-Hm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Jul 2025 15:06:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D3B28601D5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Jul 2025 15:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F451C4CEED;
 Thu, 24 Jul 2025 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753369596;
 bh=uuDSfQ7zreYpcfpqV7kad0URfknQswzuBK23rYePnPM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=csYxAMpTXLdB4RTB0lE0GE8gc3/nJK5hl7s4LGGJybyokx3kpDd7F+MavC7iMcVYY
 WSfK527hPiTltmfJPbvP+13gIengD9BUufxrfyfKTTwE31dPpeKUIjOLPHbc1D1yP5
 zkgbRsxHJDTXEDpntBSYYMpY0tYhV3XNtFT6Vtx7nCXbk9F1HTFpgZs7MCp+1+03xZ
 F1vnOs7d/hHqV7uVoaY4mBWOSy78JX9udfS1bkqahpI7kcNO38TRJBa9PFbALpj7KI
 00EOpokE7aZZeeFb+h3e5bxLj7iVIoYi4tRF9oHJKPkghthfE3UBkziL4PNXZXM0VC
 h0xDXcrrBfCzg==
Date: Thu, 24 Jul 2025 15:06:34 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <aIJL-sNFvNlcg3nT@google.com>
References: <20250724035654.3578627-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250724035654.3578627-1-chao@kernel.org>
X-Headers-End: 1uexWs-00015P-Hm
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: support -C [no]hashonly to
 control linear lookup fallback
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Can we disable linear lookup by default, but add an option to enable it?

On 07/24, Chao Yu wrote:
> It provides a way to disable linear lookup fallback during mkfs.
> 
> Usage:
> 
> 1. Disable linear lookup:
> mkfs.f2fs -f -O casefold -C utf8:hashonly /dev/vdb
> dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
> s_encoding_flags                        [0x       2 : 2]
> 
> 2. Enable linear lookup:
> mkfs.f2fs -f -O casefold -C utf8:nohashonly /dev/vdb
> dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
> s_encoding_flags                        [0x       0 : 0]
> 
> mkfs.f2fs -f -O casefold -C utf8 /dev/vdb
> dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
> s_encoding_flags                        [0x       0 : 0]
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  lib/libf2fs.c   | 1 +
>  man/mkfs.f2fs.8 | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 2f012c8..0e3e62a 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -1424,6 +1424,7 @@ static const struct enc_flags {
>  	char *param;
>  } encoding_flags[] = {
>  	{ F2FS_ENC_STRICT_MODE_FL, "strict" },
> +	{ F2FS_ENC_NO_COMPAT_FALLBACK_FL, "hashonly"}
>  };
>  
>  /* Return a positive number < 0xff indicating the encoding magic number
> diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
> index 8b3b0cc..b57f033 100644
> --- a/man/mkfs.f2fs.8
> +++ b/man/mkfs.f2fs.8
> @@ -232,10 +232,16 @@ Use UTF-8 for casefolding.
>  .I flags:
>  .RS 1.2i
>  .TP 1.2i
> -.B strict
> +.B [no]strict
>  This flag specifies that invalid strings should be rejected by the filesystem.
>  Default is disabled.
>  .RE
> +.RS 1.2i
> +.TP 1.2i
> +.B [no]hashonly
> +This flag specifies that there is no linear lookup fallback during lookup.
> +By default, linear lookup fallback is enabled.
> +.RE
>  .RE
>  .TP
>  .BI \-q
> -- 
> 2.49.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
