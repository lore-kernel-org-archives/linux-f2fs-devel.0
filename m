Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B70ACD5BA4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 08:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YX80dZpKHqCPxwxeem1gvHIvm/mL75YNK7KDW4PWWQM=; b=VuI4E5KqUGnhJjCMUkzRxoas6Y
	sVAUnqooXN6TVxz/mbRSEDWI5shUAND1Oqpb4ZaZUfRPaUeMHJtT0M6CwDuZlUQgJidjkwh4yojZU
	23qOArST+QmJ0j3LkjyPKaXLhgsot1DyDsit43W3LGwt4aYenYNncaW6tNcprrWQcj+g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPyqj-00031k-Q4;
	Thu, 21 May 2026 08:33:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wPyqi-00031c-Vn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5uJVI5XPO57gLyBlcGvJvIzQZOz39KDgj0mLzTJ0SEE=; b=Ckg4bAPzYceaiQCuWVKEgT7qfU
 N83ExBFVlda2T7vP6Sd837EgO+a7S/DrMSz06VHUCp4Up46kLx6wWKg/B3SYTp8mO3T3iQRe2lCkl
 V7N/+fjXp2zzw9X86kVQlc9MdLI+GYSE+A6gPIG2qYqQOwi2Ywy+VruoDYDGRVm8xlbI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5uJVI5XPO57gLyBlcGvJvIzQZOz39KDgj0mLzTJ0SEE=; b=frx28mVrcgVXATgYVCZWVWohMY
 j2gb9sKQBsE6i5aXcyJARmTVaGBRe1ciML9qdggLgP86IDifHeCKqt93w8+ZfbzuQwHidp1o4Vigb
 Le7u7j91+Tqep3aaQm5qJw3tsCiF2frQ8WUw8YlNlGcaYPpmFCdMHSzTGvCgfUO6mpAc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPyqf-0004Xj-Hd for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:33:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B16A41781;
 Thu, 21 May 2026 08:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C95E1F000E9;
 Thu, 21 May 2026 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779352415;
 bh=5uJVI5XPO57gLyBlcGvJvIzQZOz39KDgj0mLzTJ0SEE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=JqMYXInTXLOTnQ/+LI3w7ERAT6rmRKIC4PTUF6zZgYIbESP31XsNYpWufdQoupT15
 hPssy4mk8qFf+9UNfitS0XFr/O2lxDSPCeoGRVgRAaCRryoSxx/UCmAlmXFrpVXIBR
 fjystY/werxZ7pYrV7x0R6zkPMOYDykm6QiunHndoPyAXzn9Mmf5EbFkUQK/nS8/3J
 +Zj28Ak5TF5HmdUnRwTc9YUqi6MaJOEW3yuiavTQsn7MJCx9EHxEUOplLphordCv7m
 xQrqdlb5kTcaLfClAZ936iDvYdWGhyqlf18PU2QRGLAme1zRg5uJTjYuv8Wme2J/g4
 Xm0akkqv9gCvg==
Message-ID: <72ad802a-040d-43f4-9679-225f0b8c716e@kernel.org>
Date: Thu, 21 May 2026 16:33:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260520141935.1363513-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260520141935.1363513-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wPyqf-0004Xj-Hd
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix user.fadvise xattr input validation
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/20/26 22:19, Wenjie Qi wrote:
> The user.fadvise xattr handler reads an unsigned int directly from value,
> but it is also reached by xattr removal and does not validate the supplied
> value length.
> 
> removexattr("user.fadvise") calls the xattr set callback with value == NULL
> and size == 0, which can dereference NULL.  A normal setxattr() call with a
> short value, including size == 0, can also make the handler read past the
> provided value buffer.
> 
> Treat a NULL value as clearing the large-folio inode registration.  Reject
> non-NULL user.fadvise values whose length is not exactly
> sizeof(unsigned int) before reading the value.
> 

Cc: stable@kernel.org

> Fixes: 39774f27deaf ("f2fs: another way to set large folio by remembering inode number")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/xattr.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 84273936f2a..4e11d774a2c 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -80,10 +80,19 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
>   			     buffer, size, NULL);
>   }
>   
> -static int f2fs_xattr_fadvise_set(struct inode *inode, const void *value)
> +static int f2fs_xattr_fadvise_set(struct inode *inode, const void *value,
> +				  size_t size)
>   {
>   	unsigned int new_fadvise;
>   

Better to add a comment here to describe it's from removexattr("user.fadvise") path?

Thanks,

> +	if (!value) {
> +		f2fs_remove_ino_entry(F2FS_I_SB(inode),
> +				      inode->i_ino, LARGE_FOLIO_INO);
> +		return 0;
> +	}
> +	if (size != sizeof(new_fadvise))
> +		return -EINVAL;
> +
>   	new_fadvise = *(unsigned int *)value;
>   
>   	if (new_fadvise & BIT(F2FS_XATTR_FADV_LARGEFOLIO))
> @@ -116,7 +125,7 @@ static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
>   	}
>   	if (handler->flags == F2FS_XATTR_INDEX_USER &&
>   	    !strcmp(name, "fadvise"))
> -		return f2fs_xattr_fadvise_set(inode, value);
> +		return f2fs_xattr_fadvise_set(inode, value, size);
>   
>   	return f2fs_setxattr(inode, handler->flags, name,
>   					value, size, NULL, flags);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
