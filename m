Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C11C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Apr 2022 06:33:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nfyT7-0001JL-I7; Sun, 17 Apr 2022 06:33:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nfyT5-0001JF-QH
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Apr 2022 06:33:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sT7S3vnN8MYEs2liUzisGREDQcHoQ+A2YFzXpgXZGf0=; b=Xp4qeEMtAdL5P4lGHP99frSAzV
 m2cZBVcO8iBkq5E6tTw1nQ990NeMINy3Hl9usP3rCLMo/TALhcdDTuRb/oNLOfKxJUpH/9BaQLQHC
 UJtPmU3AVw/GhYHRO3UeI4rZLxf7V1g4LIGQIq9J1axlj0ZafR6qO3pEPaGG0bEturNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sT7S3vnN8MYEs2liUzisGREDQcHoQ+A2YFzXpgXZGf0=; b=edfJHcOfPmgCXEbPGofHVBkwJx
 6QQvfAQOgscYZp203KtAToLtAQvd7+GtQcABzbRj01NO32cqEKKspChSp3UdzwS7IItwL87Dn7vQC
 ZNJEa9zXJpnT36motwIMVcrlgqnJcDePe2yzjwfhWz+9rq/IL9UROUiDGpdTdXBzov0Q=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nfyT2-00044H-UO
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Apr 2022 06:33:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C531B6103F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 17 Apr 2022 06:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB91C385A7;
 Sun, 17 Apr 2022 06:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650177176;
 bh=il3gPx/oYqYy8snasqd2G+n5oON9hLbfVENXrGUtHFU=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=kpa6ViPSZjyTyZf6S1pWEaQ43NI/C7+4nt82QA+TvgtS9NqlJPD/h+ucmR44L6I0S
 KQQPEblvkKG5Jo7ww+rc6GMFv6kjw3SjPS2Wx1/nUaIkQkQFotilelNpqLaf+gyRCW
 2vXF/t1JdMH9iduGyvIQoqxyyEdyJK7EyDMnvCp2feIATsnmup51iyMMRBlvYVm8vc
 O/oOfsN0y0NxAi/TEWVTilocw+8g1NT2zqEHCjiFABRe2ai2GFCewZIkqydu8ufeaw
 MxERqmvMZj17LYAMimEDuTYSs7Z5lrKIzAsKuaQNW1VDzuJ4yRSdapsqEypuGBlcvY
 MafznwVeCNKew==
Message-ID: <ad5aae57-42d6-e2f2-66ee-14178384cde3@kernel.org>
Date: Sun, 17 Apr 2022 14:32:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220413154920.2024872-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220413154920.2024872-1-jaegeuk@kernel.org>
X-Headers-End: 1nfyT2-00044H-UO
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove obsolete whint_mode
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

On 2022/4/13 23:49, Jaegeuk Kim wrote:
> This patch removes obsolete whint_mode.
> 
> Fixes: commit 41d36a9f3e53 ("fs: remove kiocb.ki_hint")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
