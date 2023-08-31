Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF55C83F2E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Aug 2023 07:58:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qbcZW-0005cu-T5;
	Thu, 31 Aug 2023 07:58:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qbcZV-0005co-Aw
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Aug 2023 07:58:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s+yVqRftq5mcpb0vm7T4bpUyBcRBElBdtF+7vtaB2R0=; b=KSzdYQ67We3YCs00dzvS1DRNGA
 YATtWQPn6KmDdt2qACm1qm8SgdeoVuGjvx1PmAjlN8PUNH6RuM2OKhYilbr3q2UXcDFcswIaNJWBh
 4YNQmZdMMUoNC58QNiXkXH7mYMyEBcqnPEIDrRPQVqwax0TnaCcQZoTEZuLGd1auc0XU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s+yVqRftq5mcpb0vm7T4bpUyBcRBElBdtF+7vtaB2R0=; b=GWDLBy+sSphABgOGFm5fpveiYO
 OWNL3K9wTfIwgUeJIEi/X7B0cQa/Gcakn/lmQnmNTv4h9Ga8ADbdFNvZOCmDQSn9OipJ14RYe7lvI
 qA4ZYaCa6G1jfmp6+K3V3prTWDctQEVxRQ8ec00bf+0lDiGQ7GZITKjPhw1o8Nt6RiCI=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qbcZU-0003KL-Bu for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Aug 2023 07:58:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 05FEAB81ECB;
 Thu, 31 Aug 2023 07:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFA1C433C7;
 Thu, 31 Aug 2023 07:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693467786;
 bh=BiW6SCPsbmHQn0N2ZmOnGlYYAWSNtJsTvfUzgHyGmAQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=L4wryyGBEET1xwVkkxKP1qganm8MxUNQ4G381fSbTDx9Sf2gGmnvtGkDGXpeIuzQA
 EFe9aqJMI97u/njMGAqMKClQBR7xq92PTquQt5yjAwoblSVI9RD+PdJRH1huYXaI5q
 yvJDmxNgCTxAKYg5w++WTfUY0DCm8XLWt7cIbBAc/SKBM7c+y1HvtDqCUj8GtG8iyE
 mCyWPw9QYNBPl5Ahy3inmzM/kLQW2ZUkZZHgVBTfB2gpnHtBRdC9OwaiDLO98xVPX/
 zIA6lAcjah4WcsRUxL5+/RuWqY8Ni+uWZ5g2xSzyTkjenKB1nrpuGU4jdAPsQZYXFb
 mNHqJl7cNCy0g==
Message-ID: <f3302afa-02cd-25cb-2d68-495e4f363064@kernel.org>
Date: Thu, 31 Aug 2023 15:43:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To: Chunhai Guo <guochunhai@vivo.com>
References: <20230831071011.56116-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230831071011.56116-1-guochunhai@vivo.com>
X-Headers-End: 1qbcZU-0003KL-Bu
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: replace blk_finish_plug() with
 blk_flush_plug()
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/8/31 15:10, Chunhai Guo wrote:
> The commit 344150999b7f ("f2fs: fix to avoid potential deadlock") only
> requires unplugging current->plug. Using blk_finish_plug() is unnecessary
> as it sets current->plug as NULL and prevents wb_writeback() from using
> plug in subsequent loops. Instead, use blk_flush_plug() as a replacement.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
