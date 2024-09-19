Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADB2CDD569
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:24:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sr5uh-0007TB-OX;
	Thu, 19 Sep 2024 01:24:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sr5ue-0007SM-UL
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Sep 2024 01:24:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OqsIcDAbQlJHLe1d+xc1/QPkXonMWDsRPZS0vsbFIYc=; b=iRErlhghhgwYdunB/0xIN8RBXW
 RPQxP8OnBH5OWGAQMaBd+BSlC61cNO1s3zTY04bD/cFDOtpMFku+z+Lr0rufmqAq+6tLOLRAOZqiT
 1aEGia4trQhjXDJ2PurZCmZgMGgVeIi3NH4V5WGwzHykgU0CYa5U8BXsd3zXyTR0lJEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OqsIcDAbQlJHLe1d+xc1/QPkXonMWDsRPZS0vsbFIYc=; b=doOKEB+9UviolWpvxJWowg/7bY
 ARW3v4HxK80Es84umZMsxUaNyToJM7NZQGNP/VnXmvTZzn6+aVXfyX3DaSEyjP9w2NqUTt+JmyDrX
 8sI6lHLfWCRB80hXDJ0/QkWZ3OHW4lymEwWdfMlWzzOBVtQlobRxn5TcfIYt7TWuUZ8Y=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sr5ue-0007rJ-9g for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Sep 2024 01:24:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B5BCEA438C3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Sep 2024 01:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D4FC4CEC2;
 Thu, 19 Sep 2024 01:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726709086;
 bh=+u6voD1/zzFOcPueubtBcbM02XGUDB5Pj38L4q1H3pM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=dnWJWiWm9wjBi5YsJ386WEri2g5NIsmEpMM33f4GxHbwlU/7ljRLDciS5l6fFRZiy
 RHWmwQlGlczsHzUb1DHAke0oPJQL2o20ZyytSZIuN0FxVS2AUowlOvBAIjmAM/tPYM
 8dfbhpVDia4RDc1k1O1YwX3h76vvU+Qvq0YpOLV20+EwrGCH7TsWs7+vTZzIEwVOUo
 Fo8KE3+VUXUAPp1f9sirQ2HEf+4z8euJZFpKzoIqv27a31sY6l48k1qrm6X6liFSOS
 Ze+iPtsd4BjeQ4XlbXepzb/GRfYRfp9aCQ9PjaBoHCCUCGk29hQe4i+dewRHpbU7N5
 spAVwqoCkvV9g==
Message-ID: <a7ffb7d2-28e9-4cba-95ee-6a34acff973e@kernel.org>
Date: Thu, 19 Sep 2024 09:24:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240915032251.2300459-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20240915032251.2300459-1-jaegeuk@kernel.org>
X-Headers-End: 1sr5ue-0007rJ-9g
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow F2FS_IPU_NOCACHE for pinned file
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/15 11:22, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This patch allows f2fs to submit bios of in-place writes on pinned file.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
