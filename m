Return-Path: <SRS0=Klf2=NC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D30FC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 02:09:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C502860184;
	Wed, 11 Aug 2021 02:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C502860184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mDdfy-0004tO-DJ; Wed, 11 Aug 2021 02:09:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mDdfx-0004t2-DN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 02:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AB/n7+AUg4GRqT4ky1cfIDXdiDFzRgmE3Lb0w5QBOUI=; b=OpWjfPxC6ANTOfMbNren+xaeAm
 54lbyNYBq/Ee+6hVdZeL2bsoKCBTFpV7kISYDxn0V8nUpfTisJVoE2cfw08puqX6l7pZ+ATCS7TUM
 6YxeojFkNZDD+48HHfpDzf/ls/4esR9brUVmG+KC0m+PbvVJLYwVEmLOo3R7RxGOsGhs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AB/n7+AUg4GRqT4ky1cfIDXdiDFzRgmE3Lb0w5QBOUI=; b=NrCOIiHKWIvhC9rj3qEengjYUH
 nUK9+HN5coDCjQhRU7NkvIzoA/Yo6o2UolQn9iGsuYfG90zP3tw5zRDtTV43vlW8Z5KiHAvv4faxd
 /+KCbfK/iq7wstAMNlc2QL3X9RUS/k3yHH0pA8GD0ZjOXkqAJbmLIP93WFWoSrbygwoQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mDdfw-0007uW-AB
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 02:09:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EC2360184;
 Wed, 11 Aug 2021 02:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628647734;
 bh=3S2tMeEv9IRqGtcTdirfmJcSlo7WSmHQLt2P2gsdJzg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fO8/3/o3xQw3bG2kdDlIT+Pb9Db/amqnbIrfRaqBTmezaJXU6prnfXIZTnyOwPTrV
 uj0Cfsq+iMe5Vf2cGRwv2HHITOALaEZunnQNQfW6tMJxyk9FW9fWIh2X73Vq3Zjp1G
 LZC76xBDNouyzCKEAMFv196CZESPb02PeY89p7wRroZKpaf51ynRtkZZSzPJuJC5Es
 rNJAixjepFJHEa5SEkiLqHtV0nq6PdLUP7NtRkHJ2AbZmTG/aGL2fz/Ibm7DPqZe7V
 xWwDW1UGKStuiF8GRIOY7EGFSzgTxY1IJGDfRCiZo8gRYUBgF+X7XCnw2OtHDpL8nf
 YXLgVJoo90ZLg==
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20210810132707.349147-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <de86a973-947c-d764-dac4-1f3da19980b5@kernel.org>
Date: Wed, 11 Aug 2021 10:08:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810132707.349147-1-frank.li@vivo.com>
Content-Language: en-US
X-Headers-End: 1mDdfw-0007uW-AB
Subject: Re: [f2fs-dev] [PATCH] f2fs: correct comment in segment.h
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

On 2021/8/10 21:27, Yangtao Li wrote:
> s/two/three
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
