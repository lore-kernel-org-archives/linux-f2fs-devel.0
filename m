Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C861EC636CD
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Feb 2023 13:32:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pPO4q-0001BJ-Mq;
	Tue, 07 Feb 2023 13:32:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pPO4p-0001B8-Rg
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Feb 2023 13:32:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FqQ/2qUXhmOBA8VO3JOHdXWkDthUTbBm/f/3utl9fRA=; b=ReplY2nraOoyBufnaSdmPIgF4N
 kW++bKcjRmS3Fvmq1yN9UlC7WeMovOmE7mST8abvo34ALb52dGO9lNU/vWTtfSf5sROfAKafE5F0H
 r+Yt20fj7IacAd9722p40Z+ngeHEdUUtR68fcnGx5jBE1rtZ7pW1IhPUAZ1i9RX3uv4Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FqQ/2qUXhmOBA8VO3JOHdXWkDthUTbBm/f/3utl9fRA=; b=l1OqLfUcd892Vm382XFB33xZyK
 ciWZ0SkPPxCE/1uduCHlmt08nuHPyroRSFafZXJbZiE27FzLtYPJ0gchFeAM3ojO54OYVOfX14V9G
 fd9RK26/XfysU10MEnEkf/Iib0xfhpWM4rCWAmQ1c2Ltb9PhHIFM0wqYYSbC5PsjHM60=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pPO4o-00Dfsy-GU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Feb 2023 13:32:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1CA98611AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Feb 2023 13:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1529C433D2;
 Tue,  7 Feb 2023 13:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675776716;
 bh=FqQ/2qUXhmOBA8VO3JOHdXWkDthUTbBm/f/3utl9fRA=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=o5lgGkyzNK8YssNV6PSj5qYn7QIx+HzANIO2+XPcteTsc+WPCbQ6y6vq294rIF6jF
 bp174WmZOnFKMglwP8L6oDj0niVq+UEf3YDsZ1igESW5rewI2C8Si2xLXu3NhWu37x
 aQbOYBJPMdrXFQXuLr2YZ6P/QJAxOFTEcdQKnLXT6Y9vQ9UylNCs5+PHtpVHjarhHf
 /W78Zh3CiEraXg71KC+BsZ/0Ysk4AlBYsNY42u2i6hdgJefppw66Y3uyQluIyryO8Y
 knlqTPr0fptsa/Z8YMfc/6YWnZfXkfambcWPT5Ya3BRRYEF6FtlOEs1m1LsrCKgEw5
 e0bsseigrKK1Q==
Message-ID: <8afeadbc-92cd-945f-4ab5-b6daf099977d@kernel.org>
Date: Tue, 7 Feb 2023 21:31:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20230207024725.260092-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230207024725.260092-1-jaegeuk@kernel.org>
X-Headers-End: 1pPO4o-00Dfsy-GU
Subject: Re: [f2fs-dev] [PATCH] f2fs_io: support AES_256_HCTR2
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/2/7 10:47, Jaegeuk Kim wrote:
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
