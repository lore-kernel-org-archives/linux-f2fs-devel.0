Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD550606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jVSTneH2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FVRY+MRt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UKhmY1D7;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYbwkVPQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MZHRnsYYk9xbilIe2M8YbC9bMpyaZWSTv2m+1g7VttU=; b=jVSTneH2/ouCg6
	WBNVUVG6Q8i7buT+qOyZF7m6KAaOKpwubul4T3NJxiVpX/4Z7bN+u5ghQLK/opkxu5VjXpVOvQYZ5
	5SDsZ6oIDYVaJYdVcaCqKCf93vnW+JxlflDx2DYpXtJxFNq9IUn7bZwywU8OXXFA75rS1+tPlHfNU
	tpQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR4qz-000000001g8-36Pc;
	Wed, 11 Nov 2026 09:42:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xR4qk-000000001eE-0wq1
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+UXs3lHVlQsYdFZ0M6ic3j3lh1I9mB+CJLu6Q79BNGU=; b=FVRY+MRtK3SiOGauQDCxI6ACDc
 tJCKLFO8ASP2IXn70C+Hwy70Ug3xTNgy8h+1XitEn4jHf2CwY/ivek8BrzUbq8XWOg8lYxzsMlVgC
 Gf7qNR2Tx898fdFfliCrIW0tY5hObyMon9B9F5Sdrzf0QcVRKANKXfah87wQUNTGT4PA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+UXs3lHVlQsYdFZ0M6ic3j3lh1I9mB+CJLu6Q79BNGU=; b=UKhmY1D7kP/5Siqv9CelsqAAUV
 tHQx4i9GmHIcewZxb/4BPUz6eySArZ9EFWxeQDaDHCBACoCTvGJcvZki6ZSgNu2Q1sPvPtZvjmqUm
 NSbqw/8FaoXM/y8fRdPar1oVn6YsisAZ+dsvgYZSnJfkjQ6YB+AveaBTWqKD4RfhcI4M=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR4qj-000000003HZ-3Bz3
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:42:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D0534722B;
 Wed, 11 Nov 2026 09:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552301F00A07;
 Wed, 11 Nov 2026 09:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794390152;
 bh=+UXs3lHVlQsYdFZ0M6ic3j3lh1I9mB+CJLu6Q79BNGU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=dYbwkVPQ4PpwEJ8bCBzaHbXiBh6++nCCd20jv0GNzamf5Y6RzbLZk3c4fkILl96CU
 vsq3px58d5jXcQOU5ueifEXt5bGwEo0GF4m4Hv+U9ehRIb4B1qDrinq+XWLq6RHV0y
 52DiSMOcCLtPEXVvQvpbVHkaCTGFrz7CADcsYjy5teyd8ixbZLYw5McZcEarM9pZ74
 w+ewx2EYcsaHjK0fgZqK3CdkM+yjlGCGTl0mxlnECtxC+vmCAC/YrytzukORZx612E
 l2G+Q5RolRDekLTZirB82apYZ0a0aw0V/eEl/S6rgJoAFzA8FXWz7j5mA6R+i53yxU
 XrCy0xAH4a4mQ==
Message-ID: <64dfd4fe-46eb-45b5-9eb1-ab0564bc2d47@kernel.org>
Date: Wed, 11 Nov 2026 17:42:29 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hungyu Lin <dennylin0707@gmail.com>, jaegeuk@kernel.org
References: <20261108075357.43331-1-dennylin0707@gmail.com>
Content-Language: en-US
In-Reply-To: <20261108075357.43331-1-dennylin0707@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR4qj-000000003HZ-3Bz3
Subject: Re: [f2fs-dev] [PATCH] f2fs: require CAP_SYS_ADMIN for fallocate on
 pinned files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 15:53, Hungyu Lin wrote:
> fallocate() on a pinned file allocates blocks without zeroing them, so
> reading the file returns whatever the blocks held before.
> Documentation/filesystems/f2fs.rst describes this as "zero or random
> data". Commit cad3836f9eb2 ("f2fs: allocate blocks for pinned file")
> added this while F2FS_IOC_SET_PIN_FILE required CAP_SYS_ADMIN, but
> commit b13bdf03bb80 ("f2fs: allow all the users to pin a file") then let
> any user pin a file. Since then any user can create a file, pin it,
> fallocate() it and read back data of files that other users have
> deleted.

Android should be safe, as on-disk data from user is encrypted, it will be
decrypted only in memory w/ user's crypto key, there is no way to read the
plain data from disk directly.

> 
> Require CAP_SYS_ADMIN for fallocate() on a pinned file. The documented
> use of these blocks needs write access to the block device anyway, and
> Android's gsid, which creates pinned image files through libfiemap, has
> CAP_SYS_ADMIN. Users without CAP_SYS_ADMIN can still pin files, but can
> no longer preallocate blocks for them. fallocate() on files that are not
> pinned is not affected.

Or maybe we can call f2fs_secure_erase() on the blkaddr range after
preallocation and before return from fallocate().

> 
> Fixes: b13bdf03bb80 ("f2fs: allow all the users to pin a file")

Jaegeuk, do we suffer any permission issue before above commit?

Thanks,

> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/f2fs/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e2c0f5083313..d1b52b41a1eb 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1973,6 +1973,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>  	block_t expanded = 0;
>  	int err;
>  
> +	if (f2fs_is_pinned_file(inode) && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
>  	err = inode_newsize_ok(inode, (len + offset));
>  	if (err)
>  		return err;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
