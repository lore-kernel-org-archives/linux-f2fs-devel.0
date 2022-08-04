Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31723C19F2A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Aug 2022 18:29:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oJfay-0008K5-Nu; Thu, 04 Aug 2022 18:29:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1oJfax-0008Jz-AX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 18:29:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HXMYfrEvh0Jy1Nqpyly+ubDtxIFXRiHQ1npzbk8XOe4=; b=V0a2dKEXVsdpZdVpxJcqC3rUAa
 fN+W4UhHsmpX7A0NopV/dtA03gFrGCBCgb2RRFJIuVnUPiwhCIAMxjyWB4QUuq2v0mhnamF/OCVC9
 iIWgXKC4116U1hgaoNsBtWd3VbQz06Eaij6z5VOh7R284sElha2X247C0l89p2sYo+6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HXMYfrEvh0Jy1Nqpyly+ubDtxIFXRiHQ1npzbk8XOe4=; b=B8O8BbO7+PAiTsEsLXw+EetXpu
 nCflD/8k3I9x/fXRbRRPRg5qEqF88awLE84kvx/9suckSwnT+ssK/eZCio/WSLsE8FT/JwL30oTm6
 fUYNOvfQM6QBlV0gM6LTh3/ofqriLKbzMJqK53kBhUKtSKso7jyRkxE3U992bUFuVat4=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oJfas-003SZX-1n
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 18:29:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EE3FCB826D5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  4 Aug 2022 18:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E50C433C1;
 Thu,  4 Aug 2022 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659637741;
 bh=B6nriIfph8fYOJUBlU0yKPRkJ6yBSCpseUxsuW/Ai4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tpoZW/Z3yXpE3cKMpPr4lKB1hrOMbxh5rHlOgQtjaJo/x1T0eO8OkTsSIq4hRJoPy
 1GkGJMgFh/dnzpVuAqSQifxCptE94w9u3kLRY14GQRbNEPDJiuJoF0yKBoUWR/ts0x
 FrJiPCWfCl9ONd6ha95QpvlYMjOmS7r+MmDJDqVXpjtdzzM62U9jCnidJ22iebr3u2
 GRVfQIJBD9oAPpvYIf0sjF0HKCYB9HtKiVvG2jl5S5KcSgnRJfnb8fiHx/WUxKhia/
 m+/a4FvHrzAdbC7PD6jWwSoFnHZpNy3q5BgxjqLyphQvzGAxKBOtLVfFxcg6TuB8m8
 6V2CVmjGNkLnA==
Date: Thu, 4 Aug 2022 18:28:59 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YuwP67c0oNjhojmt@gmail.com>
References: <20220804134140.14455-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220804134140.14455-1-chao@kernel.org>
X-Headers-End: 1oJfas-003SZX-1n
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check compression feature
 before enabling file compression
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Aug 04, 2022 at 09:41:40PM +0800, Chao Yu wrote:
> From: Chao Yu <chao.yu@oppo.com>
> 
> This patch disallow to enable file compression in image which doesn't
> support compression feature.
> 
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 24f5b02c78e7..4a3f4eaa3fc5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1872,6 +1872,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  			if (!f2fs_disable_compressed_file(inode))
>  				return -EINVAL;
>  		} else {
> +			if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
> +				return -EOPNOTSUPP;
>  			if (!f2fs_may_compress(inode))
>  				return -EINVAL;
>  			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> -- 

How is this different from the same check that occurs earlier in the function?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
