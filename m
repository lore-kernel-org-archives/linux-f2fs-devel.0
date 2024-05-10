Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4114C25B74
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 May 2024 01:24:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5F01-0003sz-5U;
	Fri, 10 May 2024 01:24:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1s5Ezw-0003sp-G5
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rmeGYW2sWW6qHRS5bsOvHpwfcVcDw4XWN8xI3SGGopc=; b=dC78+pcBRZ6wMKNFXc1knuD6wq
 SismjQT8obE+29Skgor1XEWHcZHr/C/pFMHI0wGB1iHvExvJVcteVc/Ytc0YuCRkzIFd8VSaMFirp
 H/y3/RkWvTRieMhDn8ASv2Q0q6gCRmY9gW4kK4lkUD66Dhkh3kjoEyPlWFDUw5TxZGF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rmeGYW2sWW6qHRS5bsOvHpwfcVcDw4XWN8xI3SGGopc=; b=S9bSn0QtjDoDpglqNGJeivodLA
 8lGE4FUxocoNTr1akbJBucG0Do4Cj3/yk0ELm1MK4/dVSQ6qJyq9mYhhnHyUT1TdW1ZVWkRDzlbSP
 lQlipbr0lYVxC9TiTCUM+CHlt/X7Wx4scAT2eaXXTAiipZj2yV0Nz6EubMoBOZ9Ng0iA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5Ezx-0007Wp-SC for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:24:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BF54D61D79;
 Fri, 10 May 2024 01:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37998C116B1;
 Fri, 10 May 2024 01:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715304267;
 bh=dMR4rNMP4Jcx6tRoPoJo4UFOm/KXq6CVgtCEiKRmYJg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OmWHKpvo+C5HzCNnJV05leNR1+YkwK/zxI+CPQUuAAYF/C3dyJbTDjuq5nl1QRDLV
 A0Se/n0Msq3QPlVf0hku/NuRTmXBIx+WxiaT8yZ92WS/3M5DGwGcC/5Q8IgWnYgGxX
 OlyHcv3EllLJ+ESeg1a7MQBZ+qazfnR3bqLZlHKhZckWrkF1angURQOg0A1eb6uiY+
 qOozR08OiNuLumFzbLkr1PYukoeree0YVLYi7TPhLAHXc5OBO1o8iaC6kD3Gm/CNbt
 yHCv1xe/+oGSvUuO81w/xFD9/T8f6YsfDKFHdD5NhRqyNQ4svFdEYhQoBskyMLIzp9
 iAJ1D066u2+vw==
Date: Fri, 10 May 2024 01:24:25 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Message-ID: <20240510012425.GE1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-7-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-7-eugen.hristev@collabora.com>
X-Headers-End: 1s5Ezx-0007Wp-SC
Subject: Re: [f2fs-dev] [PATCH v16 6/9] ext4: Log error when lookup of
 encoded dentry fails
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
Cc: krisman@suse.de, brauner@kernel.org, kernel@collabora.com, tytso@mit.edu,
 jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 05, 2024 at 03:13:29PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> If the volume is in strict mode, ext4_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
