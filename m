Return-Path: <SRS0=oeUr=63=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD8EC2D0F6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2020 03:12:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E8E2312B;
	Wed, 13 May 2020 03:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Z3hneEJ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JmhHQEDc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQuMRTuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E8E2312B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jYhod-000838-4P; Wed, 13 May 2020 03:12:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jYhoc-000832-K8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 May 2020 03:12:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zjIU8vivjR0o6BrNnofzCMETUPEO8UdvkS+WqiD39fc=; b=Z3hneEJ7DdlZ1v+tl2Cx7iWEty
 bEQ0IAOZRIjAxN3OoO0bOF+xWK4+/GQRLeI3DcbuCGMkVUW9dW0BG/a5yiKzSAp0RdbAJ644uRlah
 dOqbUaGVN6DaoC+QlqFzIzWe6cbYMBr1azBSkrpjtWlR1zfhPD8u4NXhxDtFGWCNYBvY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zjIU8vivjR0o6BrNnofzCMETUPEO8UdvkS+WqiD39fc=; b=JmhHQEDcU3AYhAJI2VVbqIV5Tk
 cF5sKVq67FVY+fA3AhW/vTTSZO3fkcG9V2lEOMIf5mLgSIxS2nZuFATeZnIKyuc8gPyhJ3E5sjY/Y
 MdlOEwhsIRt7rhdKhxwKB9XVRV094krMEcZW1unvW+X6SryGlgne35ZA7AqeS/LMFr4c=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jYhob-00CKKW-JR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 May 2020 03:12:14 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 27B3A2312B;
 Wed, 13 May 2020 03:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589339528;
 bh=sIfDqqShqDcXIL5Ts6hJw6nw2IZoaZwk5xhWhieDeDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pQuMRTuCpOdmOb1siziEWXmktvJf14z2QfinwY1YMPsx/x2KSJ5YAJyoqW/Vylqv3
 QOeSo31io+pU6juoQkpg4ia1yXZhR2H6f71IGmz6R7tK+wIo11mQ3lOSAznUdM2MEE
 LhId6mJ5Ceh6DYwTdS7ZVD4VjHQ7Fw+nrnNfLE1A=
Date: Tue, 12 May 2020 20:12:07 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200513031207.GD108075@google.com>
References: <20200512233251.118314-1-ebiggers@kernel.org>
 <20200512233251.118314-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200512233251.118314-5-ebiggers@kernel.org>
X-Headers-End: 1jYhob-00CKKW-JR
Subject: Re: [f2fs-dev] [PATCH 4/4] fscrypt: make test_dummy_encryption use
 v2 by default
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
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 "Theodore Y . Ts'o" <tytso@mit.edu>, Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/12, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since v1 encryption policies are deprecated, make test_dummy_encryption
> test v2 policies by default.
> 
> Note that this causes ext4/023 and ext4/028 to start failing due to
> known bugs in those tests (see previous commit).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  fs/crypto/policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> index ca0ee337c9627f..cb7fd8f7f0eca1 100644
> --- a/fs/crypto/policy.c
> +++ b/fs/crypto/policy.c
> @@ -632,7 +632,7 @@ int fscrypt_set_test_dummy_encryption(struct super_block *sb,
>  				      const substring_t *arg,
>  				      struct fscrypt_dummy_context *dummy_ctx)
>  {
> -	const char *argstr = "v1";
> +	const char *argstr = "v2";
>  	const char *argstr_to_free = NULL;
>  	struct fscrypt_key_specifier key_spec = { 0 };
>  	int version;
> -- 
> 2.26.2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
