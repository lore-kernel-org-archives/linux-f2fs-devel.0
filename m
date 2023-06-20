Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE06EEB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jun 2023 09:20:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qBXX9-00077i-JS;
	Tue, 20 Jun 2023 09:20:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qBXX2-00077a-Rn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jun 2023 09:20:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2EchD/ucMEmeorW2gWrxA7i4UAhQENjCTRPXx+C8zLY=; b=Qi3crn/OlLkmYyhggofoFg6ZXr
 pS7QfcCivefBXzMLQdeTJ29y8IpOkaew/18vrB2h4irwm3oFBPUJIL8d3+LFnIwL3qTMR3XFv95me
 0kcZJSXqKU6EFDYIsQB+bQnoh0KwrmPXcLffrHWkCbg1CbqRBXEyz4CFAuVKeeuWJOV4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2EchD/ucMEmeorW2gWrxA7i4UAhQENjCTRPXx+C8zLY=; b=M3zkad+tvkaLZ4JqlTWb1azK63
 NHRDFKR39IxvAawLQ350NkJUvl9b41Jz3FkqPfi7S1wdSmdgGtlUJvJeCHh35/i3EJdM7wOeFVwJo
 jU2PFHZiPaMl4hpoYcQuQ6oI+dpPcSKlSKLlRfaVr8uywH5lXLgW2O0C35SCUfpUb0xg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qBXX2-00043A-CD for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jun 2023 09:20:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 01B8660F8F;
 Tue, 20 Jun 2023 09:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B91C433C0;
 Tue, 20 Jun 2023 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687252806;
 bh=XVX4CCnLdVg7zSRDRhJD0ERZfLbPES+c03e6Dc9ccew=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ABp2kW72kpi04XgYlwADXbnIlzXILtkjyW1gC0kB38gfhMgpnNy1rexazJVndEz+o
 GpAh8gTDR3DF7UL+4Nz4HFIbe+uwr24PZEeZslUc4rdsJzEkkzecxrnwACRHu25qHy
 QfvofI9kATF2z/+xrhdV1FPK954ucw6fNLlKWwnYRUnEZWKrJIYpudgDLOf+XUOnLd
 kyvdzoM0iNuSRswU9T8+vacyupbKhoPRd9A9JL2bNo/N5GV+5H+Cc5eTejSPQbeg32
 RATmh9jueNs64Mscq2SW6kxTaKP4WQZbpVZWJVtdSWA9IovNQkGMQxJBnIrw1DDFYg
 HVG9kZYUAwW/A==
Message-ID: <a6b7bd99-cd2c-69ef-a021-29a4baf7569d@kernel.org>
Date: Tue, 20 Jun 2023 17:20:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To: Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
References: <20230619151353.2168306-1-heyunlei@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230619151353.2168306-1-heyunlei@oppo.com>
X-Headers-End: 1qBXX2-00043A-CD
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unneeded page uptodate check/set
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

On 2023/6/19 23:13, Yunlei He wrote:
> This patch remove unneeded page uptodate check/set in
> f2fs_vm_page_mkwrite, which already done in set_page_dirty.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
