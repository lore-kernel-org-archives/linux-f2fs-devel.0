Return-Path: <SRS0=FIBF=NP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001CEC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Aug 2021 06:21:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF306101C;
	Tue, 24 Aug 2021 06:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEF306101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mIPoC-0007CZ-Ca; Tue, 24 Aug 2021 06:21:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mIPoA-0007CS-LY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 06:21:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CXSbZMYiCQoxkzltTxQQRw+UfOox1ZJHqfOgECRkSSs=; b=VAW+3greRjq3SEhSfzbMelx8Rh
 2TVpDKLbsyOiRQYJkOBJXEsUGxRH77y8ac6+4DY4/AcrP/xqJghaT4fwsy8iLfVcCn33g1eHELSRl
 WmLpmKI0KJiatcV1gsgAxa8gHDOofViVYsncl+1dZLvQw9rJi7JSoP8WM8V5lDP3RCFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CXSbZMYiCQoxkzltTxQQRw+UfOox1ZJHqfOgECRkSSs=; b=CCLOyhp7aaCB0pG0Xn6WPOscBp
 D8mge332/NYaNxRJY4ZN4IzzEZC8InjQj8j8DkRwvXqVGWnlkGap0wrNsoRRSE4UpVC7h7fRf2Vro
 XBrJhWMc4/QQq2czqUMuZDMaqLAlVjLpLJfc2Xfes3Rbt9Ytj9WEEEw2YmuDr8UfZp9E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mIPo9-0003YY-C1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 06:21:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCE6861027;
 Tue, 24 Aug 2021 06:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629786063;
 bh=bL+8jiRZvadmenfA31Udhy/TMRIUStlfq31nSmr/TQE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=qL0cPbHZeqU1SyWmVUnYHj/kL8KHMQlf8rafFgih3hQg5bl9vuWMHnAfyD/JK7Bmp
 xfzQDveTkstSjfNBzKAkMicLI7X6IrP3qHyltCzkKh51w+pOUoP7CwObhP28ZOmE39
 /KH2kAKU/MecL2dEejhjKhD60v/nA8CXyBhNQob/iWqf2l9XoeIjICCts1O76Z1awH
 H+FOQV8+8BCDvsnkkW3tK6c5lxOxqNJp+vBdAGbT0RhGabJGdSD2OyBJQJuInuqNW7
 mMXp7yofmJ/JC9Wx/kMoNPWP1q7gIFrYJpJbPEzjeopN2VAhV7CoT1ErNgGoCsWxh2
 I5+6CyIErkX9Q==
To: Christoph Hellwig <hch@lst.de>,
 Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20210818140651.17181-1-hch@lst.de>
 <20210818140651.17181-3-hch@lst.de>
From: Chao Yu <chao@kernel.org>
Message-ID: <1fb2db25-289b-36d5-a72e-091d7282726c@kernel.org>
Date: Tue, 24 Aug 2021 14:21:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818140651.17181-3-hch@lst.de>
Content-Language: en-US
X-Headers-End: 1mIPo9-0003YY-C1
Subject: Re: [f2fs-dev] [PATCH 02/11] f2fs: simplify f2fs_sb_read_encoding
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Shreeya Patel <shreeya.patel@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/18 22:06, Christoph Hellwig wrote:
> Return the encoding table as the return value instead of as an argument,
> and don't bother with the encoding flags as the caller can handle that
> trivially.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
