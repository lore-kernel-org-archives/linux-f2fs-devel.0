Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BC3C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Nov 2022 07:11:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ouTcd-0004Bx-Gi;
	Mon, 14 Nov 2022 07:11:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ouTcb-0004Bn-SJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Nov 2022 07:11:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XztEMEhkmyYtd2rm6UCOfQTBNgMcf6E9e8X8WQ9JVn4=; b=CfowCeo3sfKnIQWn16K5Ym3Fv6
 iSkffPpd3uIKomAD3ZfizMVZSY73WtLBaJY3QuRhUCTAzxjGSH/8aunYcLZ8roUqUJukS62O+ux1J
 gpWHufwf+tcDGs5Wbm6Rfl5ttNOv6CSPvGy5Rw7ZyhJXlxLwv2emf0hwVRA2RNFua6e8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XztEMEhkmyYtd2rm6UCOfQTBNgMcf6E9e8X8WQ9JVn4=; b=YshgtBO51GoEUJdGdAZkBUyIzT
 ZacCv+uZWnbMIwZCF8htRGa985GiZQvr6QZhKNHIHBlLaDTeKBo0IY+yjPE5tcBZ6vyolQhbkdMhN
 8qHQ9Y7jU7NVEVckHyWmxOsBq5ZpZrU3fHvrcB7zMc8aXUL1X/2tHl4t8YUZVgOU6CoE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ouTcb-0005bX-6M for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Nov 2022 07:11:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5646660ECB;
 Mon, 14 Nov 2022 07:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D82C433C1;
 Mon, 14 Nov 2022 07:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668409860;
 bh=XztEMEhkmyYtd2rm6UCOfQTBNgMcf6E9e8X8WQ9JVn4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PtqYy1XqnQtQD9S/7O1Vb2UNo1yiyiyEKNvozjaeF/tTePlO9axeB/y6ihVp/Xl7h
 LMS0UWk8FmpQLxOYRy88gap855cttfj1+lQzYYcyKFDUMYKg9ABUEoVgqO+WLGtnVd
 4+5+blLZOIfo7EYvHrwfxBZFR8ph2t/MRhgjoBqL9kmzZDWoOt4SDJe2X1OKkfF0NA
 YYu6EW0I6BDLpnyawAWRQKXsxGBqlz0C9ZSbnuDkg4Pc010BGMFNLRSi7DI7bhCFbN
 zmT5HTzAYqh/QOhxUejzGEVKZi0Dj2a9o3ZxFL0RzQuUSVQwc7ybZyuI4xtxQeYaCl
 WoWsl4NXjdrGw==
Message-ID: <6d3f9c36-74ad-9f3b-7f59-2c5b3a01a0cb@kernel.org>
Date: Mon, 14 Nov 2022 15:10:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20221110140723.92752-1-shengyong@oppo.com>
 <20221110140723.92752-2-shengyong@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221110140723.92752-2-shengyong@oppo.com>
X-Headers-End: 1ouTcb-0005bX-6M
Subject: Re: [f2fs-dev] [PATCH 2/4] fsck.f2fs: add parentheses for SB_MASK
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

On 2022/11/10 22:07, Sheng Yong wrote:
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
