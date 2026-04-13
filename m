Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86ABF3ED7E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7JC5QVGbOfHtiMq7BzQXTLwkNxkbYqkOsK4TxjMFJ3g=; b=KC6V5Mj67BY8Jb4wwweVl04+sl
	noWpbCb1izMegjI32ji3+muKG6Yr26TDH+I/gdz/a3YqSASn5iMN7AEd3ePTrcjpHyD4Lu85ZHK/N
	caGRvJwYtaOBzLGiPKHHlsLV1APWdXOQSNrEN2cR1Q5xx9d+pusAQMq0sH7nY1opMV38=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCFcb-0007ot-RK;
	Mon, 13 Apr 2026 11:38:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wCFca-0007le-FG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 11:38:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=044jQMVorszyFmJ/Ftcj7sx+yKymfNCyCtG3aBYGV5o=; b=mRyESmTR3uRgFVR0Odjr9Z7t8H
 cWT38wQb6tLS8G7qDjLtnDf23rfZgVjHtrbydKOi66UsPn4k1MPe4lYcnM01jmrQ8hP7hlAaMVd9U
 wRPXAKWnDbcD8sS/z7R53UQ/C75azvXf+G7SrDXa0MwoNqpN389LGOZh5ANQyODzpACA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=044jQMVorszyFmJ/Ftcj7sx+yKymfNCyCtG3aBYGV5o=; b=MAGBEBnf474CiwHTap5JJCkvRx
 fjWH8GoMrZgSxWBLHlYaODuWlb9ZoOV6IX2S3SRqKAylWSlFGHj+pZHIKGTiepEq+uO87ypEVks/x
 5FK9iTixCb0xy6lwkp/MQELDMDItRogkrhQJChCPOxQvckO5B59FcarGhcfMdDHJsxCk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCFca-000428-3a for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 11:38:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DE254017E;
 Mon, 13 Apr 2026 11:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4112AC116C6;
 Mon, 13 Apr 2026 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776080297;
 bh=jB7FRDPHSkphE4Zs6YpqIM9woNsbFEbM9sj7YGjDevk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=j4P8Iu3tDTmbC0HelTqYCVo7vFZJgkmd/M2wjCsjDDFjl8r3xpE60Hm+tTP130ZM3
 +fnJzdGZJMw65akNtcurTUtBHOSAbDoERdPGx63GJQUmCzGrx/ghNex0TLEqS2qwXF
 QRL+KQwC9uQjjHvmTQ/vyrNnsD44S8dzIz3ZkxAncTtADLz75Ky8blBufI3VZk8Emp
 zImA7d1F58c7nRkSMGkXJ8yhKgaEOJgWssivTLSU8wXDJ5CJ+0VkbBB/gTZNcs8jrN
 pM5ExA5V9Lxx4DXCcpyYa0Lcqmhztxvr4XPLdkhSd18LhB3zYXlX79q8Nv9V8xVp+w
 znGa3PUU64vsw==
Message-ID: <ac3b7022-a81f-432f-b841-aa2afea414e5@kernel.org>
Date: Mon, 13 Apr 2026 19:38:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guangshuo Li <lgs201920130244@gmail.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20260410124726.2035729-1-lgs201920130244@gmail.com>
Content-Language: en-US
In-Reply-To: <20260410124726.2035729-1-lgs201920130244@gmail.com>
X-Headers-End: 1wCFca-000428-3a
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix uninitialized kobject put in
 f2fs_init_sysfs()
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
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/10/2026 8:47 PM, Guangshuo Li wrote:
> In f2fs_init_sysfs(), all failure paths after kset_register() jump to
> put_kobject, which unconditionally releases both f2fs_tune and
> f2fs_feat.
> 
> If kobject_init_and_add(&f2fs_feat, ...) fails, f2fs_tune has not been
> initialized yet, so calling kobject_put(&f2fs_tune) is invalid.
> 
> Fix this by splitting the unwind path so each error path only releases
> objects that were successfully initialized.
> 
> Fixes: a907f3a68ee26ba4 ("f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
