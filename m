Return-Path: <SRS0=qzJ6=IX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF99C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Mar 2021 19:22:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DB261A2D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Mar 2021 19:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DB261A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lPVYT-0005x5-0i; Thu, 25 Mar 2021 19:22:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lPVYR-0005wx-M6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Mar 2021 19:22:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rh0xO6rQYxFQlBSLC78Yt8Y8ABYqomv3/vAepelhnOA=; b=S1p9L9IjSAIrpzrU1Qnz4IUQ8k
 IQHWj/UrQnlSzNcv5T+5qBfAoBFN0Ei/1ciWX5j4JKNndEHuUbL4hCB6FH/6/w0cgrGD70EwW63I3
 W5FvdUtfNlkdtONiSSWAsU0U9YeN+ckDiAIdXqUaVyhoYL1nP2JYzXSNChyilKBK0JGw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Rh0xO6rQYxFQlBSLC78Yt8Y8ABYqomv3/vAepelhnOA=; b=bldVlkAOpPvmhz3PotN1/ENIpa
 z9j86eKqW4SRcaDTc0EA2AOppeMDS8VLfwHtpgjU5MPSfJJNGx+rEtscjDo6zJoB6+RyHHVQV/0dE
 r2UBbLAPsu7yBUEMy2IBGvSQ8YVA7orBl7uyQOu2QYvSToM49jmXme/bV+cFj58mde1w=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lPVYK-00AxfI-AT
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Mar 2021 19:22:03 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9489761A2D;
 Thu, 25 Mar 2021 19:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616700110;
 bh=ziH8ogtlFgf/xOHmwTBESqJ99TGlQQhBRPL/aLU87cA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JAY+5fXqPKWwLnTbdHOAB5nICVjmbMd7AjyjWXvTU4tNS/swPQ6ClAN8NLqu8kd9p
 tj9bu2iwzf1ywkBkoD927nDvdNKKkPrmNWZj0C6C1xwxHmL7D+mwYB0ZaPunZoQ4Hr
 yOY4L40EcGNjhEsI7IyEMsRff/IMO5Y3hyu1OIut1c+z+eVARbNiSlpkzoH9zcQlPu
 8VgxPP2Edk36MNkXi9Jc2OkrJE9a88C7Gi10v5/34VRIKGAyHBTvhMWIP5aseHvs/R
 IaGa0JdlI8sfo4keKEIDwa0wy9XaBlraoNckKUN3lDQKZLiB9AKTjtlyAileb0DbIC
 RkQZRhcn0It/g==
Date: Thu, 25 Mar 2021 12:21:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <YFziza/VMyzEs4s1@sol.localdomain>
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
 <20210325000811.1379641-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210325000811.1379641-3-shreeya.patel@collabora.com>
X-Headers-End: 1lPVYK-00AxfI-AT
Subject: Re: [f2fs-dev] [PATCH v4 2/5] fs: Check if utf8 encoding is loaded
 before calling utf8_unload()
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
Cc: tytso@mit.edu, drosen@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 andre.almeida@collabora.com, linux-ext4@vger.kernel.org, krisman@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 25, 2021 at 05:38:08AM +0530, Shreeya Patel wrote:
> utf8_unload is being called if CONFIG_UNICODE is enabled.
> The ifdef block doesn't check if utf8 encoding has been loaded
> or not before calling the utf8_unload() function.
> This is not the expected behavior since it would sometimes lead
> to unloading utf8 even before loading it.
> Hence, add a condition which will check if sb->encoding is NOT NULL
> before calling the utf8_unload().
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  fs/ext4/super.c | 6 ++++--
>  fs/f2fs/super.c | 9 ++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ad34a37278cd..e438d14f9a87 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1259,7 +1259,8 @@ static void ext4_put_super(struct super_block *sb)
>  	fs_put_dax(sbi->s_daxdev);
>  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
>  #ifdef CONFIG_UNICODE
> -	utf8_unload(sb->s_encoding);
> +	if (sb->s_encoding)
> +		utf8_unload(sb->s_encoding);
>  #endif
>  	kfree(sbi);
>  }


What's the benefit of this change?  utf8_unload is a no-op when passed a NULL
pointer; why not keep it that way?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
