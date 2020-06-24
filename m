Return-Path: <SRS0=vASv=AF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A44FC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:13:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC43206E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Y9qAA707";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="gYDH+4QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC43206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jnxj2-0008Rw-Nz; Wed, 24 Jun 2020 05:13:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <krisman@collabora.com>) id 1jnxj1-0008Rl-FB
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jun 2020 05:13:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QBExvoWqNx9vJsU+C6RRi1K2Zz724x8K9+x1JEC/hB4=; b=Y9qAA707Lw5gAZUfgjhjf9QArd
 c8YsB3wq0r0kNV9AXfe8uz7W4+J6NQ3LXEs3ovCvwjUsfdJgrY0akG8ZFTmSJ8gQzUkW55gU5ZAgY
 MZZ9xbma5/YsAPDfDVmT8mLTGKatgzyuIa7lHt0JM6LYRQKqOY0okoYOFGbXD0xN1VxY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QBExvoWqNx9vJsU+C6RRi1K2Zz724x8K9+x1JEC/hB4=; b=gYDH+4QDHok3m5MOMnu63SdKki
 gEpa28ZKx1ZWo+YwxyJvSHzuysTIok8Msa1MEQqkcfLo+OTxy1edOtqwo7cmRryJHnVzu6tDiWuBf
 C4pwKI0Btwu/9qAxPF0JyNscWKdb6Vh4EcWiSXsSwO4VUtlaniWh8y0jB/PrMGNgs5v8=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jnxiz-00GhTn-D6
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jun 2020 05:13:31 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id B1D7D2A3349
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Daniel Rosenberg <drosen@google.com>
Organization: Collabora
References: <20200624043341.33364-1-drosen@google.com>
 <20200624043341.33364-2-drosen@google.com>
Date: Wed, 24 Jun 2020 01:13:17 -0400
In-Reply-To: <20200624043341.33364-2-drosen@google.com> (Daniel Rosenberg's
 message of "Tue, 23 Jun 2020 21:33:38 -0700")
Message-ID: <87h7v1gi6q.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1jnxiz-00GhTn-D6
Subject: Re: [f2fs-dev] [PATCH v9 1/4] unicode: Add utf8_casefold_hash
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
Cc: Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Daniel Rosenberg <drosen@google.com> writes:

> This adds a case insensitive hash function to allow taking the hash
> without needing to allocate a casefolded copy of the string.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/unicode/utf8-core.c  | 23 ++++++++++++++++++++++-
>  include/linux/unicode.h |  3 +++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
> index 2a878b739115d..90656b9980720 100644
> --- a/fs/unicode/utf8-core.c
> +++ b/fs/unicode/utf8-core.c
> @@ -6,6 +6,7 @@
>  #include <linux/parser.h>
>  #include <linux/errno.h>
>  #include <linux/unicode.h>
> +#include <linux/stringhash.h>
>  
>  #include "utf8n.h"
>  
> @@ -122,9 +123,29 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
>  	}
>  	return -EINVAL;
>  }
> -
>  EXPORT_SYMBOL(utf8_casefold);
>  
> +int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
> +		       struct qstr *str)
> +{
> +	const struct utf8data *data = utf8nfdicf(um->version);
> +	struct utf8cursor cur;
> +	int c;
> +	unsigned long hash = init_name_hash(salt);
> +
> +	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
> +		return -EINVAL;
> +
> +	while ((c = utf8byte(&cur))) {
> +		if (c < 0)
> +			return c;

Return -EINVAL here to match other unicode functions, since utf8byte
will return -1 on a binary blob, which doesn't make sense for this.

Other than that, looks good to me.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

> +		hash = partial_name_hash((unsigned char)c, hash);
> +	}
> +	str->hash = end_name_hash(hash);
> +	return 0;
> +}
> +EXPORT_SYMBOL(utf8_casefold_hash);
> +
>  int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
>  		   unsigned char *dest, size_t dlen)
>  {
> diff --git a/include/linux/unicode.h b/include/linux/unicode.h
> index 990aa97d80496..74484d44c7554 100644
> --- a/include/linux/unicode.h
> +++ b/include/linux/unicode.h
> @@ -27,6 +27,9 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
>  int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
>  		  unsigned char *dest, size_t dlen);
>  
> +int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
> +		       struct qstr *str);
> +
>  struct unicode_map *utf8_load(const char *version);
>  void utf8_unload(struct unicode_map *um);

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
