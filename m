Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C399CDB465
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Oct 2023 03:10:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qsDzg-00087g-Gz;
	Mon, 16 Oct 2023 03:10:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qsDzf-00087a-Fq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Oct 2023 03:10:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1nK9s4kKTMdfMqe9D/tcFMuTBG1udlyjhwOp//46weU=; b=QXRPrwrp//M1NyyPpFHDSjVK7H
 8RsdavRxleu8LLDzkfhBKz0dkIXo2mdQy5WzgLUio4V2PAN5/WK28yTVFGs1lJ+cb+Wae9hWs+ba7
 cHIzwLOkmp9ArAYZrKdj2Z3waobBBSfb9HslKw0MLEzlU6dtYRi6GEx+KfkWppfx3mwA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1nK9s4kKTMdfMqe9D/tcFMuTBG1udlyjhwOp//46weU=; b=BHES32L9mRaBHjC/9q/ySMWGj3
 NP65iZLt4qS3FBoyeV0KK3WLc+lRoSPlsIYHryp5sgBRARo3yQRyRQb8XBPY3H1FkZzKR+a0tv3lf
 qHCwXbPgKu3ZFyKV5NQznipUkBfYGfZw4iXP0YUXF9kqZqxzZnl8DgYKuZhCZLPNU/xs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qsDzc-00G2qo-GQ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Oct 2023 03:10:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 19F8F60C51;
 Mon, 16 Oct 2023 03:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE584C433C8;
 Mon, 16 Oct 2023 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697425802;
 bh=JghYXrcoMAqHEKfXw+VbbXNee2KQVS0xzE7UpviVuIY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GS2NVBLbadbFKW81qioBYDfgMgbzNuIJxVPx6yx+OffzdT3bQJ0APB1N31mheY8I9
 NPntwkZ2x+gwDzLaAD1JQIfsXOTWpahmsbZ8CT7RusRFqTUw53XXmFkcGEAzvHYe9p
 yznXHRjZtOd5ec1Xwswz+o65IIgK3WcLdAPZ5+dTlBTInZBmKJpBQcnoZmscq0m2EC
 +yjlXibpXDCcRxQx/MK1XxLGx1AvINalw4UCQg3/MOi2gnEu8tNqwH+hn6MOtnVADU
 2LJhn8uUhn4rtONYyGtAgz0FRO8AyTioyQSukYFYgR7OPz7WTnMiDcwWDWosxOPLqQ
 bAKZBxwGeV0Aw==
Message-ID: <b16636bf-38c5-93eb-0dea-7ded14bf241a@kernel.org>
Date: Mon, 16 Oct 2023 11:09:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: KaiLong Wang <wangkailong@jari.cn>, jaegeuk@kernel.org
References: <1712b338.95b.18b27c8a5b6.Coremail.wangkailong@jari.cn>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1712b338.95b.18b27c8a5b6.Coremail.wangkailong@jari.cn>
X-Headers-End: 1qsDzc-00G2qo-GQ
Subject: Re: [f2fs-dev] [PATCH] f2fs: Clean up errors in segment.h
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/10/13 14:45, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: spaces required around that ':' (ctx:VxW)
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
