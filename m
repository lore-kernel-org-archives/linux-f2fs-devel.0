Return-Path: <SRS0=8R1c=FJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B9C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Dec 2020 01:25:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CDA22D75;
	Sat,  5 Dec 2020 01:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CDA22D75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1klMJo-0007jx-JC; Sat, 05 Dec 2020 01:25:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1klMJm-0007jU-IL
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 05 Dec 2020 01:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bD0DiImEVlgEWrAW+ipaV6kAVV3otDJBadBIPyPorQs=; b=gm5f8Xfyi/htr8k2tREY1jSjic
 gXuhrofoOZpDWtDtDmMPOueK0QDvhliDtx1ot7C4Lulp0GNzp4ty4e7fcB7qmHBhvcA38PnDbg2C0
 W9Dhfhr/kZEAyIOGgf8Q5RgPyfSmEEFjkefrdEhl/bx3nIpgiE5ZiZ5yCFk8VCNQzoO8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bD0DiImEVlgEWrAW+ipaV6kAVV3otDJBadBIPyPorQs=; b=f3svsunCkiPoeTFD3b81lZp83e
 fDQnt0UT0fJMELqHpTFyOoJhJ3PmUsJvwqr8RcQ8pvi8g0uzoGiA3yMgFnx32Fs8AsjQWa0QkAWiM
 wzN51/JTBp1DravtGc3oayw+zndejI3Hb6mN4qul3PjZxrCiFq0HKYAgCcfa64RYlpBs=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1klMJi-002XHw-1j
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 05 Dec 2020 01:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607131480;
 bh=AtPUHOpHifjIG0tNWMDfawxqAFqBz8TWWYRbtrNwnXE=;
 h=To:Cc:References:From:Date:In-Reply-To:From;
 b=Ma9x1jBF6INcT4TZ4ExEq+/fG9vmLT6PPb0sA05nrpru5V6px/ONF9RfEdHOA0PoY
 vtmgjIDZLDuB8FT0yXYOr9HJsC6xfXY3CNpVLCloeGn1C2oTTC8CmD7GdrVfDx095w
 h3qW9EmWyixpNU7QfPw5pfP2CrLFLiVBk4Rm7Sq6KBIGiOXEJ8th3HWup5RVNYZEdZ
 rjoLm7D3uBpq3pbSAcEPZp4/vf/B/Zggbpg6LaInNhOSfgNc6561Kvr+sBkjY9POq9
 QrqrK/gS8CDuyk7CaTIuY2k3o7kPRBkypo1CpgX4OAQsM3Ybzzhswtwyw2WhCfjw5E
 MIR79Llhp5IqQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20201202145018.6505-1-chao@kernel.org>
 <X8qJKC/lKRfh/+8s@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <a6fa096d-7cf3-8b39-4a40-6ba1e4613634@kernel.org>
Date: Sat, 5 Dec 2020 09:24:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X8qJKC/lKRfh/+8s@google.com>
Content-Language: en-US
X-Headers-End: 1klMJi-002XHw-1j
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: compress: add compress_inode to
 cache compressed blocks
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

On 2020/12/5 3:08, Jaegeuk Kim wrote:
> Chao, could you please rebase this patch?

Sure.

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
