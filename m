Return-Path: <SRS0=tUrj=AA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0535C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:41:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C90A207DD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jun 2020 05:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="luY3z9L5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Er6+7h6E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni3wWdzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C90A207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jm9m6-0003Fq-Ld; Fri, 19 Jun 2020 05:41:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jm9m4-0003Fh-PW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jun 2020 05:41:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dcqmlhp8ky43Lf21UDv0tsMusC5P5cOjQvIB/5emB34=; b=luY3z9L5TTD45Ja5mqrsYmNY/C
 P7EeKsmGB0pcb5Lk+3D4asaQEDVywjjclsI/OeCzkmuWwu7iw1mCWpvofi3/2CLUAt809BKHPNmXL
 VnherkBRgNpzc1Z8FhWEAOby+a7JTlp/D2tja7vN1JxPgUhdy5nmPxdUZh9uuAbWIIUY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dcqmlhp8ky43Lf21UDv0tsMusC5P5cOjQvIB/5emB34=; b=Er6+7h6EZthZMhtIH6Z5AE7N9w
 UkBXqOaOvNmOUxQTtRdGsElLzNkhMBbBl0arnP1gNGJ+C7ZhBp7asf5Wt/XP5nmMYGw6U1limKegm
 2UhtLZT1i+8yUKeEI/9LXBeqKJN9Uh4Ezl31n9yINdCFsyotAKI21y0LEsm0/7fGDOfU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jm9m2-009asJ-R0
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jun 2020 05:41:12 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1BEAC207DD;
 Fri, 19 Jun 2020 05:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592545257;
 bh=lPlQmiOW2RPnnTkoAb93HzGuPOoTC/zgIPoJh3IXerA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ni3wWdzj023rV/S8nF8sFDe079mgXtXseFwRXiipT8DfN+cYAcP7xjju7ClmFrxmp
 tUIcovvbURATTQRohoa4YiREfz9AScd7Mwuc/hOZVIjj8irnwSLbGcgdOhzLRcjYZD
 qNosvqD0YkjHYoWt06u8bHxTVx0aVAF1Zy1R/Iwo=
Date: Thu, 18 Jun 2020 22:40:56 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200619054056.GB227771@google.com>
References: <20200619032028.128668-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619032028.128668-1-yuchao0@huawei.com>
X-Headers-End: 1jm9m2-009asJ-R0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to document reserved special
 compression extension
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/19, Chao Yu wrote:
> There is one reserved special compression extension: '*', which
> could be set via 'compress_extension="*"' mount option to enable
> compression for all files.

Thank you for the patch. :)

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  Documentation/filesystems/f2fs.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 099d45ac8d8f..535021c46260 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -258,6 +258,8 @@ compress_extension=%s  Support adding specified extension, so that f2fs can enab
>                         on compression extension list and enable compression on
>                         these file by default rather than to enable it via ioctl.
>                         For other files, we can still enable compression via ioctl.
> +                       Note that, there is one reserved special extension '*', it
> +                       can be set to enable compression for all files.
>  ====================== ============================================================
>  
>  Debugfs Entries
> -- 
> 2.26.2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
