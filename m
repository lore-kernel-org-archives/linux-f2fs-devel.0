Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2365CC3064D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2024 06:11:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sOWjX-0002Fe-Fx;
	Tue, 02 Jul 2024 06:11:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sOWjV-0002FN-SN
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 06:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HD+7urcX1J7z8tC3u0w79km5S1EdGx7iAbOwWxhGOqw=; b=iUwuTnSlJFXqQs9tR+n7jopHY7
 /e5YLmxW8vOOt47PVFxqA3uHtNAmzxGx7cRQn+bKoArTReyrE82FATcaFY2bLqwVf+/wBjP/yoQpE
 aKIwNhMI9YluGD4evWtY8kgQqFEY0Qkek50Vktm8wUAviashf64+oL5Rf/PSY2zDCyYw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HD+7urcX1J7z8tC3u0w79km5S1EdGx7iAbOwWxhGOqw=; b=NR4TgOhJiUETYNTg4Th/KogYx7
 P2VpWJT2vKwF1XVP/sL9dw3mroz+NA1KTCSz7fYNY2RfcQAvD3LvuNW9DutIPber0DxjbRSOOj3IF
 QR1A4DZupf1afiyBIBciNCaU1qepI4A5PPh5eNRDrxpHvi+n/BhOmK3S3fJpCmtYxOGs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sOWjW-0000js-94 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 06:11:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2A9E560AFD;
 Tue,  2 Jul 2024 06:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14185C116B1;
 Tue,  2 Jul 2024 06:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719900666;
 bh=ths+yCbawqhHMCmubkRulWR44EgI5qbOYAwR9HpjZLY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TxXOw9A1OGgruQ1pdAo2ZMq/BJmBppL5fyz9GC98O3Zhexb3ZmzLj3JSOoO20IuzL
 uaJHpXIeq0lfhAcsW4BUl2P/FVbkrIN8uOVCHyd/RJSrh6w46WVUXvxaIxQHYiEFgF
 ZEO9GE5HCiuNiAa4OsIykp8D1kslPMNUtgejnQEcvXC/h9mmJx7AIusZEUIxj2YxCJ
 faxRAq4EK/3SSEOsu9sUvfNoy8UxeimT67B2wiYpdiKm2oXKkTiyGseaApJELrS3lt
 f4lSVxoUP540K7HOvu2VlM9RkFk0LwhDhlaSEoDi+r++dbs9nbmJZMKK2LpCQ6hwt1
 qq7Qsxyo1AjJw==
Message-ID: <2cbb23b5-f870-453a-90d1-8f47280b7e4c@kernel.org>
Date: Tue, 2 Jul 2024 14:11:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20240628013140.2444209-1-shengyong@oppo.com>
 <20240628013140.2444209-7-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240628013140.2444209-7-shengyong@oppo.com>
X-Headers-End: 1sOWjW-0000js-94
Subject: Re: [f2fs-dev] [RFC PATCH v2 06/10] inject.f2fs: add sit injection
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/6/28 9:31, Sheng Yong wrote:
> This patch enables injecting sit entry. print_raw_sit_entry_info() is
> added to show values of the sit entry.
> 
> The meanings of options are:
>   * sit: means sit entry is injected, its argument chooses which sit pack
>          to be injected, where 0 means the current valid sit is choosen
> 	automatically.
>   * blk: is the block address of the sit entry.
> 
> The members could be injected in cp contains:
>   * vblocks: sit entry vblocks
>   * valid_map: sit entry valid_map
>   * mtime: sit entry mtime
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
