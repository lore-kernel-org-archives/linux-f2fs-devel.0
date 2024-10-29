Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3E0D5B85E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Oct 2024 01:07:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5ahO-0007Fp-Cv;
	Tue, 29 Oct 2024 01:07:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t5ahM-0007Fh-6O
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 01:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=up1I+v4ZJ7G8bxvpeKAHkEDeBjfU6RcnYyeRVBN3Q44=; b=FvpzYVQmzFyS4nznbX4/BKiiZg
 TGZZYHtOAMY8SS/tnTW7Gb5ak5ujIwv4gNEPsj20aK1wKyLIutdr9WiRBit0ll59oqSsyoLBhCIA2
 c4+UUqKySqmHTAhhVjKulMo9nw5uZeXL3eurNrhEAstIJvbnf6q0EC76VYOpIJO1Qifk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=up1I+v4ZJ7G8bxvpeKAHkEDeBjfU6RcnYyeRVBN3Q44=; b=ZvdEGdVrUC836Ijm6UDmo4fY/X
 uyTrlnvn134Eas0cU4ANv3lc2U/UexjJeUrVjd7u9g14V/aBH1S06D8WggQcpaINgyvhu+15aVfzD
 Tv/PIofx6FqWlGV2lHAa7/1o5eo+vBcz1/LXJ50i+Mlp32+GFx8huQhL+Akr7fQuh/IA=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t5ahL-0004Yu-0O for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 01:07:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3A860A40EE2;
 Tue, 29 Oct 2024 01:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62711C4CEC3;
 Tue, 29 Oct 2024 01:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730164016;
 bh=yyGt2lFd7eUrhzUDgQyOyxt36TVANJJ8Zc2Ulyj2GhI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=C8u6Lis8Hm5wbQ/FId2JzudFCPrxOueupnHOxGnhIj2pOcPy3eGM4nKs1wp6JCQrV
 3pjxk+I79ZHilqheA5F1n8qwh4NrmvdLOD+coylUMikKgRXUuXBdhiL9UiM8BGhMpV
 /pmnU1eR7Uhk+8rj/U79lUCjva+K5PIlE0L9anuMtYHfO1lRak1Xleb3e3accSJaF9
 ajBotaEXZauUUK//UEpA7lSISkLUNFK0im2ZDGg0K6RVFeCEM7IaSc/b0+TOW5cr/+
 b55I/XlqDMU9qC0e44OCj74VyVHVRo/SAfzLVq2vYiHrDnQH/RBEDuJDOb4TAjThCL
 hYcU8rMpaAOmA==
Message-ID: <26177c11-43eb-4fb1-8127-857b36113209@kernel.org>
Date: Tue, 29 Oct 2024 09:06:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrew Kreimer <algonell@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241027140623.24802-1-algonell@gmail.com>
Content-Language: en-US
In-Reply-To: <20241027140623.24802-1-algonell@gmail.com>
X-Headers-End: 1t5ahL-0004Yu-0O
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix typos
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/27 22:06, Andrew Kreimer wrote:
> Fix typos: datas -> data.
> 
> Via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
