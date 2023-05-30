Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF14C77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 May 2023 23:33:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q48po-0004iG-CG;
	Tue, 30 May 2023 23:33:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1q48pk-0004iA-2W
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 May 2023 23:32:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vEzkXBQo/b7PQnyCX67HVTT4YmASqWFxkqgWXgu3lfg=; b=a5UYZ3JSOQ7luWx7rw592F/WCd
 rnwYc2dU+3eWNXYqFJ0SUIdaPmvplrdtcie2qgnAkhBVw7DVy5Znqf1CPnx7QjOsaQBekxmz3D/7h
 /3bKbraQ5QX0dg+9ECoEMEJqtO/BLS1AutVbBbAOOzDOWmKk+WLXmWtF4nl8tIHsGvgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vEzkXBQo/b7PQnyCX67HVTT4YmASqWFxkqgWXgu3lfg=; b=idKqEdIok3Vh4LMkfB2g8WaUh0
 u2ZaYh+uCcqjHdhbafqWANi6MMD2pllSMFcwFh83OtHt3/F0AFebdQosh7rTKApreS8K2DxTf6a86
 yjBacUhg0Zr7FExCBh+5jx6/3Xekvq5Sk/W+3E4MqyWzOq8iw4arjdawgpsDOafpgIEI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q48pW-0000Bm-OM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 May 2023 23:32:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5C4E660F08;
 Tue, 30 May 2023 23:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B92AC433EF;
 Tue, 30 May 2023 23:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685489556;
 bh=JXz0xI70zuYpYZsltrSyZalooGB27OtEMdKKeiDcQNU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tXcGh5VxJseqUJCs/l1tb6YMnkYiaCyHEJTbJqUThtjcDapGkcJac485k3iwsuBrJ
 SdqnqflN+cQvNFYN+X1ewgC1UEYScO3QvVLLxMZvRn/P+VzwJmuG3jsV5DcJnqPR9e
 veyKyUJlQCnr5v3vsOg+e9djeOGIprE4lt9SJ3sF8g/IsnW/3PeQHDkL06aKLTG5ml
 zjQwucwHtmy5cbW9CStYnaZd+lGyaZGsgaGWmEpKpAvISP+5LcTF2Q8QAHvuOqbQpu
 J//q6QKPKLT4b9ZC0qupD41JPo8h6SBsGiv6sx4mL1auDdcJb6WAPzzwg6Md8zlXel
 wVzjEwbX49w6g==
Date: Tue, 30 May 2023 16:32:34 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Wu Bo <bo.wu@vivo.com>
Message-ID: <ZHaHknKmSQIdQzBC@google.com>
References: <20230530012118.74228-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230530012118.74228-1-bo.wu@vivo.com>
X-Headers-End: 1q48pW-0000Bm-OM
Subject: Re: [f2fs-dev] [PATCH v2 1/1] f2fs: fix args passed to
 trace_f2fs_lookup_end
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
Cc: wubo.oduw@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/30, Wu Bo wrote:
> The NULL return of 'd_splice_alias' dosen't mean error. Thus the
> successful case will also return NULL, which makes the tracepoint always
> print 'err=-ENOENT'.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/namei.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 77a71276ecb1..0c5e4c424eab 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -576,8 +576,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>  	}
>  #endif
>  	new = d_splice_alias(inode, dentry);
> -	err = PTR_ERR_OR_ZERO(new);
> -	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
> +	if (IS_ERR(new))
> +		err = PTR_ERR(new);
> +	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);

Again, new can be an error pointer, and the previous err was supposed to be
zero or -ENOENT.

case 1) dentry exists: err (0) with new (NULL) --> dentry, err=0
case 2) dentry exists: err (0) with new (VALID) --> new, err=0
case 3) dentry exists: err (0) with new (ERR) --> dentry, err=ERR
case 4) no dentry exists: err (-ENOENT) with new (NULL) --> dentry, err=-ENOENT
case 4) no dentry exists: err (-ENOENT) with new (VALID) --> new, err=-ENOENT
case 5) no dentry exists: err (-ENOENT) with new (ERR) --> dentry, err=ERR

	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
				ino, IS_ERR(new) ? PTR_ERR(new) : err);


>  	return new;
>  out_iput:
>  	iput(inode);
> -- 
> 2.35.3


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
