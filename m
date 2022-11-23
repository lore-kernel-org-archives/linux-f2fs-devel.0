Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2929C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Nov 2022 15:28:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oxrfm-0003Yw-3x;
	Wed, 23 Nov 2022 15:28:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oxrfk-0003Yq-DM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Nov 2022 15:28:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PIosXT3Mcj73TgSjatSNeLao7U5cKSSYOV/rrs4WRnw=; b=mS4fS/BYUJb7JhPhCZWfZ0HSmp
 xxxsY1EWyatAlLwXHXedfAJUz/XR97iECA2Igl3n5HnugdxPLnkSwngopKGGjm09kz6aZB1diDL5L
 CLkjf9mrtbYLQGsASrFvJdBDQGNO4p3fu01b+Q3yo01pYPpsRrxciSMTH1WjYprw3NRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PIosXT3Mcj73TgSjatSNeLao7U5cKSSYOV/rrs4WRnw=; b=Gz3naMFaZMjRrTTqYXLMbCYtIw
 HPDouPhenxjccFirkDXDn4xfZhWwRRSZLZxZGxqk8FLV7qPbJ+cOL9pFUWZlmTV85hDI496CRWRCM
 AZYUu6ScPOH0ZNtdCeS8dgn1CzSEJpQYR4dw642jhr26TkwNVrBQLnBQa1WuXU+A89rQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oxrfj-0004Yd-RN for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Nov 2022 15:28:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 72E3C61D9A;
 Wed, 23 Nov 2022 15:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CE4C433D6;
 Wed, 23 Nov 2022 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669217297;
 bh=dpZG+L8p/ipN5nfLHFuF2VofgalY8nR7bKSYH4b2B6s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fSTHigItWtyddoNS7JhsQ7v0u++z98i24gAbrjmW2LjY6iYd6f/9JzG9PbvvpHstW
 waO116gW1j1Cybdq1WDAPU2wQCJkAdlyPIANUAa6x91RIgfijvzr3Cit32E8E+OXRW
 owmmnFWo8dVAQ3ibZmlNKttGHn7qtICl8WRAv/bzPOV6Ij1q4L3LmgI76qn3Eiue1A
 iB63qBCA8ovz6KQb//+7JFJMMPyMld2eybDLgMwsvZdMAyKqDvLh8h+YsdALvlfMKg
 vRcyyqy1yE17FoJqYqMErC7qz7SWwxQqsqJAcdPKTq42EdGQjGNzF1AbNpkR7rclio
 2rNh/lEiI0a1g==
Message-ID: <088642e5-b0ec-b7fb-81e0-7f64779182b6@kernel.org>
Date: Wed, 23 Nov 2022 23:28:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221116171045.13407-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221116171045.13407-1-frank.li@vivo.com>
X-Headers-End: 1oxrfj-0004Yd-RN
Subject: Re: [f2fs-dev] [PATCH] f2fs: make __queue_discard_cmd() return void
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/17 1:10, Yangtao Li wrote:
> Since __queue_discard_cmd() never returns an error,
> let's make it return void.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
