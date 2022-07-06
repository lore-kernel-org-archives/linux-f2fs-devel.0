Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C9C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Jul 2022 14:21:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o95u6-0000Vd-CW; Wed, 06 Jul 2022 14:21:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1o95u5-0000VT-9K
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jul 2022 14:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w9WtmVuzAHOUvJn8tWgX+J0sPT5smwbRmL3G0w/5+4M=; b=ME0DmR0AjnUXH1RCnACEQuMSG/
 gfYq92AIqmkFvxW2r71e7g4TGW1n2ohbcFAUccA+lutS6WO947mHLExafCGZADntRZLhczxbh2nBg
 +L9v7l4ToGE6qdOeekE1vuPvaJP43VK2ZUdOut6e9Yq1FpPRRK34ONtpYL8zx/iJTOEg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w9WtmVuzAHOUvJn8tWgX+J0sPT5smwbRmL3G0w/5+4M=; b=A69sNU2ctwq0aT3qaraF7ifdWo
 XxbNAZCHfDZnWnggM7rbiuGzl5AjeBaaxhRCkk7UwfAqj81VkKm22yVlM1Yoz0Z9J7F6E60+3F2Uy
 yT7LHqi/RKSDQgTNsQyDFovprtU7EWer6701OK5qNTmdantd1LnDxKQEMwE+Xb1765lw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o95u3-008sMH-AI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jul 2022 14:21:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 87BF061E7A;
 Wed,  6 Jul 2022 14:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85DBC3411C;
 Wed,  6 Jul 2022 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657117270;
 bh=BBqleXYQ4a7+Wf4AHDy7c+4UEGJSou8ATB/bmunX1rA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UF6BlsoxCRU5TKLF4xnkYYWEKLfFj3c2cds3rlDoddcl8smCvLtUkRvYSGRL8jlO3
 dnPFuYXv1gsW9f+1MEv5ePP2rGOv1fxpkuLCANbWReBFTJa8mAX2fihls9IZ+ROBD5
 9NZCVuPMttGwlgEnTv9XPK5bK54RbZltrMCkGiAU1Jw8sTEspPH0uC0va7NQjQA48V
 bUI8TOz3Bhg0tJXyf1X1IZdHCHCSEuQ+rv8vHzM25Upd5EYCPfIqi/PhFNeooyNlEH
 PuHFP98BfSFNv6oaAl7/9s0iVHALb3onJ5V06yrcityGJQ5wBc5eynWMo7jQmYvCxa
 0FTdgcqZv8eLw==
Message-ID: <089b4584-2142-c761-27ca-bfb4d75e0f36@kernel.org>
Date: Wed, 6 Jul 2022 22:21:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220621064833.1079383-1-chaoliu719@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220621064833.1079383-1-chaoliu719@gmail.com>
X-Headers-End: 1o95u3-008sMH-AI
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to remove F2FS_COMPR_FL and tag
 F2FS_NOCOMP_FL at the same time
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
Cc: Chao Liu <liuchao@coolpad.com>, linux-kernel@vger.kernel.org,
 Wayne Zhang <zhangwen@coolpad.com>, Yue Hu <huyue2@coolpad.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/21 14:48, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> If the inode has the compress flag, it will fail to use
> 'chattr -c +m' to remove its compress flag and tag no compress flag.
> However, the same command will be successful when executed again,
> as shown below:
> 
>    $ touch foo.txt
>    $ chattr +c foo.txt
>    $ chattr -c +m foo.txt
>    chattr: Invalid argument while setting flags on foo.txt
>    $ chattr -c +m foo.txt
>    $ f2fs_io getflags foo.txt
>    get a flag on foo.txt ret=0, flags=nocompression,inline_data
> 
> Fix this by removing some checks in f2fs_setflags_common()
> that do not affect the original logic. I go through all the
> possible scenarios, and the results are as follows. Bold is
> the only thing that has changed.
> 
> +---------------+-----------+-----------+----------+
> |               |            file flags            |
> + command       +-----------+-----------+----------+
> |               | no flag   | compr     | nocompr  |
> +---------------+-----------+-----------+----------+
> | chattr +c     | compr     | compr     | -EINVAL  |
> | chattr -c     | no flag   | no flag   | nocompr  |
> | chattr +m     | nocompr   | -EINVAL   | nocompr  |
> | chattr -m     | no flag   | compr     | no flag  |
> | chattr +c +m  | -EINVAL   | -EINVAL   | -EINVAL  |
> | chattr +c -m  | compr     | compr     | compr    |
> | chattr -c +m  | nocompr   | *nocompr* | nocompr  |
> | chattr -c -m  | no flag   | no flag   | no flag  |
> +---------------+-----------+-----------+----------+
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Liu <liuchao@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
