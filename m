Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0522D10F3B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:24:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tCqUt-0004fU-2E;
	Mon, 18 Nov 2024 01:24:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tCqUs-0004fJ-0J
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Nov 2024 01:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iR9R8Z8t/FLJax0zqWuPJVJtZDRTXr3pT2YxS6uJku8=; b=c2Cdxk1aonxSU0/n5V/ThUDiGg
 U6K1EFH6WMmdbsjl7jtaDB/OJt5Hh/kIUWlib8jgZcY2ic46V0OlUm1KIymZ+uquYmuQSBWMPSSTC
 r9akUZLHhcQmytFPCnXUtyVNrJK3WfQbJ4l8yQiNqQdiTC45FrofDFO2oGabClnj+J1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iR9R8Z8t/FLJax0zqWuPJVJtZDRTXr3pT2YxS6uJku8=; b=LEHJasX/T7mPF98U9i5FDGtFMo
 69FD4LTG5rypYzpU2m3OGj1CNAU4wk6Uk8/XMftYEPYApeta4UTLFbO04N5g9YjgZMbrTMeHJ++Qj
 mJ2r7794yAkz+fodWXmnOvNJyKdhoHshBVYGYeHEM+2zf+s/bPoEZp9wtlgbyAgKS09s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tCqUp-00075D-Db for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Nov 2024 01:24:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C4F395C0782;
 Mon, 18 Nov 2024 01:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02390C4CECD;
 Mon, 18 Nov 2024 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731893041;
 bh=n7HW7ffDUaOV4zb7zTAhMB+RX8C9iEP9O0qaQLZbQIM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=t6rgAx+H046q+RaOVZr0JNJaTXidHVIVHvMUd1PRQ1V2tTD1oyQQPQ9Gg0olyV2z6
 TXsugy/WD8R7aCHBtvSe7oKwowFlJsp8IrLKqFysoovDOFiGaLijHprJnOvC15ak+9
 2V9oKVgjj6KhmY/0I2zRUlfeVaJl2+9REQ/WR3n2zhz91uC0N7pROm8ZvRk/07fJXO
 eun8a1gjCZr/NjZP3zJTsDdkGd/NCl2mD4ciPh8bVr5NKIwaFEqoYbvSBbUo50dxTj
 rmFtz8RRBnYcK9NXa21K45fTOAYPSlMM7M6nFmw/9AeYVVfUNSpO+l8AlgnDbwj3IQ
 0Clt6JbdzI4nA==
Message-ID: <065b2dea-0c0a-4961-ac18-2ddd62f0b808@kernel.org>
Date: Mon, 18 Nov 2024 09:23:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Yang <danielyangkang@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20241109013819.5952-1-danielyangkang@gmail.com>
Content-Language: en-US
In-Reply-To: <20241109013819.5952-1-danielyangkang@gmail.com>
X-Headers-End: 1tCqUp-00075D-Db
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: replace deprecated strcpy with
 strscpy
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/11/9 9:38, Daniel Yang wrote:
> strcpy is deprecated. Kernel docs recommend replacing strcpy with
> strscpy. The function strcpy() return value isn't used so there
> shouldn't be an issue replacing with the safer alternative strscpy.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
> V1 -> V2: handle strscpy errors, changed prefix to f2fs
> 
>   fs/f2fs/super.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 87ab5696b..4721a8a8f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5,6 +5,7 @@
>    * Copyright (c) 2012 Samsung Electronics Co., Ltd.
>    *             http://www.samsung.com/
>    */
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/fs.h>
> @@ -1158,7 +1159,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   				break;
>   			}
>   
> -			strcpy(ext[ext_cnt], name);
> +			if (strscpy(ext[ext_cnt], name) == -E2BIG) {
> +				kfree(name);
> +				return -EINVAL;

How about?

ret = strscpy(ext[ext_cnt], name);
if (ret < 0) {
	kfree(name);
	return ret;
}

> +			}
>   			F2FS_OPTION(sbi).compress_ext_cnt++;
>   			kfree(name);
>   			break;
> @@ -1187,7 +1191,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   				break;
>   			}
>   
> -			strcpy(noext[noext_cnt], name);
> +			if (strscpy(noext[noext_cnt], name) == -E2BIG) {
> +				kfree(name);
> +				return -EINVAL;
> +			}

Ditto

Thanks,

>   			F2FS_OPTION(sbi).nocompress_ext_cnt++;
>   			kfree(name);
>   			break;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
