Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE45D58065
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:46:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tFXY9-0001zy-Hd;
	Mon, 25 Nov 2024 11:46:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tFXY7-0001zr-Qz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 Nov 2024 11:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7/tISbkcMkXeMiLSEdCiNQuzmJlx0ODVcMJqz5fd+vQ=; b=BehMiojVQZebsfeFkZNItNtd19
 SAJX29S08OkiJeonapTOPJOdYDbmKaux4Srtyhb766igKbaPfgv53ylZ9O7AxQaAFclJiCdPUhmRg
 Xe1DD459zpz6ke9X0KzKyYKN8u+8wiq+Ou4/V3BvKEli5yfSx1bNdZ/5uJRl8jXJ2Sys=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7/tISbkcMkXeMiLSEdCiNQuzmJlx0ODVcMJqz5fd+vQ=; b=X/yRaC1W+nyB7dai4qQ0ZQ9gHL
 TQ7VQYmNdyuCeNzyyw3Vqawxwr8sXr30+EdyYnE1EuAzQ1eY31pG3GlfEBxNZuSewHXF78qYRY4n5
 xm7uoxni4Bf3IdqW2lx6lZ8lpM+gteXbhW/YWQxojJ6x03wlsBXeORh0cJrx0+fbGGo4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tFXY7-0008E4-7I for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 Nov 2024 11:46:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 40A375C567A;
 Mon, 25 Nov 2024 11:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2F6C4CED3;
 Mon, 25 Nov 2024 11:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732535193;
 bh=Tk6h2PZrGSpLKVSnZmQX1n/YqM0ASxrjRifzcEgt0lY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=CiQdaxA9437qxVa/g2Hxioe4PNkYvaCie+eycWptkeEEzXcbqqAigkTvqlhAOojdp
 nZaSSjLHMN+/Lh3jEmnWJALGZwOYP5zTa8hR8cAA1I7XvM3ezUjcPa+rfahGDysomM
 L/yXwftk+I9BDu2nN6So6f1yUFgi/9B8X3Jp1WnwHsGYklRfqzsBISN6ttFN3JVufY
 2H3TMe+5fZNC6T82Dvw0z1qjuDaxi/WsTDdR5cqodeoht+FGkCPKYpTAGIyjwoeMJP
 v9JMuN/qeo+b+z1cECIjCiehdPhbknW5Zp6R6DMW+1fIt1iw2vSfb7DMNhEru5rj14
 k+U87AF8F7SgQ==
Message-ID: <28f47612-e6b4-4051-8013-8ff8f8231c58@kernel.org>
Date: Mon, 25 Nov 2024 19:46:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zangyangyang1 <zangyangyang1@xiaomi.com>
References: <20241122105822.3910235-1-zangyangyang1@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20241122105822.3910235-1-zangyangyang1@xiaomi.com>
X-Headers-End: 1tFXY7-0008E4-7I
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: cache more dentry pages
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/11/22 18:58, zangyangyang1 wrote:
> While traversing dir entries in dentry page, it's better to refresh current
> accessed page in lru list by using FGP_ACCESSED flag, otherwise, such page
> may has less chance to survive during memory reclaim, result in causing
> additional IO when revisiting dentry page.
> 
> Signed-off-by: zangyangyang1 <zangyangyang1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
