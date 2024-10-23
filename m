Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB273D2E00A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Oct 2024 02:56:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t3RXV-0001TV-EV;
	Wed, 23 Oct 2024 02:56:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t3RXO-0001T4-3x
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Oct 2024 02:55:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BJv2fItB8Hb79fU21RwHsRwLIKHlgAyqVoYB/M/HgJM=; b=BGRlfZk9Aiom8Kg/oRWK9CnWys
 FbjDispETk03NCi59+r5gEEGvhp+Ec9FsC/sdq5kCABW1/mGx7D5kck6wO2WT/kKT2bcPR5FfKMK3
 /D/i8ujWyrpwBHgUYuNDmSCzIeyBAr3fXUNf46lO4NUSUQmx1c8m2NHlvWYJI3zLBIZA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BJv2fItB8Hb79fU21RwHsRwLIKHlgAyqVoYB/M/HgJM=; b=X9vy0t/b54G4tdA+LtdYV+MsUH
 59S49odTp3TtDcZOOt1lbq8wCYjbou339dw7VqwTo6XEULUDzB300Jb2h45X1lB9TPLRT3oak/iM5
 cp55mhEjGIAyFxXbUKb2TsIkgJ+z/LqvJ39h/cTv63UVVxD2sS+97w35IIfEvJFn0HLU=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t3RXO-00055s-7D for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Oct 2024 02:55:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 56738A44898;
 Wed, 23 Oct 2024 02:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F123C4CEC3;
 Wed, 23 Oct 2024 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729652143;
 bh=OStp0MHjUmm8aKULhhvMvWY25ziHmGwzr71AVGuIMPU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=Q1r1C0/48a6ZFL9RTepqs+vEQHY3/zDCXmRZ3J+H4bEZkJeLUIwfU7d/jEXAuuuPZ
 XTXKeNWsT0DY2pGJyIXfPPGitE8nJYraoVnQ8b0liQnf5tKzu1jK1bfJ6zt1FdQRZy
 2QJTTXb8QIbxMRA62QoOrqu54AkDZxPiBPcaa0IfYMJZHDSDvCPKxsl10R2TQr1AQi
 OtfoAnXajK8aT8LKy/sP9JZ4++lPg8z4okz8uDRjlYSDykmTQOV813rDNEdCBgA6Io
 32INsy3b+kz6s2BFO3u1q8Ar3LWjIXpiDhx+ocMK73F5Jgkzuhw3XnH1viTIdmRGCI
 nm3zSMUtNkl0g==
Message-ID: <c6b08e67-0697-45ce-9302-0150f69725f7@kernel.org>
Date: Wed, 23 Oct 2024 10:55:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20241023025945.1817457-1-hanqi@vivo.com>
Content-Language: en-US
In-Reply-To: <20241023025945.1817457-1-hanqi@vivo.com>
X-Headers-End: 1t3RXO-00055s-7D
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: modify f2fs_is_checkpoint_ready
 logic to allow more data to be written with the CP disable
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/23 10:59, Qi Han wrote:
> When the free segment is used up during CP disable, many write or
> ioctl operations will get ENOSPC error codes, even if there are
> still many blocks available. We can reproduce it in the following
> steps:
> 
> dd if=/dev/zero of=f2fs.img bs=1M count=65
> mkfs.f2fs -f f2fs.img
> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
> cd f2fs_dir
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; dd \
> if=/dev/random of=$file_name bs=1M count=2); i=$((i+1)); done
> sync
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; truncate \
> -s 1K $file_name); i=$((i+1)); done
> sync
> dd if=/dev/zero of=./file bs=1M count=20
> 
> In f2fs_need_SSR() function, it is allowed to use SSR to allocate
> blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
> can we judge the number of invalid blocks when free segment is not
> enough, and return ENOSPC only if the number of invalid blocks is
> also not enough?
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
