Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F70DECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Sep 2022 02:56:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oVOkr-0008QA-Qw;
	Tue, 06 Sep 2022 02:56:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oVOkr-0008Pw-6q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 02:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iiRC55sNJzy/YPaxeCaL29UhmOmqwxypWu9HKBl939g=; b=YOT9j1MnlQW2DWCioo7WkybUYo
 7WdhxH4zvRtT3vbAbcJkOYvtPKfDfKbLAN2pjeByimpA14jP7qT6YI/c2hDtdcNLXYdKOsEp3ulae
 lXSfilEWDNIs46cMchmsZwEtZ5bBJVNgv9yx9s8MV8VGaaSppsWNN8FiAv9HqHBcIdyk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iiRC55sNJzy/YPaxeCaL29UhmOmqwxypWu9HKBl939g=; b=i5U+K4EqbKn4P3sT6+e42AnhyB
 /V32YmTDvEIdizH7643qFh0LRdf8Mp+xP69W9QHfihWzxZtcRADZVeTZSRiE1NUoL0GjADnNSlHKL
 qDIV70OOYIRZXXI6u30rVMFuIjK5txJUuum8PtVngglfBsEWE/I60rx9XmDkZJi15h48=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oVOko-0006o3-3g for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 02:56:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3E68E61226;
 Tue,  6 Sep 2022 02:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6A4C433D6;
 Tue,  6 Sep 2022 02:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662432950;
 bh=OOVUbiOv01FcO5I8sIOvPc/pmn2ulz+SoXFCsOI5FXE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=t7SC/iLxeTrH30pQARBVgKCJkWk/LaQs5+KEMiNrXs2S3SNCcutvLe5DCqVTajeFt
 mwezGQAoiM8EGolCV9o50xZHmwAQrB0X+9PGKtTRxpd1CDKhdBM1ECYmRHYPmWdqWo
 pw9Q0WoiyWn/rYQzW6GOQYyEHCj6M5D+MMtZaxlHdgYYyxu6rpsnBj/ZozyQ31lmY2
 bp/8GCA7o/uvw/KGBvfDSiAmOZPm7prKncfN6iH+KeMhTi2XUR1iHr4ziuF9kwsZ0z
 Wh2POfNTIyCk8KBYN8qKCPXewGyviuzwvtER3b0n18/KeZTc0D+6mqUNA5am7hfmUX
 GZR3296/gIFZA==
Message-ID: <55bcf918-dca6-6f16-4e78-4772f6a08852@kernel.org>
Date: Tue, 6 Sep 2022 10:55:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Zhang Qilong <zhangqilong3@huawei.com>, jaegeuk@kernel.org
References: <20220831094815.25002-1-zhangqilong3@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220831094815.25002-1-zhangqilong3@huawei.com>
X-Headers-End: 1oVOko-0006o3-3g
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: add static init_idisk_time
 function to reduce the code
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

On 2022/8/31 17:48, Zhang Qilong wrote:
> We can use a inner function to init the disk time
> of f2fs_inode_info for cleaning redundant code.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
