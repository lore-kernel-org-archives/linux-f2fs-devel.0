Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AC7C55162
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 03:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vh/7AdZifgSAgHoUrUXKHCJeZO8TljvhsMyA1iqoghg=; b=cJfLAT9fniETW7jJCJPbrbkgc2
	rL6QOveLsil1zoTBEXoygO035vK+ZEF6WpsH/3J9+5ctLPCxkZ17CcVUbfjWa5x12QxMQhv6IQK3g
	AqgXtHvaIi9QtkX/e00fYXUB4fT5b5QfbGX/3ncGwg0+ZgFiqwQyWxniCjjVKjLvAwkk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqj66-0004pH-F1;
	Mon, 03 Aug 2026 03:12:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqj65-0004pA-NH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 03:12:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mLgTyfjp06VuzJdKqRwdfBH1RxDymkNTrq9wOfnhMGY=; b=NQj24Fq2tPapHVWDVd8HuP8BxH
 K2+pRPYuwwKHxZAnPMBC2I2UkEtInKzrxbXVdRf6wCL6xkMAKQT/9tW+y7EiU8PmsXMh1TCAtlvLZ
 i8PKXLCt4LmVQSlZr7cayuSjYh0mtWEnaA7S9/cFNNYfhWzO0wFZDODmbh4W73Zu+F+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mLgTyfjp06VuzJdKqRwdfBH1RxDymkNTrq9wOfnhMGY=; b=HmPKtQA+IV3lOX9QZP+T3XJcW5
 kuJRIcDVgkm2/UjDEp8RaSWDlFTYivoYokAyg/vpmcu/wvxxffz+zhV2Vig/prXhKGuonHmJDX6+p
 YGRAIzYhMq4b5f+nxbT9Kmq++6iwM17T+wKE/AWFEnzh1aXh63CuO+WfY/99KkM0dsR0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqj68-0006RA-RM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 03:12:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBE6840511;
 Mon,  3 Aug 2026 03:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463B91F000E9;
 Mon,  3 Aug 2026 03:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785726727;
 bh=mLgTyfjp06VuzJdKqRwdfBH1RxDymkNTrq9wOfnhMGY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=GqQKhS4qivs8koCbPh3oJxukRjZIqeUYfk2RGho/0RTFX8GCwoPjTNU0/I2NqCAid
 HO3RLcPsDMDigOVgr8+oiErNTHSIz9fRHAG+7K8JP8EvMmLvaq7ZD0ZsYVaDNp6JhG
 ngO/puoYNdUlEqDVzO4y5dJ8qYidyAWr2lbaRYtQuQLgQ0GVjWVpiHvUf3yHjz1l1S
 ZKJ2L97wvAKKix5VkKDKmJItDlJh/sHK0xy9/FJHeQaeXn1Lzakc9qQgfVvR31xsZb
 Bh6Owf2UCuJwcuzWV7qFCje6c9cEZ6y4qodKTgz1r2L8QHVuUu3KQ/qsFbPgcfqcnY
 wLKnkNdJ2iFXw==
Message-ID: <4d421da7-aa53-4f31-81d8-c03836487f72@kernel.org>
Date: Mon, 3 Aug 2026 11:12:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260630082331.2757376-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260630082331.2757376-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqj68-0006RA-RM
Subject: Re: [f2fs-dev] [PATCH] f2fs: limit recovery filename logging to
 stored length
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/30/26 16:23, Wenjie Qi wrote:
> F2FS stores recovery filenames as a length plus a fixed-size i_name
> buffer.  The buffer is not NUL-terminated, but recover_inode() and
> recover_dentry() print it with %s.
> 
> For a 255-byte filename, recovery logging can read past i_name into the
> following raw inode fields.
> 
> Print the name with a precision bounded by i_namelen and F2FS_NAME_LEN.
> 
> Fixes: f356fe0cba0e ("f2fs: add debug msgs in the recovery routine")
> Cc: stable@kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
