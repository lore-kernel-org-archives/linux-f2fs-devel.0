Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9B9C7EE43
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Jun 2023 01:48:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q8t9O-0003c8-K5;
	Tue, 13 Jun 2023 01:48:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q8t9N-0003c2-Da
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jun 2023 01:48:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EKQf9AUcQkPpeKpp8S2CTMWBdQam6LzX/JCZk9FnDZk=; b=PzQWaClIH5vw2jxui9jZ6pqwb5
 7pt1T13g0j1daklqDxXEo7vF9VTMxos1oiI2LbWXqKo6uyPRG8wkFY+o59YRPuWhfHRJVkLkl4Zap
 2awaIVjEZfFGPhh5iWlZeNeFKPCIWHwU5uQ/47pa5FJjtSbYHtyX+LOjsGINZbcJr45Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EKQf9AUcQkPpeKpp8S2CTMWBdQam6LzX/JCZk9FnDZk=; b=XB/xzL52w9dsTw4rNlR+eDKlqh
 o4bvTg5ufzY77RPjV5xDexc3nxqeOlCgSRHFMvMISLwHxkWgS95hYo6IRWCFEOUVi9Edx9N6ubKQV
 QLy7b1YMr8SDhjYpC/VjVpruxukmN2DmRT6gS5rWUj48J4goEyTPSXPFxyd3no+absNo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q8t9H-0008D9-Lt for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jun 2023 01:48:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4473361EE3;
 Tue, 13 Jun 2023 01:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC5BC433EF;
 Tue, 13 Jun 2023 01:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686620917;
 bh=EKQf9AUcQkPpeKpp8S2CTMWBdQam6LzX/JCZk9FnDZk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KiV3xtRZV0GXj6BNuY4NmZT1iAHoKUDUnds4QJ9EBrd8SJKxe8suc3kBx+SCAkaU8
 WZRm1tCZe5p9yALQvBObgaSkTwf+rq1kSEfO/KNzp9Z8xxDDTSf6d44jJVczRZtouU
 fIClli0cXVb3z91YnrBHbfRtkUfw10BI+tH9R1J9ztk7pXHNqrJfrvCOL7y4QActvF
 H61o1F3cU9f/9oRVgELIqFkCDVtfzPCzTA6I7FXQ2y7xWY+wN5ZPfWXeAbWlEX6q6J
 jaM8mmdWLmPvpEIUJB4p/4K/Fmt9jmuyIa2ks/sYtI+v2H5mqsoN+QUPpQhxbbMGCl
 sUaZBnXT3/Ocw==
Message-ID: <45faec38-aeaf-d89e-4542-e87e5edc049a@kernel.org>
Date: Tue, 13 Jun 2023 09:48:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20230612030121.2393541-1-shengyong@oppo.com>
 <20230612030121.2393541-3-shengyong@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230612030121.2393541-3-shengyong@oppo.com>
X-Headers-End: 1q8t9H-0008D9-Lt
Subject: Re: [f2fs-dev] [PATCH v4 2/6] f2fs: cleanup MIN_INLINE_XATTR_SIZE
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
Cc: ebiggers@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/12 11:01, Sheng Yong wrote:
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
