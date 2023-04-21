Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571AEC7EE20
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Apr 2023 02:25:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ppgTD-0001qv-1r;
	Fri, 21 Apr 2023 02:25:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ppgTC-0001qp-2V
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Apr 2023 02:25:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qgOSnQECfDYXV17vwBvX0tz30iboNzg62aqqDRsKuGI=; b=NcJzQVI2XyUxmwTbtl8DKkqkUk
 CJYzjyW2S2nv1XtMXsYUB2WzCKxTV+GzCeHu0+r1lzRNMe9QhYj4Eg5VS+5q9T+Mighpnf9PH5Np/
 jQhKiEN0MRNa6XsEZ+/PvRfPvp6moHuMWRZDOB8z1VA5NetumBnnaCByibnK1ayyFsuQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qgOSnQECfDYXV17vwBvX0tz30iboNzg62aqqDRsKuGI=; b=e6c/hlt6M5IxrvPOPn+fdOhnAy
 i2LJf8/P5Qt3AmR6QTAx33BxgRBpWYsEwRC1+fMrwi07DYg5n0v/MfXgHxkv50tkm/wJBHCuDloyP
 ppWm8e03/wSTVW8sqD9TYKfw0f7mXbhmIa4yBynqrNvb2rtt4tQKI5bM6RTrSya50u6U=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ppgTC-0005Nz-Ax for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Apr 2023 02:25:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F409B64D07;
 Fri, 21 Apr 2023 02:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3561AC433D2;
 Fri, 21 Apr 2023 02:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682043948;
 bh=gv2fcUr9k+SVhnNR60lQ152rJtcbuooIqSiLervPK+U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jxHs3XH9pzIAJ2mAwpNj6y4McYEsggAhz+PNhiDSJ2cvcSm2eKO8HPryRqJbF7xp0
 dR11YyKS1MwkKHT3iuYzLJ00l5sIm9hjR1lHjRx8XiPOjRzfeHf05aqX+QDrl+G9jK
 8KPzzyIsXxxjkbYrRpIEL1ekEPbyUl4RhG/+KuO02o23i4yZEGp9Uv/J/CpOgMpcYr
 VrHKEEs8bz9Har1Bspj6Z5AW6tgHqfSZYocp1yxv+7iwC248yEb0swbfkdA8HQaDWb
 rD2n2eFqloFZFicWmHP8ve92ocHV7sCKhaZUYQgBtvZbvnhHKU2xUR/7qQqSmwriom
 tv5hsCQv0/0dg==
Message-ID: <7735439b-7f9d-3344-8c7a-6d5ad2a6712b@kernel.org>
Date: Fri, 21 Apr 2023 10:25:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20230418174201.3274634-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230418174201.3274634-1-daeho43@gmail.com>
X-Headers-End: 1ppgTC-0005Nz-Ax
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate node blocks for atomic write
 block replacement
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/19 1:42, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When a node block is missing for atomic write block replacement, we need
> to allocate it in advance of the replacement.

Miss a fixes line?

Otherwise it looks good to me.

Thanks,

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/segment.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c35476b3c075..0e1e29800934 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -217,7 +217,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
>   
>   retry:
>   	set_new_dnode(&dn, inode, NULL, NULL, 0);
> -	err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE_RA);
> +	err = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
>   	if (err) {
>   		if (err == -ENOMEM) {
>   			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
