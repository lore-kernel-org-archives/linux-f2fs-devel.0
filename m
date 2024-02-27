Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E864EC5478C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Feb 2024 06:20:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1reqop-0006K6-7M;
	Tue, 27 Feb 2024 06:20:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1reqoo-0006Jz-2a
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Feb 2024 06:19:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5/73q7JSn5TuOZGOwp4vUKEuDDJpsMMqVIt3elY/VG4=; b=MHfwky3WwRCy9iASTec+xXAl+o
 Nir9gwSn0xRwfXWSzy+4F8/0muuT/cvV+FIo/3TMYrZVfkCxk+HJTNkvdsiob4KjoiUMDxvGpLJFQ
 fKNoAtkSMwOps0rWmXeaH/IjcYSZAPpXkg6C7UYXhepGxOQc63O2GHy0Yxridl95OcwQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5/73q7JSn5TuOZGOwp4vUKEuDDJpsMMqVIt3elY/VG4=; b=abdrZGR/vibHBCp6RzjeSp5vBZ
 YXc0Fesln3wOCzscETWRDDw+FU0GQE3rThXA4USRxR/58tYAgG/HmXGRPnR9of6XuC2+SOqgcXWTZ
 8+sTwRvgV7t88kmUZQXbs2JYBBgPGCL1jg2IBK9wMkirWhfgbICEvKZ0CAIveb/vO8nM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1reqoo-0004Eh-F5 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Feb 2024 06:19:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0E5566148D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Feb 2024 06:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01686C433F1;
 Tue, 27 Feb 2024 06:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709014787;
 bh=EwDCQ660IpA6YZkoSyNmnTjB1NTc/EFAo+lbeKBp8hA=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=dljjroxCDLMbSCR9zceHBVLK/8jz2DfVbPmqSEqoG5saZIwiZESJaNsMhkikhpHG9
 eZmqkFAftlHg24opTAky8iOGGLaJBsJgodE1hchheYrj6R/FqB2N1upCq7t/4kXiL4
 W5sxzC42Inmp7JX5uya94EKK1UEosDNSI0j/sD9hl/Z8tlsnQ/LfvsUgC/f6ilOOD7
 Deu8ar9JJxGAXjr1f9xJt9KkXxWCEHyaX6Tf3XETpSV1Byy3R5LMiXSDOJFxHskNpN
 zD57hSDJtcW6KpIvIh441+iwnRuV+jWNf5bbl9ho5MKIgdsLwNMOsh17ZttEBHsC6r
 p5relFewyNLtQ==
Message-ID: <61420716-72a0-4002-86cd-04beea52c89c@kernel.org>
Date: Tue, 27 Feb 2024 14:19:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-2-jaegeuk@kernel.org> <Zd00DE6mXbt509sX@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zd00DE6mXbt509sX@google.com>
X-Headers-End: 1reqoo-0004Eh-F5
Subject: Re: [f2fs-dev] [PATCH 2/5 v2] f2fs: fix write pointers all the time
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

On 2024/2/27 8:59, Jaegeuk Kim wrote:
> Even if the roll forward recovery stopped due to any error, we have to fix
> the write pointers in order to mount the disk from the previous checkpoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
