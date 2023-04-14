Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59667C77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Apr 2023 01:23:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pn89q-0000s1-Cj;
	Fri, 14 Apr 2023 01:23:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pn89p-0000rv-Pg
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Apr 2023 01:23:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=joYIB0gLJR3ArkUtA1eSbak162tvV7zdsKsTotjWN/M=; b=jl0pTMDU6tlvy2wEjPEO29zA7W
 m96qGO1j+ko93F8X1xPQ/8JGLYibyiUXY0eGkzoR973qPgJx8ZtXNV1fKgQfxqV6o+mKpvizZ35s5
 RrYaImPCc7gdfqJLQPIp+SQM3Xa+4AsI06/ufaskOKstNouLUPAdUUqnwXwEW2RyiwQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=joYIB0gLJR3ArkUtA1eSbak162tvV7zdsKsTotjWN/M=; b=MGE2vUpBETuRhDeQ0uZXo9sGkr
 q+XjwJTUK0fAC+Wz038oID0NZvhrLw2vd7VL1uVe/5y7fC/2hPHHAhmta0RyDbnPdhoUSyxmPo7eG
 xMOBWmwt0Ey2E63hFGj3vq9VrMUQVY183VMXyGoUW5c1IA8N3PI6u9TcIG5Ca2FpeTlM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pn89p-0001RL-Gr for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Apr 2023 01:23:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 047C9642C7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 14 Apr 2023 01:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73474C433EF;
 Fri, 14 Apr 2023 01:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681435395;
 bh=XYBB62Apz0vDm2QneI+v9A6E4O1dcjYUuUjQ4/vo600=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=l3aRwe86tu5oI2Z1JsemzLheunaKdn9qM5xy5gfdwlEXWbvV+eodkqXcPhTn4TAEw
 2qZKxG1CAu2zgEfyC02170XNy5xuDfHpN5FtpiM8BqTDwacvQrhT817DHcP1QOcZ9E
 HbOTrMtYzYtwHy2Wj5SNMIdzk/aaY89O6i08F4agyxqpsmklD0KwcqDulF2USnJe3X
 zGonzrqKb5ou/RO1POp9ZklsRsRz7UH7W6mLJc6liVKFPbVissGa5AgMYdfUzZOFpR
 NTbDhohOMKt5ijEMTr9lmZfdoy3Vm9jrebQe8uzowY93gpPAancTZJ9xokCRgL7lxB
 SVdRQ524Emhig==
Message-ID: <504dcb25-f45d-f189-2743-1152cb944380@kernel.org>
Date: Fri, 14 Apr 2023 09:23:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230407181539.4136580-1-jaegeuk@kernel.org>
 <ZDbZlwH5u3/nOTwL@google.com> <ZDiI2ypb3FECoSK9@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZDiI2ypb3FECoSK9@google.com>
X-Headers-End: 1pn89p-0001RL-Gr
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: relax sanity check if checkpoint is
 corrupted
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

On 2023/4/14 6:57, Jaegeuk Kim wrote:
> 1. extent_cache
>   - let's drop the largest extent_cache
> 2. invalidate_block
>   - don't show the warnings
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Oh, just notice v3.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
