Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (unknown [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36243C6FD1C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Mar 2023 14:31:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfLyn-00074m-1D;
	Thu, 23 Mar 2023 14:31:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pfLyl-00074f-8h
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 14:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lMMvq5TIJk5uvnf3xO4BsB9NNYLBhtiWzGbTSaGH21g=; b=MSPo/Tg+HU3wgv69FN0giwEcHp
 hrbtldwAY7ZCAggTMbCfuhIF63N6vrjPwpjl01kckQChmZXqYoA1NFj64BVHiGQAUf+WflAi73LPm
 06/tjMPNgMXx6ZvhTjm1UfwVeitsHc9YzLUsM9BIFKV6anes0wc0k9gzWV+/bVihxwuE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lMMvq5TIJk5uvnf3xO4BsB9NNYLBhtiWzGbTSaGH21g=; b=MnH3VzPoxl2Bjpnf0bx27RPrCP
 whb2jB0HMMhNV+654zx7p8UfeJMDL68FbPASTycZEEQhf3ri10BK1WJdEK4RQObwNtGOzXlBoPIVv
 oIJtAekdnN5Lt3BZ+MKz0X4yN4s1XVGC5xwvb9XAN30l45wsh8kclgsUci8G/6DLLjZQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfLym-000Hy4-N8 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 14:31:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4F344626D1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Mar 2023 14:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E407AC433EF;
 Thu, 23 Mar 2023 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679581898;
 bh=Sv3YybIQKDgWMcn1KW6KjvbVZBTE9wL1diTv47fKkqs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gFywPhWzMoKqSKt+w9EW24FI9Ut3lF7kvBz/A9Q7RSqioTBgu8qyebBsk9D5c7lCw
 8mYHdZ32zH6q13p7SUs9vQkPM3J1iRx9GWhaRIBq+FEIJJq/I5mwBTrecnPvggwGDH
 /juttkIXqnaCkT9yvwQtGtD10qz3k6cfXxggcnM/yiBd9SbEy8IF87yWBHh/j8Tft8
 ZCink1m69aeWohxXaDL1ByWTb+ri8aY5Su/odbyVs1FQqc+RDOgUTqYsvk0BgQs/k3
 d0h2Tf3fdIZzFnxK+146+01Vg3/Le3YZRtllkEWH5CVTwVxZILEj6I+jrikAiQz9Ye
 lA3M32DfTDhWQ==
Message-ID: <dabe799f-001d-6514-f18f-16466c11653d@kernel.org>
Date: Thu, 23 Mar 2023 22:31:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230313201216.924234-1-jaegeuk@kernel.org>
 <20230313201216.924234-3-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230313201216.924234-3-jaegeuk@kernel.org>
X-Headers-End: 1pfLym-000Hy4-N8
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: factor out discard_cmd usage from
 general rb_tree use
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
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/14 4:12, Jaegeuk Kim wrote:
> This is a second part to remove the mixed use of rb_tree in discard_cmd from
> extent_cache.
> 
> This should also fix arm32 memory alignment issue caused by shared rb_entry.
> 
> [struct discard_cmd]               [struct rb_entry]
> [0] struct rb_node rb_node;        [0] struct rb_node rb_node;
>    union {                              union {
>      struct {                             struct {
> [16]  block_t lstart;              [12]    unsigned int ofs;
>        block_t len;                         unsigned int len;
>                                           };
>                                           unsigned long long key;
>                                         } __packed;
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 004b68621897 ("f2fs: use rb-tree to track pending discard commands")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
