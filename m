Return-Path: <SRS0=VCJL=M2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4140DC432BE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Aug 2021 01:31:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F234760FC2;
	Tue,  3 Aug 2021 01:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F234760FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mAjHi-00030k-HK; Tue, 03 Aug 2021 01:31:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mAjHh-00030Z-NP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Aug 2021 01:31:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hLeNsabUmVWfYIJl8Vi8jOIisznuISe7XSQaEmMUgQo=; b=OAMudjRkIQy/JkjRTZnguTOhJd
 6OLTAwIzczr7thGuYwxQeNZz/5Seb9Zb9zE+SDmrtzmaNDocn8sskcaS/uJUp5aZrUlgGLO1Fib9p
 KNY0gdDcJOp8asoozKE2qMJ1bYhIOJuHsL8TxpLcBsDQZU6ruaER6xAg2HS7fne6B4S0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hLeNsabUmVWfYIJl8Vi8jOIisznuISe7XSQaEmMUgQo=; b=TYtkEdU8+q/eNhmsw8snQ/Itgr
 4XIu4QDpjK2jw+CyD3kQNOz9Nlq6Bu47QwXeYtGnfGIUa4qZrRxSXu3Lu0NGLAAvz2S2t6jtorWfB
 o/0Qn+/bnq6wjlEmDqNBHPKztA/89+LjqTOJau12jvYbwRym27AqCf4Idrmfb0pFqwCA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mAjHg-00AhQt-MD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Aug 2021 01:31:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAC3160F48;
 Tue,  3 Aug 2021 01:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627954310;
 bh=axpOchdr5vlkrhvkDUEdjCDRs8DN3pSH05qYR6dKJOA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=SUBfynMUq3I+JJ7il44iw4gcmWdwVhArW47qDaJKzcUVB/Banti8XtS1E9+6Gdb6e
 f+gKajdTxapUVsRl3fIryZ5+WHrLHvkmaQyKEj8MQtjssupponON/Ib9d1M+b1xVPN
 Uo31/RGqzDw3m/7Wt7uc/z4z54yvxTnm3UJqfaRbpzEY0q3Zukr073Qa4vHK+Yjnz9
 cFZE3zOnBjSzgFZWunEvqA0J7Nna8evSruh5iOZ8oOpVYAZC0jJn8FC1yzxcG4w+NS
 8FKzfdPdYJHEfC3dOf9Vqg1EF+g5KFoAowJ/z/ITyordquqc1XokOsOaSe6fJkFZyV
 q0rwh2lXVhhEw==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210707015815.1978-1-chao@kernel.org>
 <YQRQ4kHvdRTBnb10@google.com>
 <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
 <YQgziuikMr0fvlT7@google.com>
 <3256dc39-2a82-cb60-038b-69e262c32d18@kernel.org>
 <YQia9FBvQIRgr6cm@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <88858001-d5e0-257f-0b8f-97906ddfc43f@kernel.org>
Date: Tue, 3 Aug 2021 09:31:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQia9FBvQIRgr6cm@google.com>
Content-Language: en-US
X-Headers-End: 1mAjHg-00AhQt-MD
Subject: Re: [f2fs-dev] [RFC NO MERGE] f2fs: extent cache: support unaligned
 extent
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/3 9:25, Jaegeuk Kim wrote:>> Please check description in patch message, now it was designed only for
>                                                   --
>                                                   what do you refer "it"?

Oh...I mean this feature I proposed: unaligned extent support.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
