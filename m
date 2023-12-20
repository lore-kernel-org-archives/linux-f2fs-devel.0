Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEF3C41535
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Dec 2023 02:33:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rFmOg-0000sX-5W;
	Wed, 20 Dec 2023 02:33:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rFmOe-0000sQ-M8
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Dec 2023 02:33:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=utCi5DitX5DLq0RkU1ywOaMO4l+gPlfuDMiaVAZoVjI=; b=QTqKtM44nBeMRvsoWQ4c+dPogC
 3tZswDEC3s34zPXCmAiey4ogQFwqb2a9Dn66Q3u5+q9vEsI6fTXtFS7h2a8rTh48IrUzsfN5rT9sc
 zRAcIJsPmQ7856/ZHNk3Tvq6jdeDz4UtAWfBDk7zqLGgo62Wp6lKIoz9grW3rN6frmSM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=utCi5DitX5DLq0RkU1ywOaMO4l+gPlfuDMiaVAZoVjI=; b=faohred6x2yOshFsMHB5UQow0Q
 oifga9V8fW4PcGiFdDdxkz6KWBMr+Ucn6utA3w8OFnwpI5Xxth13nyOg8ENqKBNOEKhmkdBOiodwF
 9/85eHOVH9s2Uec1ngWIxT8zc77mdRoy8umYi3tW5rr0zByRCGcAMbe69bZ0pUR/Ir+c=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rFmOb-0003rg-LT for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Dec 2023 02:33:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 69729CE1AE6;
 Wed, 20 Dec 2023 02:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19339C433C7;
 Wed, 20 Dec 2023 02:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703039580;
 bh=zfpztoMv6/VhejjLxbkUyaNcYXca4laObErPcQBcelQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tNtk0TkFrmHXegPbcA8EVWRSe5OdJsSbGNnHbWj2KhOXEpCJKbdyHQSBq9o2cK+w7
 M5WfNMAMRThyPDdXbz7sd7CdqZIJ8vjhDhKCgfdglGzJt4Mit/+9OFUoFIw2DdfHBJ
 0AMWsXpjIRXzaHhNMCln1kHp4xemGcQtq0YAh6NUH3/YXL64Ow/BpZ3sar7cwhDdTz
 2cmcxUOfvT8UhvCp8SuyutEeWSS71L8ABnBx7U4RUnnW8Yz/2L+KRJsiPbbKRAu03l
 fxoJsZR8YunK6lpymedfrbev42Vx17Tv3S9rBYRqeih4D4iwteTvO/0Rg5/Lkl/nqS
 G1Oe2YoW+Cpjw==
Message-ID: <158f7fcb-e600-4bca-85b0-dcfd95366f18@kernel.org>
Date: Wed, 20 Dec 2023 10:32:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1703037598-4359-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1703037598-4359-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1rFmOb-0003rg-LT
Subject: Re: [f2fs-dev] [PATCH V5] f2fs: show more discard status by sysfs
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
Cc: ke.wang@unisoc.com, niuzhiguo84@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/12/20 9:59, Zhiguo Niu wrote:
> The current pending_discard attr just only shows the discard_cmd_cnt
> information. More discard status can be shown so that we can check
> them through sysfs when needed.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
