Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C03FC7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 May 2023 17:21:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q2b7x-0002zm-4J;
	Fri, 26 May 2023 17:21:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1q2b7w-0002zg-4u
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 May 2023 17:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TIjkfSltBGoHMDVJMLIFiM2/FJ3SSYVYXtUCRMj64/A=; b=cWIRn7glubfJ1neva57SuzRh59
 IT4SYOdquuJS+IQw6mdElaQixI63noQ9upizpFqJbQ9kOfgGe/BCtij5YQWKk9DvLqiUQfQiGxG5z
 vg5b6z44ktTLZG292qf634gXQQHIP6O6QcXHAh6hxc5RU2VQOGUr24pdD1FLqK8RUqKA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TIjkfSltBGoHMDVJMLIFiM2/FJ3SSYVYXtUCRMj64/A=; b=P3xyejLkg4xsd2u6/JL2RA5Kl2
 dH3xIgv7igm4OEg8DuvYwR21quuAGAZA2aSYHoHymGFYP7uDB6PjmU3HkLUiR8K3mPBhDUol0Wtpj
 Tl23gYgyChLsHQJXYTK2qjlkIUJjlI/GJ++J3/+B7uq340OVkRCHSxMd2J0G9DG95GHY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q2b7v-0003MO-4g for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 May 2023 17:21:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AB512651DA;
 Fri, 26 May 2023 17:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1489C4339B;
 Fri, 26 May 2023 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685121673;
 bh=gh6aGwNXF50lyfx9OR33zTQ40B1N9Ok+l110UgV9qcI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KCZWZO1PWnA8Cq7ymgLi3vRtsV0NlSriolEERPEA+bwPTZTWmfaLKm0H3LuxCbkHF
 j+o1OzQiW3Nu3kkBjBkqZ8lcKomyl4c/96+9/R6XAq2cqjk/SzOSysxhQ7N7XHDj1k
 35DTIrnhfczEV6SGpFHZtqDhZ+Ww4CQ+40N1OY9LdynmL4brW1eBsIyAI2Hzu1V3nu
 VtBKjURAhdG+9lpFHBoQS0eSaUiEWcFe0IwGugC5NEooutaAocq/jlD6/j2bq9TUHl
 3QKblWFwpOOLi9bYbwx69M4mPSp/LXSQIxwcAQcvUwewnPXkGQTiFGB33ExAgfRWh8
 asFhwsOwQO2nQ==
Date: Fri, 26 May 2023 10:21:11 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Wu Bo <bo.wu@vivo.com>
Message-ID: <ZHDqhy4E9iSnneLa@google.com>
References: <20230524100812.80741-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230524100812.80741-1-bo.wu@vivo.com>
X-Headers-End: 1q2b7v-0003MO-4g
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: fix args passed to
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

On 05/24, Wu Bo wrote:
> The NULL return of 'd_splice_alias' dosen't mean error.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 77a71276ecb1..e5a3e39ce90c 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -577,7 +577,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>  #endif
>  	new = d_splice_alias(inode, dentry);
>  	err = PTR_ERR_OR_ZERO(new);
> -	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
> +	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);

Shouldn't give an error pointer to the dentry field.

How about just giving the err?

-       err = PTR_ERR_OR_ZERO(new);
-       trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
+       trace_f2fs_lookup_end(dir, dentry, ino, PTR_ERR_OR_ZERO(new));


>  	return new;
>  out_iput:
>  	iput(inode);
> -- 
> 2.35.3


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
