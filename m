Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64061C4828D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:31:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rXCBb-0008Pf-1T;
	Tue, 06 Feb 2024 03:31:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rXCBa-0008PT-1U
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Feb 2024 03:31:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vfGjOWJgFa5VpTY7UsXOQZ0WN7CIfuVrnv0cywtMcjA=; b=jYr03syaGZlluEM4JtihtAur6C
 nnx6gyzrS6h9ucugpwbojPfRHsDjKTGFq33dy+Xw0S6K12z4QpeTRqNF7BzPG/9w8C51TstUUyD2H
 Ls/V7gtqmW+GgpqEoKptfaaT7zKdB+ocL28rUOeDhmcWKHtPkaQy5fb4UkOh2ZFyJdMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vfGjOWJgFa5VpTY7UsXOQZ0WN7CIfuVrnv0cywtMcjA=; b=QL5fdxS2MECfHuCpdMbHYaSQf9
 ZxnOMgeRFkZ0R4r0tkx9k7Bc8aIc5PC/u4J7wIsq5I3nAdHfBe3yY3pK+uPlqwr8lU2CJpDDJchZt
 4xsOdFb/G8PMihy68TFg10WmUJdVNZb0hJ5x6d7VfY6iLQSqUmvYi0iQYr9c0IQYCl3Q=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rXCBZ-0005UC-9r for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Feb 2024 03:31:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 949CE60C8C;
 Tue,  6 Feb 2024 03:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7A9C433C7;
 Tue,  6 Feb 2024 03:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707190299;
 bh=TTCc1souszdI/VphcOW6piBBN+Bp5EF81cRzoMEk+Wg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h4Qwj2D3XM0RmyBEitxFaz83fkCt/lhU9PAtx7KXDIAxkXmsPq2NBR/7aDrdvF1or
 G0GXKlhuJZ8ff+a/RiylR/OaYy6Wd90NF4M8RIJD5VAX5ywOsde/UIP/m0X6OwscoI
 GAAt2uXK8hFBw09gqrVa6RHlneixTccB6sD084wR9SIXcnV2DZsiVyYI3fWot02Vmk
 Bg0agbJfQdOmr0VVhnZLpxh9OPEXSCbVqNO66p1e9+HuRYTlWOHrP3NLf+bNAYsSd/
 ojxM+JOUCvOC9AJxkEZ3B0lQzLYynZxErVYBxLydcF8bkW1FakD/OYEdosd/w7Xtcp
 kX2w0ET05akfQ==
Message-ID: <356844e1-0317-4726-8954-24a44f05b343@kernel.org>
Date: Tue, 6 Feb 2024 11:31:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Huang Xiaojia <huangxiaojia2@huawei.com>, jaegeuk@kernel.org
References: <20240201073858.104773-1-huangxiaojia2@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240201073858.104773-1-huangxiaojia2@huawei.com>
X-Headers-End: 1rXCBZ-0005UC-9r
Subject: Re: [f2fs-dev] [Patch-next] f2fs: Use folio in
 f2fs_read_merkle_tree_page
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/2/1 15:38, Huang Xiaojia wrote:
> From: HuangXiaojia <huangxiaojia2@huawei.com>
> 
> Use folio in f2fs_read_merkle_tree_page to reduce folio & page converisons
> from find_get_page_flags and read_mapping_page functions. But the return
> value should be the exact page.
> 
> Signed-off-by: HuangXiaojia <huangxiaojia2@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
