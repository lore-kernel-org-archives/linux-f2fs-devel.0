Return-Path: <SRS0=QpjO=LW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC1C2B9F4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jun 2021 12:33:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DF26197F;
	Mon, 28 Jun 2021 12:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DF26197F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lxqRf-0005Kd-IN; Mon, 28 Jun 2021 12:32:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1lxqRd-0005KV-P3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 12:32:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4+r/cgqX9YDuAtZ44xOCG3S8a/IEIJpcsHqfgxHl6B8=; b=g8/GF+2i8Y2WUcPYBoMWuwDcvg
 6PQrnDZdvrr5WCett0wUQ8+9HXON37h/BTTqRItnAA72dxqOi6d0saimXaRCEZtEwKite3sNLYZAk
 LOKTlLP0PWvfy55Ljx22+lcQ+rckMGz+bjc+hsASv97Sz4QE5zR8N3F56lLp7UVSdujI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4+r/cgqX9YDuAtZ44xOCG3S8a/IEIJpcsHqfgxHl6B8=; b=HF/K2RCR8vshrFH/Mnj2k3iw4e
 wsy+ph+nlUBghociQ4txjDvU6+qzht39H9WOyfxxUP71TlLc7rnUuAQE0AUCgjhAqbNGPiz2BvukF
 NYp6kqYLpZbbpGJeWsqYrl6XgHmkyfrZ0Ir3sCTDTfrpSseL/cthfTEU0SVJhIyLOnf8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lxqRZ-00086s-Da
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 12:33:00 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29D4361C69;
 Mon, 28 Jun 2021 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624883569;
 bh=fba2ofOnKtAzJy7DfRgkBmV/HvK8go7wtyTKdsJMeSs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Qa1t9zYrwaNQIT2IakEmr5Xdtp0CZz7K+3l5HpwgLv9WrjnLogLLlqYgmzENDLAq+
 GzybkqKeImxapQ+O6wThw5if22ENrhqhQBrnz8+Bg4WunyXNLC6qWl8fUJJ2xYKtW+
 whgDS4uMegZIJS/NUgW4MQ/m0JOc6fd6ZR+16r7yj0FKcNK8bl25eytpHaWCqvZTIA
 wUAdQxjWrjd76SnKoyFLC2jBwjsFMH7BPPUq0jkVP1dnicjVu4JoWLwpEEWdoLlVMO
 wPxi5BDHw6E8ehYPYYe24ZxFUKLMtPVKHsxwHLonNDn38yuNYzZCIqKjwt8SVFmAO8
 gh0T4zz7A0cvg==
To: Wang Shilong <wangshilong1991@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210625125026.5796-1-wangshilong1991@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <9f6d607a-6b43-a3e2-7002-426f58513f9c@kernel.org>
Date: Mon, 28 Jun 2021 20:32:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625125026.5796-1-wangshilong1991@gmail.com>
Content-Language: en-US
X-Headers-End: 1lxqRZ-00086s-Da
Subject: Re: [f2fs-dev] [PATCH] f2fs: forbid U32_MAX project ID
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
Cc: Wang Shilong <wshilong@ddn.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/6/25 20:50, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> U32_MAX is reserved for special purpose,
> qid_has_mapping() will return false if projid is
> 4294967295, dqget() will return NULL for it.
> 
> So U32_MAX is unsupported Project ID, fix to forbid it.
> 
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>   fs/f2fs/file.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ceb575f99048..861edf3c01d5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3066,6 +3066,8 @@ int f2fs_fileattr_set(struct user_namespace *mnt_userns,
>   	u32 iflags;
>   	int err;
>   
> +	if (fa->fsx_projid >= U32_MAX)

unlikely()? if this is really a corner case.

> +		return -EINVAL;
>   	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>   		return -EIO;
>   	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))

I prefer to check fsx_projid here to keep line with check order in other
f2fs interfaces.

Thoughts, Shilong?

Thanks,

> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
