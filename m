Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57B1D5B854
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Oct 2024 01:09:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5ajt-0004Y9-Hn;
	Tue, 29 Oct 2024 01:09:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t5ajq-0004Y0-Rz
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 01:09:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I20AWxGoSoiSmARo4GZvLrgNo7hhzNI0IkGz0MpjC88=; b=D2/kcvqejuUQKQQ7j2/qUkwJUJ
 FVOTORb2QtTQGAKR9HCTkUog5GL7DNS8GUDCzKkLba1ezX1W1eDfJdg5d4bK38Wkfn6sBk5NMHlRV
 KPZypy0j9drLDxIvS2s6jKgoY53JBIjRE3u1mZe54nxh1SXYYUTLtDcqBvk4sDeEbNeE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I20AWxGoSoiSmARo4GZvLrgNo7hhzNI0IkGz0MpjC88=; b=MlLEuNzEHBjy3JiSogYQTaZ8LN
 RYx3f10xv4AfeKyIDsIxrvqZmn4gM8DG0ig9gkGm+5Wc4gGxFyJffkmZI1Ut9wssP7U6+2gB/w9nL
 FDBKE8OMqTG4ONEB/JTop7jC9CQevPkRwB4CmIQdiRh5CYdZ1zdUAODDbNNAMYPhFaNc=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t5ajq-0004h8-W4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 01:09:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3BE88A40775;
 Tue, 29 Oct 2024 01:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765F4C4CEC3;
 Tue, 29 Oct 2024 01:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730164167;
 bh=Co1WaJga7dR8mWqJppxdhIoIdaLUPCiPfOT5nWs1W2A=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=jXiXPyAyiMmmfv/Q7ctR1c9yggGO/TTKYyvYFQzBNMAndYuBDZbVkvyn3qCCZIBiO
 o8jxrUibOhwe7ErL1cnH23x3y9oPERdqTRG5A55AUh1gc6X9Ry76YUaWrQdDepjM1b
 BwKbGiNoL9qdms+pwjyzgtyTmdWL9ZkjJ7zFjTiME/bRTiLWZJjTvks05Q2J0phI7I
 Jsu/7ge7yVCglEnb25iug59pUGzGI/heoM0qV3sMNuwKjvqAHX+C4xaxjeJqMMki12
 GKlo5mYWGy99sqCmr4jlknU4E4DWxTrO+qOAh2UsGgra6+6J2gQjENss1HBXxOpUe1
 VIokz26QJEghQ==
Message-ID: <a380fc63-a78b-4be2-907a-e466d7757a99@kernel.org>
Date: Tue, 29 Oct 2024 09:09:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20241028200953.2010714-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20241028200953.2010714-1-daeho43@gmail.com>
X-Headers-End: 1t5ajq-0004h8-W4
Subject: Re: [f2fs-dev] [PATCH] f2fs: try to allocate sections from zoned
 area except file pinning
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/29 4:09, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We don't need to allocate blocks sequentially out of the section
> boundary. Instead of that, try to allocate sections from zoned area as
> many as possible, since conventional area should be used for file
> pinning.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
