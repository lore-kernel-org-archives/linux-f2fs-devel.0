Return-Path: <SRS0=n2Zs=K5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61968C47096
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Jun 2021 18:26:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2546C613B8
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Jun 2021 18:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2546C613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1los38-0007Ay-Jf; Thu, 03 Jun 2021 18:26:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1los37-0007Ar-ET
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jun 2021 18:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6+p5Cr76mfTmRql5UauSDpmNslTuaShaP1LNxBW6Vss=; b=FdVQXqlAIwmuLrb68Sn9ENeWym
 wLRjr7CFrYoeK9MmyvsgMSp0BG99ZBkAA+18RIdiCXtgKo6HagmwAwWFU5h3tOgp1F6bnPOuvVOx/
 vAEQiWGt94LRfSVE18HD14CDyfRsiG32Q6+mAZwQaZGqgY9SGvHX9ENEUgTJLdyA+0Bo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6+p5Cr76mfTmRql5UauSDpmNslTuaShaP1LNxBW6Vss=; b=Q8PQxgfXsru182VcAeUBzOIF6g
 vgvb9AtHnyWUn7+tzOP1/uD6hDBSSMqkz8ZoRA2Xko81eYtgx3K264zmRGQ/zX7i2TQMUe6fix36X
 ooXLCjZh941pkJRSL458z58M0/VUVWfkOmMjI0cAtD2DYb7sEOwGK36vBFK8nw6hUz/E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1los38-009HxT-PQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jun 2021 18:26:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FFF4613B8;
 Thu,  3 Jun 2021 18:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622744784;
 bh=KS86fETWmO2r8Ciw4jfg1Y3IIHZrd2X3PoK1uPLexhk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AdffuVn5maDp6qAdluN5DK6pj9KzZtIaIYSdpleY1s6xLX+PpN2v+HjUqgS8OgfIn
 /+dwcdf7hF62TFGeow+zYe5D+adGRaYLmiIQmZADTZsmoGiZteHpfg24TZats8yVQ/
 oeN4ul5ClnbOW4ZLXmzjo3JeCT9g1105lRjTBXz/dMXN5Wkfe5FANtk7+HfXvKvryp
 6zYYr2zH0WmD03A/pDyqQQN6K8emJRMgisXm8hhsIKrnUkVd/7xY4Uon/HzxLHkPjo
 oCsLA7B1LbtWM5zhiAwOvByGaQn90Ren6UwejPXX3fMV/modlI4yoLm5HhK7Mxwyuu
 S8HA2wXDfbUUw==
Date: Thu, 3 Jun 2021 11:26:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Rosenberg <drosen@google.com>
Message-ID: <YLkezhSmr+aC0v9p@sol.localdomain>
References: <20210603095038.314949-1-drosen@google.com>
 <20210603095038.314949-3-drosen@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210603095038.314949-3-drosen@google.com>
X-Headers-End: 1los38-009HxT-PQ
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: Advertise encrypted casefolding
 in sysfs
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 03, 2021 at 09:50:38AM +0000, Daniel Rosenberg wrote:
> Older kernels don't support encryption with casefolding. This adds
> the sysfs entry encrypted_casefold to show support for those combined
> features. Support for this feature was originally added by
> commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> 
> Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> Cc: stable@vger.kernel.org # v5.11+
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/f2fs/sysfs.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 09e3f258eb52..6604291a3cdf 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -161,6 +161,9 @@ static ssize_t features_show(struct f2fs_attr *a,
>  	if (f2fs_sb_has_compression(sbi))
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
>  				len ? ", " : "", "compression");
> +	if (f2fs_sb_has_casefold(sbi) && f2fs_sb_has_encrypt(sbi))
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> +				len ? ", " : "", "encrypted_casefold");
>  	len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
>  				len ? ", " : "", "pin_file");
>  	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> @@ -579,6 +582,7 @@ enum feat_id {
>  	FEAT_CASEFOLD,
>  	FEAT_COMPRESSION,
>  	FEAT_TEST_DUMMY_ENCRYPTION_V2,
> +	FEAT_ENCRYPTED_CASEFOLD,
>  };
>  
>  static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> @@ -600,6 +604,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>  	case FEAT_CASEFOLD:
>  	case FEAT_COMPRESSION:
>  	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
> +	case FEAT_ENCRYPTED_CASEFOLD:
>  		return sprintf(buf, "supported\n");
>  	}
>  	return 0;
> @@ -704,7 +709,10 @@ F2FS_GENERAL_RO_ATTR(avg_vblocks);
>  #ifdef CONFIG_FS_ENCRYPTION
>  F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
>  F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2, FEAT_TEST_DUMMY_ENCRYPTION_V2);
> -#endif
> +#ifdef CONFIG_UNICODE
> +F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
> +#endif /* CONFIG_UNICODE */
> +#endif /* CONFIG_FS_ENCRYPTION */

I had only asked for the #endif comment for CONFIG_FS_ENCRYPTION, since that is
a longer block.  #endif comments aren't helpful for single-line blocks.
See Documentation/process/coding-style.rst:

	At the end of any non-trivial #if or #ifdef block (more than a few lines),
	place a comment after the #endif on the same line, noting the conditional
	expression used.

Anyway, doesn't matter much...

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
