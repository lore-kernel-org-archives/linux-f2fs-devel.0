Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77DBC47DDB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 Jan 2024 00:29:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUyUF-0002Ri-Lu;
	Wed, 31 Jan 2024 00:29:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rUyUE-0002RU-9c
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 Jan 2024 00:29:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9iFBHJkp7up0ymjAoTr9pGik901atUgs+vltbP87kRA=; b=CtGrYi7Cu1K2K9u1KDJMJRvhaq
 vf2kaOa6ZfFhqqINzM07VKI1/E+zQzKXTZrAxDu3hoFuRCb36SWXyl0rxfBTTCCywbOCep8pBZKBm
 rWGda8TQFzwQGMDdeXu1sufhGdIIdMRmbAZ08vKPWlnHAfyX9YaGfoL7qH7B4mYCTLLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9iFBHJkp7up0ymjAoTr9pGik901atUgs+vltbP87kRA=; b=WycdD4DLmC1B1plS1n2Gi9gtEb
 SzshH5/sYrQx1DemLRMr/tKVDANue1MDEmEW7oK2I5HlUgDb9w3U9/DMhTe7A8lXy3A3rsSHdqBaT
 r5ojfbC2C4+zr+j0DI5Q0dB0tWr9QDcWY7Y7rE3LW2O7cdrLaW8Efp4YYx39YauUI2jo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUyU9-0002LQ-Kx for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 Jan 2024 00:29:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E25AB611D9;
 Wed, 31 Jan 2024 00:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50234C43390;
 Wed, 31 Jan 2024 00:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706660979;
 bh=D3cBN3aB5cNbTbyQFYW4Hq+b+QWshyCJ+Ot1mi+gd/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FV0jE6q8R4zeCARBAI0FTnrytJ5JAYcK0DeacrN9ClZe7QVHxN8rjDTtMEU0ZxnPX
 SWWMlXqeQCyeW2LrjHG8SA0mgzYBD+scdKxU/E1UBwJtCzigduwqtlNftN9El76Ccw
 YGOu7Gfs0KzJ8OLkDuA/6Wy+Oy+Y2FcHc3SWmpqmVWSB6gPdxVHBdKOAUbZyBh3sRX
 AkHBeWM2X6ZYNfIRyDgryg46uvo12CI9+3rXlBqjrPkiaUomSYg7BX8eXnxIaamPde
 Pmg4mmZ+nR6InQ5qIViQTsYkMdLhIQ9ykPyAv7QCD+8p3pW4Akhkaaw2C2hM+Nu36b
 0Q0jQZR2ac2hQ==
Date: Tue, 30 Jan 2024 16:29:37 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20240131002937.GB2020@sol.localdomain>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-3-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240129204330.32346-3-krisman@suse.de>
X-Headers-End: 1rUyU9-0002LQ-Kx
Subject: Re: [f2fs-dev] [PATCH v5 02/12] fscrypt: Factor out a helper to
 configure the lookup dentry
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
Cc: tytso@mit.edu, amir73il@gmail.com, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 29, 2024 at 05:43:20PM -0300, Gabriel Krisman Bertazi wrote:
> Both fscrypt_prepare_lookup_dentry_partial and
> fscrypt_prepare_lookup_dentry will set DCACHE_NOKEY_NAME for dentries
> when the key is not available. 

Shouldn't this say: "Both fscrypt_prepare_lookup() and
fscrypt_prepare_lookup_partial() set DCACHE_NOKEY_NAME for dentries when the key
is not available."

> @@ -131,12 +128,13 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
>  int fscrypt_prepare_lookup_partial(struct inode *dir, struct dentry *dentry)
>  {
>  	int err = fscrypt_get_encryption_info(dir, true);
> +	bool is_nokey_name = false;
> +
> +	if (!err && !fscrypt_has_encryption_key(dir))
> +		is_nokey_name = true;

	bool is_nokey_name = (err == 0 && !fscrypt_has_encryption_key(dir));

> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 12f9e455d569..68ca8706483a 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -948,6 +948,16 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
>  	return 0;
>  }
>  
> +static inline void fscrypt_prepare_lookup_dentry(struct dentry *dentry,
> +						 bool is_nokey_name)

Maybe just fscrypt_prepare_dentry()?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
