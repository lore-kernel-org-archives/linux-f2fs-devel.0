Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B328C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/zUWfdhDZff5xlj8vx0p8Uk2EEnHA5+zjM/Laint+bA=; b=jvJNx3LXnrQwsfj6Nc2jTYpYM3
	NsgBqeLhgIusu90pf3CyeatAirf9S2KFC69HRzPIkYMH0oRKlYep1XJC/U7p3UFsRVSKezPkIMNNh
	wuBKeeAHsh4xOImQiavV+X3a2TjE41k4fugcxQeVdumi1vYPCtUo9QAjo8i6b+vxp85k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2JTW-0006bM-0n;
	Fri, 04 Sep 2026 02:16:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2JTU-0006bG-O3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:16:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+uOjma6qbQXyrn/wv3REYNOrxR5VeJUIcYohXLMkdqE=; b=PT1asNaRsFgi629wsqwS2WhNy4
 Ipw5LjHce8UgKl3IQGQ3QUQ9B9adn9rv3W8NfnoBhGYQ7heLp0FXTUxpZO3QKudzRdN2/dNBfG7Ec
 TPkH8yAwsRrfYow7vFdmh0K+mnBwX5de77gCS4iVoH67l8GbeFlCdxmC2StlpPtbZorQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+uOjma6qbQXyrn/wv3REYNOrxR5VeJUIcYohXLMkdqE=; b=DO92MWoKyDiJFqs4JJf24SZcWe
 0cHFfdld10ap9gTcnAxDlWNM+x3JFuQsstp7KL1xLpHve6KQGylAF6xfIxhUN3OFdeKsA2PEr2NPa
 dcIb2gux28xyDT7TEWqdQBP2+MkTEnfOR/aFA+uHHswM95VOiNE8Fyf0H4HPUOPAhIzA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2JTU-0003dX-AY for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:16:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9BF1419B6;
 Fri,  4 Sep 2026 02:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804E61F000E9;
 Fri,  4 Sep 2026 02:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788488170;
 bh=+uOjma6qbQXyrn/wv3REYNOrxR5VeJUIcYohXLMkdqE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=QorHhvvikgtlSaiiHTTFK3bAbSfAlGeOM/+b24us9fnvQNew/NiWWj40lYuTSThdD
 N+Y4s0CAjeLaHGk1ZTFNmUIzZ4GN/IoF0pszooMdBYRCJBZz8dJccZU6nC5wVtbYuq
 4et0Wepe6Vib4FWR8tAjgVIy5FPB90eTZ1FxpeTFjMmh+dwcZoCkLd2xgOXAMiArVZ
 jEQjbSxCHdxZR3gM9fQcFugrcgMzDIuTlYfgNF8pYQyfWF6r4tbeSfcGgFr+z4sNvB
 J2C9XfnD/g3TvuqdZ0GKX5aIPg5Q6HbRme4Rujzhoug/7MkhKztlJJhGKn1h0c+6Gx
 8cVii0hhR+/+g==
Message-ID: <1004a0bc-2321-45dd-aed5-e2d35133cd8f@kernel.org>
Date: Fri, 4 Sep 2026 10:16:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <534c0147c80d739938e90cc9f1c349fc9ae3f6fd.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <534c0147c80d739938e90cc9f1c349fc9ae3f6fd.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2JTU-0003dX-AY
Subject: Re: [f2fs-dev] [PATCH v9 08/11] f2fs: parameterize sector
 conversion macros
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/26 07:56, Kelvin Zhang wrote:
> Sector-to-block and block-to-sector conversion helpers previously
> assumed a fixed sector count per block derived from 4KB pages.
> 
> Parameterize F2FS_LOG_SECTORS_PER_BLOCK, SECTOR_FROM_BLOCK, and
> SECTOR_TO_BLOCK with struct f2fs_sb_info *sbi, using
> sbi->log_sectors_per_block.
> 
> Update all call sites across metadata I/O, data mapping, discard
> operations, and zoned block device reporting.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
