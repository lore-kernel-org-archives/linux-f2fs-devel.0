Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84CCC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Nov 2022 12:28:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ot6fQ-0005aX-LG;
	Thu, 10 Nov 2022 12:28:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ot6fM-0005aQ-2h
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Nov 2022 12:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pj3rvrXKs8I7qj3cNSxYUUmAewhfAL62uzhH738PQWg=; b=Jj23nnKqIt4P06kXq2uu2BPPVC
 nFtKgoxkTMz4LKHN9RaYq8GW/jmpLsuOt6ksqIb++RUvQS1ETOMzfoqWnAPbgfwEI1dZiHoOHbpW3
 QelzxEgYic3WWypfa5smLm9/Wl8+zA3wQ9YuRF3YyamUz1qkK+6tHox5Mz1fz4tHv7kY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Pj3rvrXKs8I7qj3cNSxYUUmAewhfAL62uzhH738PQWg=; b=XmVz2GuKVjfoDsPVV94mbn0Ehm
 nyHxsPH4dd3Wz43qyWlBmU4/MGczBGENy5gPT+E1J69QSrJ4k75vRA6a+3JiWhQkqQjLS3qLE1LR5
 gVOP5TfX32ag/ZdDBfRBqCbbgxCSLOsu92Mi0krfOtHIkgbTyfmqffEJ5l06xNabmi0k=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ot6f7-0001tB-CX for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Nov 2022 12:28:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EA71E615C2;
 Thu, 10 Nov 2022 12:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A60EC433D6;
 Thu, 10 Nov 2022 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668083279;
 bh=dJPsCX8eDjFVUPGpFaJpV7q3H2UfKOX6bWrgqDkxFRU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ah91qz/t7Pr9oogamLx9Z+Sz4m74YBlfTeqhAkiBhTlAHNysTFkNkgjmHYw7mNuIf
 MT26yqBMJ9BuvlUd1iCkNc2Rok726R16Ceoaq0fXNpeixgxp1iKvzUz/OtjcQVCRZX
 28F64D7pDL/BGBNJMay3aLzFTMtA+Q+5SBgWYcqfAzAcZtRwLyIUGraYK7Xl9Ry+hG
 mjMIMGJHhDkeD01dD7RkoIL7ov9wOf/nvlLW9WqZN1fYW3MKSpWSVMZK5301dFBUDm
 TtxA+0NVe3C2cy3+pj0KesU08PESR47HL8t8GeVwxOw1kC72GjQIXfD69514KNrmua
 30tmwoto6ia5A==
Message-ID: <11eed25c-d72a-f3d5-2864-ad795bd32968@kernel.org>
Date: Thu, 10 Nov 2022 20:27:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20221031192416.32917-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221031192416.32917-1-daeho43@gmail.com>
X-Headers-End: 1ot6f7-0001tB-CX
Subject: Re: [f2fs-dev] [PATCH v6 1/2] f2fs: correct i_size change for
 atomic writes
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/1 3:24, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to make sure i_size doesn't change until atomic write commit is
> successful and restore it when commit is failed.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
